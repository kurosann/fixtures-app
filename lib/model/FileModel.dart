

import 'dart:io';

/// demo 实体
class FileModel {
  String? domain;
  String? type;
  File? file;

  FileModel({this.domain,this.type,this.file});

  /// 调用该工厂可生成从json转化Model
  factory FileModel.fromJson(Map<String, dynamic> json) => _fromJson(json);

  static FileModel _fromJson(Map<String, dynamic> json) {
    return FileModel()
      ..domain = json["domain"]
      ..type = json["type"]
      ..file = json["file"];
  }

  /// 调用该函数可从实体转化为json
  Map<String, dynamic> toJson() => {
    'domain': domain,
    'type': type,
    'file': file,
  };
}

/// 序列化解析list
List<FileModel> getEntityList(List<dynamic> list) {
  List<FileModel> result = [];
  list.forEach((item) {
    result.add(FileModel.fromJson(item));
  });
  return result;
}
