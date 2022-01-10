import 'dart:convert';

import 'package:fixtures/ApiConfig.dart';
import 'package:fixtures/utils/SharedPreferencesUtil.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

typedef ErrorCallBack = Function(int code, String msg);
typedef SuccessCallBack = Function(dynamic data);

typedef AuthInterceptor = Future<Map<String, String>>? Function(
    Map<String, String> header);

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
  /// 鉴权拦截器 返回null终止请求
  AuthInterceptor? _authInterceptor;

  Map<String, String> headers = {
    "Content-Type": "application/json",
    ApiConfig.ACCESS_TOKEN: ""
  };

  BaseNet._internal() {
    _authInterceptor = (Map<String, String> header) async {
      String? accessToken = await SharedPreferencesUtil.getData(ApiConfig.ACCESS_TOKEN);
      if (accessToken != null && accessToken != '') {
        headers['content-type'] = 'application/json;charset=utf-8';
        headers[ApiConfig.ACCESS_TOKEN] = 'JWT $accessToken';
      }
      /// 拦截内容
      return header;
    };
  }

  //get请求
  get(
      {required String url,
      params,
      required SuccessCallBack successCallBack,
      ErrorCallBack? errorCallBack}) async {
    _requestHttp(url, successCallBack,
        method: 'get', params: params, errorCallBack: errorCallBack);
  }

  //post请求
  post(
      {required String url,
      params,
      required SuccessCallBack successCallBack,
      ErrorCallBack? errorCallBack}) async {
    params = json.encode(params);
    _requestHttp(url, successCallBack,
        method: 'post', params: params, errorCallBack: errorCallBack);
  }

  _requestHttp(String url, SuccessCallBack successCallBack,
      {String? method, Map? params, ErrorCallBack? errorCallBack}) async {
    Response? response;
    String uriParams = "";
    if (_authInterceptor != null) {
      Map<String, String>? t = await _authInterceptor!(headers);
      if (t == null) return;
      headers = t;
    }
    try {
      if (method == 'get') {
        if (params == null && params!.keys.length == 0) {
          params = {};
        } else {
          uriParams = "?";
          params.forEach((key, value) {
            uriParams += key + '=' + value.toString() + '&';
          });
          uriParams = uriParams.substring(0, uriParams.length - 1);
        }
        var uri = Uri.parse(ApiConfig.BASE_URL + url + uriParams);
        print(uri.toString());
        response = await http.get(uri, headers: headers);
      } else if (method == 'post') {
        var uri = Uri.parse(ApiConfig.BASE_URL + url + uriParams);
        if (params == null && params!.keys.length == 0) {
          params = {};
        }
        response = await http.post(uri,
            headers: headers, body: params, encoding: Utf8Codec());
      }
    } catch (error) {
      // debug模式才打印
      if (ApiConfig.isDebug) {
        print('请求异常: ' + error.toString());
        print('请求异常url: ' + ApiConfig.BASE_URL + url + uriParams);
        print('请求头: ' + headers.toString());
        print('method: ' + method!);
      }
      _error(errorCallBack, error.toString(), 500);
      return '';
    }
    // debug模式打印相关数据
    if (ApiConfig.isDebug) {
      print('请求url: ' + url);
      print('请求头: ' + headers.toString());
      if (params != null) {
        print('请求参数: ' + params.toString());
      }
      if (response != null) {
        print('返回参数: ' + json.decode(response.body).toString());
      }
    }
    if (response == null) {
      print('response:null');
    }
    Result dataMap = Result.fromJson(json.decode(response!.body));
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

class Result {
  int? status;
  String? msg;
  dynamic data;

  Result.fromJson(Map<String, dynamic> json) {
    status = json["state"] != null ? json["state"] : -1;
    msg = json["msg"] != null ? json["msg"] : "";
    data = json["data"] != null ? json["data"] : "";
  }
}

mixin FromJson {
  fromJson(Map<String, dynamic> json);
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
