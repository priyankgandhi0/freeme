import 'dart:convert';

List<IndustryModel> allIndustryList(dynamic json){
  return (json as List).map((e) => IndustryModel.fromJson(e)).toList();
}

class IndustryModel {
  IndustryModel({
    num? industryId,
    String? industryName,
  }) {
    _industryId = industryId;
    _industryName = industryName;
  }

  IndustryModel.fromJson(dynamic json) {
    _industryId = json['industry_id'];
    _industryName = json['industry_name'];
  }

  num? _industryId;
  String? _industryName;

  num? get industryId => _industryId;

  String? get industryName => _industryName;
}
