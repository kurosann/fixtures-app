
/// demo 实体
class IdCardModel {
  int? id;
  int? userId;
  String? bankName;
  String? bankCardNo;
  String? cardOwner;
  String? idCard;
  String? phone;
  int? treatyState;
  String? remake;

  IdCardModel({
    this.id,
    this.userId,
    this.bankName,
    this.bankCardNo,
    this.cardOwner,
    this.idCard,
    this.phone,
    this.treatyState,
    this.remake
  });

  /// 调用该工厂可生成从json转化Model
  factory IdCardModel.fromJson(Map<String, dynamic> json) => _fromJson(json);

  static IdCardModel _fromJson(Map<String, dynamic> json) {
    return IdCardModel()
      ..userId = json["userId"]
      ..bankName = json["bankName"]
      ..bankCardNo = json["bankCardNo"]
      ..cardOwner = json["cardOwner"]
      ..idCard = json["idCard"]
      ..phone = json["phone"]
      ..treatyState = json["treatyState"]
      ..remake = json["remake"];
  }

  /// 调用该函数可从实体转化为json
  Map<String, dynamic> toJson() => {
    'userId': userId,
    'bankName': bankName,
    'bankCardNo': bankCardNo,
    'cardOwner': cardOwner,
    'idCard': idCard,
    'phone': phone,
    'treatyState': treatyState,
    'remake': remake,
  };
}

/// 序列化解析list
List<IdCardModel> getEntityList(List<dynamic> list) {
  List<IdCardModel> result = [];
  list.forEach((item) {
    result.add(IdCardModel.fromJson(item));
  });
  return result;
}
