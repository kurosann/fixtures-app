
/// demo 实体
class PersonalModel {
  String? nickName;
  String? headPortrait;
  int? sex;
  String? birthday;
  String? location;
  String? phone;
  String? idNumber;
  String? uName;


  PersonalModel({this.nickName,
    this.headPortrait,
    this.sex,
    this.birthday,
    this.location,
    this.phone,
    this.idNumber,
    this.uName});

  /// 调用该工厂可生成从json转化Model
  factory PersonalModel.fromJson(Map<String, dynamic> json) => _fromJson(json);

  static PersonalModel _fromJson(Map<String, dynamic> json) {
    return PersonalModel()
      ..nickName = json["nickName"]
      ..headPortrait = json["headPortrait"]
      ..sex = json["sex"]
      ..birthday = json["birthday"]
      ..location = json["location"]
      ..phone = json["phone"]
      ..idNumber = json["idNumber"]
      ..uName = json["uName"];
  }

  /// 调用该函数可从实体转化为json
  Map<String, dynamic> toJson() => {
    'nickName': nickName,
    'headPortrait': headPortrait,
    'sex': sex,
    'birthday': birthday,
    'location': location,
    'phone': phone,
    'idNumber': idNumber,
    'uName': uName,
  };
}

/// 序列化解析list
List<PersonalModel> getEntityList(List<dynamic> list) {
  List<PersonalModel> result = [];
  list.forEach((item) {
    result.add(PersonalModel.fromJson(item));
  });
  return result;
}
