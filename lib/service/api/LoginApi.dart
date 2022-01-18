import 'package:fixtures/model/LoginModel.dart';
import 'package:fixtures/service/base/HttpManager.dart';

mixin LoginMixin {

  /// post
  loginPwd(
      {required SmsLoginModel params,
        SuccessCallBack? successCallBack,
        ErrorCallBack? errorCallBack}) async {
    return BaseNet.instance.post(
        url: '/api/v1/app-login',
        // 不是map需序列化为map
        params: params.toJson(),
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }
  /// post
  void loginSms(
      {required SmsLoginModel params,
        SuccessCallBack? successCallBack,
        ErrorCallBack? errorCallBack}) async {
    BaseNet.instance.post(
        url: '/api/v1/app-login/login/sms',
        // 不是map需序列化为map
        params: params.toJson(),
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }
  /// post
  void sendLoginSms(
      {required SmsLoginModel params,
        required SuccessCallBack successCallBack,
        ErrorCallBack? errorCallBack}) async {
    BaseNet.instance.post(
        url: '/api/v1/app-login/login/send',
        // 不是map需序列化为map
        params: params.toJson(),
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }
  /// post
  void RegisterSms(
      {required SmsLoginModel params,
        required SuccessCallBack successCallBack,
        ErrorCallBack? errorCallBack}) async {
    BaseNet.instance.post(
        url: '/api/v1/app-login/register/sms',
        // 不是map需序列化为map
        params: params.toJson(),
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }
  /// post
  void sendRegisterSms(
      {required SmsLoginModel params,
        required SuccessCallBack successCallBack,
        ErrorCallBack? errorCallBack}) async {
    BaseNet.instance.post(
        url: '/api/v1/app-login/register/send',
        // 不是map需序列化为map
        params: params.toJson(),
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }
}
