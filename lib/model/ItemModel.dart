
/// demo 实体
class ItemModel {
  int? id;
  String? itemName;

  ItemModel({this.id,this.itemName});

  /// 调用该工厂可生成从json转化Model
  factory ItemModel.fromJson(Map<String, dynamic> json) => _fromJson(json);

  static ItemModel _fromJson(Map<String, dynamic> json) {
    return ItemModel()
      ..id = json["id"]
      ..itemName = json["itemName"];
  }

  /// 调用该函数可从实体转化为json
  Map<String, dynamic> toJson() => {
    'id': id,
    'itemName': itemName
  };
}

/// 序列化解析list
List<ItemModel> getEntityList(List<dynamic> list) {
  List<ItemModel> result = [];
  list.forEach((item) {
    result.add(ItemModel.fromJson(item));
  });
  return result;
}
