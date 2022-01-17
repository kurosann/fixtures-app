import 'dart:io';

import 'package:fixtures/service/base/HttpManager.dart';

mixin FileMixin {
  /// PostFile
  void postFile(
      {required File file,
      params,
      required SuccessCallBack successCallBack,
      ErrorCallBack? errorCallBack}) async {
    BaseNet.instance.uploadImage(file,
        params: params,
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }
}
