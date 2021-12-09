import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String accessToken = await SharedPreferencesUtil.getData(Constants.ACCESS_TOKEN);
    if (accessToken != '') {
      options.headers['content-type'] = 'application/json;charset=utf-8';
      options.headers['Authorization'] = 'JWT $accessToken';
    }
  }

}

class SharedPreferencesUtil {
  static dynamic getData(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.get(key);
  }

  static void putData(String key, String value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  }
}

class Constants {
  static const ACCESS_TOKEN = "Authorization";

  static const String REFRESH_TOKEN = "ReAuthorization";

}