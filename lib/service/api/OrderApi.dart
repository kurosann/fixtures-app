import 'package:fixtures/service/base/HttpManager.dart';

mixin OrderApi {
  /// 获取工程订单
  getWorkOrder(
      {
      required SuccessCallBack successCallBack,
      ErrorCallBack? errorCallBack}) async {
    return BaseNet.instance.get(
        url: '/api/v1/appWorkOrder',
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }
}
