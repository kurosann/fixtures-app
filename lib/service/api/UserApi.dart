import 'package:fixtures/service/base/HttpManager.dart';

mixin UserApi {
  /// 获取用户信息
  getProfile(
      {required SuccessCallBack successCallBack,
      ErrorCallBack? errorCallBack}) async {
    return BaseNet.instance.get(
        url: '/api/v1/appUser/getProfile',
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }
}
