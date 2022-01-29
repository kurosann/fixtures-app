import 'package:fixtures/model/IdCardModel.dart';
import 'package:fixtures/service/base/HttpManager.dart';

mixin IdCardApi {

  /// 获取工程订单
  getIdCard({
    required SuccessCallBack successCallBack,
    ErrorCallBack? errorCallBack}) async {
    return BaseNet.instance.get(
        url: '/api/v1/appBankCard/getCard',
        params: {},
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

  void postIdCard({
    required IdCardModel params,
    required SuccessCallBack successCallBack,
    ErrorCallBack? errorCallBack}) async {
    return BaseNet.instance.post(
        url: '/api/v1/appBankCard/insert',
        // 不是map需序列化为map
        params: params.toJson(),
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }
}
