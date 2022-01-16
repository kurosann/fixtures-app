import 'dart:convert';
import 'dart:io';
import 'package:fixtures/config.dart';
import 'package:http/http.dart' as http;
import 'package:fixtures/model/FileModel.dart';
import 'package:fixtures/service/base/HttpManager.dart';
import 'package:http/http.dart';


mixin FileMixin {
  /// PostFile
  void PostFile(
      {required FileModel params,
      required SuccessCallBack successCallBack,
      ErrorCallBack? errorCallBack}) async {
    BaseNet.instance.post(
        url: '/api/v1/public/uploadFile',
        // 不是map需序列化为map
        params: params.toJson(),
        successCallBack: successCallBack,
        errorCallBack: errorCallBack);
  }
  //上传图片到服务器
  Future<Result> UploadImage(File _imageDir,String domain) async {
    var uri = Uri.parse(Config.BASE_URL+'/api/v1/app/public/uploadFile');
    //创建请求
    var request = http.MultipartRequest("POST", uri);
    //添加请求参数（参数名和参数值，必须为String。int也不行，必须转成String）
    request.fields['domain'] = domain;
    request.fields['type'] = "1";
    //第一个参数对应参数名，第二个参数对应文件地址
    var multipartFile = await http.MultipartFile.fromPath('file', _imageDir.path);
    //文件添加进请求
    request.files.add(multipartFile);
    var response = await request.send();
    Result dataMap = Result();
   // Map<String, dynamic> dataMap;
    if(response.statusCode != 200){
      print('请求异常:    \t' + response.reasonPhrase!);
      print('请求异常url: \t' + Config.BASE_URL + '/api/v1/app/public/uploadFile');
      dataMap = Result.fromJson({'code': response.statusCode,'msg':response.reasonPhrase!,'data':''});
    }else{
      var respStr = await response.stream.transform(utf8.decoder).join();
      var data = json.decode(respStr);
      dataMap = Result.fromJson(data);
    }
   return dataMap;
  }
}
