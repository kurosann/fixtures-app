
//class ErrorInterceptor extends Interceptor {
//
//  @override
//  void onError(DioError error, ErrorInterceptorHandler handler) async {
//    super.onError(error,handler);
//    print(error);
//    //判读异常状态  401未登录过期或者未登录状态的异常
////    if (error.response != null && error.response!.statusCode == 401) {
////      String token = await SharedPreferencesUtil.getData(Constants.ACCESS_TOKEN);//获取本地存储的Token
////      if (token != null && token.trim() != '') {//Token存在则说明Token过期需要刷新，否则是未登录状态不做处理
////        Dio dio = BaseHttp.instance.dio!;//获取应用的Dio对象进行锁定  防止后面请求还是未登录状态下请求
////        dio.lock();
////        String accessToken = await getToken();//重新获取Token
////        dio.unlock();
////        if (accessToken != '') {
////          Dio tokenDio2 = new Dio(BaseHttp.instance.dio!.options); //创建新的Dio实例
////          var request = error.requestOptions;
////          request.headers['Authorization'] = 'JWT $accessToken';
////          var response = await tokenDio2.request(request.path,
////              data: request.data,
////              queryParameters: request.queryParameters,
////              cancelToken: request.cancelToken,
////              onReceiveProgress: request.onReceiveProgress);
////        }
////      }
////    }
//  }
//  Future<String> getToken() async {
//    //获取当前的refreshToken，一般后台会在登录后附带一个刷新Token用的reToken
//    String refreshToken =
//    await SharedPreferencesUtil.getData(ApiConfig.REFRESH_TOKEN);
//    //因为App单例的Dio对象已被锁定，所以需要创建新的Dio实例
//    Dio tokenDio = new Dio(BaseNet.instance.dio!.options);
//    Map<String, String> map = {
//      "rft": refreshToken,
//    }; //设置当前的refreshToken
//    try {
//      //发起请求，获取Token
//      var response = await tokenDio.post("/api/v1/user/refresh_token", data: map);
////      if (response.statusCode == 201) {
////        LoginBean loginbean = LoginBean.fromJson(response.data);
////        SharedPreferencesUtil.putData(Constants.ACCESS_TOKEN, loginbean.data.token);
////        if (loginbean.data.rft != null && loginbean.data.rft.trim() != '') {
////          SharedPreferencesUtil.putData(Constants.REFRESH_TOKEN, loginbean.data.rft);
////        }
////        return loginbean.data.token;
////      }
//      return '';
//    } on DioError catch (e) {
//      print("Token刷新失败:$e");
//      SharedPreferencesUtil.putData(ApiConfig.ACCESS_TOKEN, '');
//      SharedPreferencesUtil.putData(ApiConfig.REFRESH_TOKEN, '');
//      return '';
//    }
//  }
//}
