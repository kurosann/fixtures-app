
import 'package:fixtures/model/ItemModel.dart';
import 'package:fixtures/service/base/HttpManager.dart';

mixin ItemMixin {

  /// get
  void getItem(
      {required ItemModel params,
        required SuccessCallBack successCallBack,
        ErrorCallBack? errorCallBack}) async {
    BaseNet.instance.get(
        url: '/api/v1/appItem/list',
        // 不是map需序列化为map
        params: params.toJson(),
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }
}
