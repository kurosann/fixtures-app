import 'package:fixtures/model/PersonalModel.dart';
import 'package:fixtures/service/base/HttpManager.dart';

mixin UserApi {
  /// get
  void getPersonal(
      {required SuccessCallBack successCallBack,
      ErrorCallBack? errorCallBack}) async {
    return BaseNet.instance.get(
        url: '/api/v1/appUser/get_profile',
        // 不是map需序列化为map
        params: {},
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }
  /// post
  void savePersonal(
      {required PersonalModel params,
        required SuccessCallBack successCallBack,
      ErrorCallBack? errorCallBack}) async {
    return BaseNet.instance.post(
        url: '/api/v1/appUser/save_user',
        // 不是map需序列化为map
        params: params.toJson(),
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }
  /// post
  void editRealInfo(
      { params,
        required SuccessCallBack successCallBack,
      ErrorCallBack? errorCallBack}) async {
    return BaseNet.instance.post(
        url: '/api/v1/appMasterApply/info',
        // 不是map需序列化为map
        params: params,
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  void getRealInfo(
      { required SuccessCallBack successCallBack,
        ErrorCallBack? errorCallBack}) async {
    return BaseNet.instance.get(
        url:"/api/v1/appMasterApply/applyInfo",
        params: {},
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }
}
