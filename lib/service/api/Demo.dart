import 'package:fixtures/service/base/HttpManager.dart';

mixin DemoMixin {
  void demo1(
      {required DemoModel params,
      required SuccessCallBack successCallBack,
      ErrorCallBack? errorCallBack}) async {
    BaseNet.instance.get(
        url: '/goods/category',
        // 不是map需序列化为map
        params: params.toJson(),
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  void demo2(
      {Map? params,
      required SuccessCallBack successCallBack,
      ErrorCallBack? errorCallBack}) async {
    BaseNet.instance.get(
        url: '/goods/category',
        params: params,
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  void testCall() {
    demo1(
      params: DemoModel(username: "admin", password: "123456"),
      successCallBack: (data) {
        print(data.username);
        print(data.password);
      },
      errorCallBack: (code, err) {},
    );
  }
}

class DemoModel {
  String? username;
  String? password;

  DemoModel({this.username, this.password});

  factory DemoModel.fromJson(Map<String, dynamic> json) => _fromJson(json);

  static DemoModel _fromJson(Map<String, dynamic> json) {
    return DemoModel()
      ..username = json["username"]
      ..password = json["password"];
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };
}

List<DemoModel> getEntityList(List<dynamic> list) {
  List<DemoModel> result = [];
  list.forEach((item) {
    result.add(DemoModel.fromJson(item));
  });
  return result;
}
