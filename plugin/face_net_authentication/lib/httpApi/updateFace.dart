import 'dart:io';

import 'package:face_net_authentication/utils/HttpManager.dart';

mixin FaceMixin {
  /// PostFile
  postFace(
      { params,
        required SuccessCallBack successCallBack,
        ErrorCallBack? errorCallBack}) async {
    return BaseNet.instance.post(
        url:"/api/v1/appMasterApply/image",
        params: params,
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }
}
