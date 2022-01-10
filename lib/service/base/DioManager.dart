import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fixtures/ApiConfig.dart';
import 'package:fixtures/service/interceptor/AuthInterceptor.dart';
import 'package:fixtures/service/interceptor/ErrorInterceptor.dart';
import 'package:fixtures/service/interceptor/HttpLog.dart';

typedef ErrorCallBack = Function(int code, String msg);
typedef SuccessCallBack<T> = Function(T data);

class BaseNet {
  factory BaseNet() => _getInstance();

  static BaseNet? _instance;

  static BaseNet get instance => _getInstance();

  static BaseNet _getInstance() {
    if (_instance == null) {
      _instance = new BaseNet._internal();
    }
    return _instance!;
  }

  Dio? dio;
  BaseOptions? options;

  BaseNet._internal() {
    dio = Dio()
      ..options = BaseOptions(
          baseUrl: ApiConfig.BASE_URL,
          connectTimeout: 10000,
          receiveTimeout: 1000 * 60 * 60 * 24,
          responseType: ResponseType.json,
          headers: {"Content-Type": "application/json"})
      //网络状态拦截
      ..interceptors.add(AuthInterceptor())
      ..interceptors.add(HttpLog())
      ..interceptors.add(ErrorInterceptor());
  }

  //get请求
  get<T>(
      {required String url,
      params,
      required SuccessCallBack<T> successCallBack,
      ErrorCallBack? errorCallBack}) async {
    _requestHttp<T>(url, successCallBack,
        method: 'get', params: params, errorCallBack: errorCallBack);
  }

  //post请求
  post<T>(
      {required String url,
      params,
      required SuccessCallBack<T> successCallBack,
      ErrorCallBack? errorCallBack}) async {
    _requestHttp<T>(url, successCallBack,
        method: 'post', params: params, errorCallBack: errorCallBack);
  }

  _requestHttp<T>(String url, SuccessCallBack<T> successCallBack,
      {String? method, params, ErrorCallBack? errorCallBack}) async {
    Response? response;
    if (params == null && params.length < 0) {
      params = {};
    }
    var dio = this.dio!;
    try {
      if (method == 'get') {
        response = await dio.get(url, queryParameters: params);
      } else if (method == 'post') {
        response = await dio.post(url, data: params);
      }
    } on DioError catch (error) {
      // 请求错误处理
      Response errorResponse;
      if (error.response != null) {
        errorResponse = error.response!;
      } else {
        errorResponse =
            Response(requestOptions: response!.requestOptions, statusCode: 500);
      }
      // 请求超时
      if (error.type == DioErrorType.connectTimeout) {
        errorResponse.statusCode = ResultCode.CONNECT_TIMEOUT;
      }
      // 一般服务器错误
      else if (error.type == DioErrorType.receiveTimeout) {
        errorResponse.statusCode = ResultCode.RECEIVE_TIMEOUT;
      }

      // debug模式才打印
      if (ApiConfig.isDebug) {
        print('请求异常: ' + error.toString());
        print('请求异常url: ' + url);
        print('请求头: ' + dio.options.headers.toString());
        print('method: ' + dio.options.method);
      }
      _error(errorCallBack, error.message, 500);
      return '';
    }
    // debug模式打印相关数据
    if (ApiConfig.isDebug) {
      print('请求url: ' + url);
      print('请求头: ' + dio.options.headers.toString());
      if (params != null) {
        print('请求参数: ' + params.toString());
      }
      if (response != null) {
        print('返回参数: ' + response.toString());
      }
    }
    String dataStr = json.encode(response!.data);
    Result<T> dataMap = json.decode(dataStr);
    if (dataMap.status == 200) {
      successCallBack(dataMap.data!);
    } else {
      _error(errorCallBack, dataMap.msg.toString(), dataMap.status!);
    }
  }

  _error(ErrorCallBack? errorCallBack, String msg, int code) {
    if (errorCallBack != null) {
      errorCallBack(code, msg);
    }
  }
}

class Result<T> {
  int? status;
  String? msg;
  T? data;

  Result.fromJson(Map<String, dynamic> json) {
    status = json["state"];
    msg = json["msg"];
    data = json["data"];
  }
}

class ResultCode {
  //正常返回是1
  static const SUCCESS = 1;

  //异常返回是0
  static const ERROR = 0;

  /// When opening  url timeout, it occurs.
  static const CONNECT_TIMEOUT = -1;

  ///It occurs when receiving timeout.
  static const RECEIVE_TIMEOUT = -2;

  /// When the server response, but with a incorrect status, such as 404, 503...
  static const RESPONSE = -3;

  /// When the request is cancelled, dio will throw a error with this type.
  static const CANCEL = -4;

  /// read the DioError.error if it is not null.
  static const DEFAULT = -5;
}
