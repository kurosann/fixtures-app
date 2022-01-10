import 'package:fixtures/service/base/DioManager.dart';

mixin DemoMixin {
  void demo1(
      {required Demo params,
      required Function(DemoModel data) successCallBack,
      Function? errorCallBack}) async {
    BaseNet.instance.get<DemoModel>(
        url: '/xxx/xxx/xxx',
        params: params,
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  void demo2(
      {Map? params,
      required Function(DemoModel data) successCallBack,
      Function? errorCallBack}) async {
    BaseNet.instance.get<DemoModel>(
        url: '/xxx/xxx/xxx',
        params: params,
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }
}

class DemoModel {
  String? username;
  String? password;

  DemoModel.fromJson(Map<String, dynamic> json) {
    username = json["username"];
    password = json["password"];
  }
}

class Demo {
  String username;
  String? password;

  Demo({required this.username, this.password});
}
