
/// demo 实体
class SmsLoginModel {
  String? phone;
  String? password;
  String? smsCode;
  String? invitationCode;

  SmsLoginModel({this.phone,this.password,this.smsCode, this.invitationCode});

  /// 调用该工厂可生成从json转化Model
  factory SmsLoginModel.fromJson(Map<String, dynamic> json) => _fromJson(json);

  static SmsLoginModel _fromJson(Map<String, dynamic> json) {
    return SmsLoginModel()
      ..phone = json["phone"]
      ..password = json["password"]
      ..smsCode = json["smsCode"]
      ..invitationCode = json["invitationCode"];
  }

  /// 调用该函数可从实体转化为json
  Map<String, dynamic> toJson() => {
    'phone': phone,
    'password': password,
    'smsCode': smsCode,
    'invitationCode': invitationCode,
  };
}

/// 序列化解析list
List<SmsLoginModel> getEntityList(List<dynamic> list) {
  List<SmsLoginModel> result = [];
  list.forEach((item) {
    result.add(SmsLoginModel.fromJson(item));
  });
  return result;
}
