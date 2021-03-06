import 'dart:convert';
import 'dart:io';

import 'package:face_net_authentication/config.dart';
import 'package:face_net_authentication/utils/SharedPreferencesUtil.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

typedef ErrorCallBack = void Function(int code, String msg);
typedef SuccessCallBack = void Function(dynamic data);

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

  Map<String, String> headers = {"Content-Type": "application/json"};

  BaseNet._internal() {
    _authInterceptor = (Map<String, String> header) async {
      String? accessToken = await SharedPreferencesUtil.getData(Config.ACCESS_TOKEN);
      if (accessToken != null && accessToken != '') {
        headers['content-type'] = 'application/json;charset=utf-8';
        headers[Config.ACCESS_TOKEN] = '$accessToken';
      }
      /// 拦截内容
      return header;
    };
  }

  //get请求
  get(
      {required String url,
      Map<String, dynamic>? params,
      SuccessCallBack? successCallBack,
      ErrorCallBack? errorCallBack}) async {
    return _requestHttp(url,
        successCallBack: successCallBack,
        method: 'get',
        params: params,
        errorCallBack: errorCallBack);
  }

  //post请求
  post(
      {required String url,
      Map<String, dynamic>? params,
      SuccessCallBack? successCallBack,
      ErrorCallBack? errorCallBack}) async {
    return _requestHttp(url,
        successCallBack: successCallBack,
        method: 'post',
        params: params,
        errorCallBack: errorCallBack);
  }

  _requestHttp(String url,
      {String? method,
      Map<String, dynamic>? params,
      SuccessCallBack? successCallBack,
      ErrorCallBack? errorCallBack}) async {
    Response? response;
    String uriParams = "";
    if (_authInterceptor != null) {
      Map<String, String>? t = await _authInterceptor!(headers);
      if (t == null) return;
      headers = t;
    }
    Result dataMap = Result();
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
        var uri = Uri.parse(Config.BASE_URL + url + uriParams);
        print(uri.toString());
        response = await http.get(uri, headers: headers);
      } else if (method == 'post') {
        var uri = Uri.parse(Config.BASE_URL + url);
        if (params == null && params!.keys.length == 0) {
          params = {};
        }
        response = await http.post(uri,
            headers: headers, body: json.encode(params), encoding: Utf8Codec());
      }
    } catch (error) {
      // debug模式才打印
      if (Config.isDebug) {
        print('请求异常:    \t' + error.toString());
        print('请求异常url: \t' + Config.BASE_URL + url + uriParams);
        print('请求头:      \t' + headers.toString());
        print('请求方式:    \t' + method!);
      }
      dataMap.msg = error.toString();
      dataMap.code = 500;
      _error(errorCallBack, error.toString(), 500);
      return dataMap;
    }
    if (response == null) {
      print('response:null');
      dataMap.msg = 'response为null';
      dataMap.code = 401;
      return dataMap;
    }
    if (response.statusCode != ResultCode.SUCCESS) {
      // debug模式才打印
      if (Config.isDebug) {
        print('请求异常:    \t' + response.reasonPhrase!);
        print('请求异常url: \t' + Config.BASE_URL + url + uriParams);
        print('请求头:      \t' + headers.toString());
        print('请求方式:    \t' + method!);
      }
      dataMap.msg = response.reasonPhrase!;
      dataMap.code = response.statusCode;
      _error(errorCallBack, response.reasonPhrase!, response.statusCode);
      return dataMap;
    }
    // debug模式打印相关数据
    if (Config.isDebug) {
      print('请求url:  \t' + url);
      print('请求头:   \t' + headers.toString());
      print('请求方式: \t' + method!);
      if (params != null) {
        print('请求参数: \t' + params.toString());
      }
      print('返回参数: \t' + json.decode(response.body).toString());
    }
    dataMap = Result.fromJson(json.decode(response.body));
    if (dataMap.code == ResultCode.SUCCESS) {
      if (successCallBack != null) {
        successCallBack(dataMap.data!);
      }
    } else {
      _error(errorCallBack, dataMap.msg.toString(), dataMap.code);
    }
    return dataMap;
  }

  _error(ErrorCallBack? errorCallBack, String msg, int code) {
    if (errorCallBack != null) {
      errorCallBack(code, msg);
    }
  }

  //上传图片到服务器
  uploadImage(File imagPath,
      {Map<String, dynamic>? params,
      SuccessCallBack? successCallBack,
      ErrorCallBack? errorCallBack}) async {
    var uri = Uri.parse(Config.BASE_URL + '/api/v1/app/public/uploadFile');
    //创建请求
    var request = http.MultipartRequest("POST", uri);
    //添加请求参数（参数名和参数值，必须为String。int也不行，必须转成String）
    params?.forEach((key, value) {
      request.fields[key] = value;
    });
    //第一个参数对应参数名，第二个参数对应文件地址
    var multipartFile =
        await http.MultipartFile.fromPath('file', imagPath.path);
    //文件添加进请求
    request.files.add(multipartFile);
    Result dataMap = Result();
    var response = await request.send();
    if (response.statusCode != ResultCode.SUCCESS) {
      // debug模式才打印
      if (Config.isDebug) {
        print('请求异常:    \t' + response.reasonPhrase!);
        print('请求异常url: \t' + uri.toString());
        print('请求头:      \t' + headers.toString());
        print('请求方式:    \tPOST');
      }
      dataMap.msg = response.reasonPhrase!;
      dataMap.code = response.statusCode;
      _error(errorCallBack, response.reasonPhrase!, response.statusCode);
      return dataMap;
    }
    dataMap = Result.fromJson(
        json.decode(await response.stream.transform(utf8.decoder).join()));
    if (dataMap.code == ResultCode.SUCCESS) {
      if (successCallBack != null) {
        successCallBack(dataMap.data!);
      }
    } else {
      _error(errorCallBack, dataMap.msg.toString(), dataMap.code);
    }
    return dataMap;
  }
}

class Result {
  int code = ResultCode.CONNECT_TIMEOUT;
  String? msg;
  dynamic data;

  Result();

  Result.fromJson(Map<String, dynamic> json) {
    code = json["code"] != null ? json["code"] : -1;
    msg = json["msg"] != null ? json["msg"] : "";
    data = json["data"] != null ? json["data"] : "";
  }
}

mixin FromJson {
  fromJson(Map<String, dynamic> json);
}

class ResultCode {
  //正常返回是200
  static const SUCCESS = 200;

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
