
import 'package:fixtures/service/base/HttpManager.dart';

mixin BonusMixin {
  /// get
  getBonusInfo(
      {SuccessCallBack? successCallBack,
        ErrorCallBack? errorCallBack}) async {
    return BaseNet.instance.get(
        url: '/api/v1/appUser/get_bonus',
        // 不是map需序列化为map
        params: {},
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }

}

