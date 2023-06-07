import 'dart:convert';

List<TypeModel> typeModelFromJson(dynamic str){
  return (str as List).map((e)=>TypeModel.fromJson(e)).toList();
}

class TypeModel {

  TypeModel.fromJson(dynamic json) {
    _typeId = json['type_id'];
    _type = json['type'];
  }

  num? _typeId;
  String? _type;

  num? get typeId => _typeId;
  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type_id'] = _typeId;
    map['type'] = _type;
    return map;
  }

}