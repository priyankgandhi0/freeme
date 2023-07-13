import 'dart:convert';

List<UnionTradeModel> unionTradeModelFromJson(dynamic str) {
  return (str as List).map((e) => UnionTradeModel.fromJson(e)).toList();
}

String unionTradeModelToJson(UnionTradeModel data) =>
    json.encode(data.toJson());

class UnionTradeModel {
  UnionTradeModel({
    num? unionTradeId,
    String? unionTradeTitle,
    String? unionTradeDescription,
  }) {
    _unionTradeId = unionTradeId;
    _unionTradeTitle = unionTradeTitle;
    _unionTradeDescription = unionTradeDescription;
  }

  UnionTradeModel.fromJson(dynamic json) {
    _unionTradeId = json['union_trade_id'];
    _unionTradeTitle = json['union_trade_title'];
    _unionTradeDescription = json['union_trade_description'];
  }

  num? _unionTradeId;
  String? _unionTradeTitle;
  String? _unionTradeDescription;

  UnionTradeModel copyWith({
    num? unionTradeId,
    String? unionTradeTitle,
    String? unionTradeDescription,
  }) =>
      UnionTradeModel(
        unionTradeId: unionTradeId ?? _unionTradeId,
        unionTradeTitle: unionTradeTitle ?? _unionTradeTitle,
        unionTradeDescription: unionTradeDescription ?? _unionTradeDescription,
      );

  num? get unionTradeId => _unionTradeId;

  String? get unionTradeTitle => _unionTradeTitle;

  String? get unionTradeDescription => _unionTradeDescription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['union_trade_id'] = _unionTradeId;
    map['union_trade_title'] = _unionTradeTitle;
    map['union_trade_description'] = _unionTradeDescription;
    return map;
  }
}
