import 'package:fixtures/service/base/HttpManager.dart';

/// 此部分为模板 复制粘贴即可 使用with实现该mixin即可调用接口
mixin DemoMixin {
  /// get1
  demo1(
      {required DemoModel params,
      required SuccessCallBack successCallBack,
      ErrorCallBack? errorCallBack}) async {
    return BaseNet.instance.get(
        url: '/goods/category',
        // 不是map需序列化为map
        params: params.toJson(),
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  /// get2
  demo2(
      {Map<String, dynamic>? params,
      required SuccessCallBack successCallBack,
      ErrorCallBack? errorCallBack}) async {
    return BaseNet.instance.get(
        url: '/goods/category',
        params: params,
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  /// post
  demo3(
      {required DemoModel params,
      required SuccessCallBack successCallBack,
      ErrorCallBack? errorCallBack}) async {
    return BaseNet.instance.post(
        url: '/api/v1/app-login/login/sms',
        // 不是map需序列化为map
        params: params.toJson(),
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }
}

/// demo 实体
class DemoModel {
  String? username;
  String? password;

  DemoModel({this.username, this.password});

  /// 调用该工厂可生成从json转化Model
  factory DemoModel.fromJson(Map<String, dynamic> json) => _fromJson(json);

  static DemoModel _fromJson(Map<String, dynamic> json) {
    return DemoModel()
      ..username = json["username"]
      ..password = json["password"];
  }

  /// 调用该函数可从实体转化为json
  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };
}

/// 序列化解析list
List<DemoModel> getEntityList(List<dynamic> list) {
  List<DemoModel> result = [];
  list.forEach((item) {
    result.add(DemoModel.fromJson(item));
  });
  return result;
}
