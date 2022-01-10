import 'package:fixtures/service/base/HttpManager.dart';

mixin LoginMixin {
  // 入参为实体需要转json
  void userLogin(
      {required LoginModel params,
      required SuccessCallBack successCallBack,
      ErrorCallBack? errorCallBack}) async {
    BaseNet.instance.get(
        url: '/goods/category',
        // 不是map需序列化为map
        params: params.toJson(),
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  void register(
      {Map? params,
      required SuccessCallBack successCallBack,
      ErrorCallBack? errorCallBack}) async {
    BaseNet.instance.post(
        url: '/goods/category',
        params: params,
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }
}

class LoginModel {
  String username;
  String? password;

  LoginModel({required this.username, this.password});

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };
}
