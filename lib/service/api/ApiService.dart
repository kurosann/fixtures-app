import 'dart:convert';

import 'package:fixtures/service/base/DioManager.dart';

mixin DemoMixin {
  void demo1(
      {required Demo params,
      required Function successCallBack,
      Function? errorCallBack}) async {
    BaseNet.instance.get(
        url: '/xxx/xxx/xxx',
        params: params,
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  void demo2(
      {Map? params,
      required Function successCallBack,
      Function? errorCallBack}) async {
    BaseNet.instance.get(
        url: '/xxx/xxx/xxx',
        params: params,
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }
}

class Demo {
  String username;
  String? password;

  Demo({required this.username, this.password});
}
