
//class HttpLog {
//
//  @override
//  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//    super.onRequest(options, handler);
//    print("\n ---------Start Http Request---------");
//    print("Request_BaseUrl:${options.baseUrl}");
//    print("Request_Path:${options.path}");
//    print("Request_Method:${options.method}");
//    print("Request_Headers:${options.headers}");
//    print("Request_Data:${options.data}");
//    print("Request_QueryParameters:${options.queryParameters}");
//    print("---------End Http Request---------");
//  }
//
//  @override
//  void onResponse(Response response, ResponseInterceptorHandler handler) {
//    onResponse(response, handler);
//    print("---------Start Http Response---------");
//    print("Response_BaseUrl:${response.realUri}");
//    print("Response_StatusCode:${response.statusCode}");
//    print("Response_StatusMessage:${response.statusMessage}");
//    print("Response_Headers:${response.headers.toString()}");
//    print("---------End Http Response---------");
//  }
//}
