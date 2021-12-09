import 'package:dio/dio.dart';
import 'package:fixtures/ApiConfig.dart';
import 'package:fixtures/api/interceptor/AuthInterceptor.dart';
import 'package:fixtures/api/interceptor/ErrorInterceptor.dart';
import 'package:fixtures/api/interceptor/HttpLog.dart';

class BaseHttp {
  factory BaseHttp() => _getInstance();

  static BaseHttp? _instance;

  static BaseHttp get instance => _getInstance();

  static BaseHttp _getInstance() {
    if (_instance == null) {
      _instance = new BaseHttp._internal();
    }
    return _instance!;
  }

  Dio? dio;
  BaseOptions? options;

  BaseHttp._internal() {
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
}
