import 'dart:convert';




List<TaxPerTimeModel> taxPerTimeModelFromJson(dynamic str) {
  return (str as List).map((e) => TaxPerTimeModel.fromJson(e)).toList();
}


class TaxPerTimeModel {


  TaxPerTimeModel.fromJson(dynamic json) {
    _taxPerTimeId = json['tax_per_time_id'];
    _taxPerTimeCategory = json['tax_per_time_category'];
  }
  num? _taxPerTimeId;
  String? _taxPerTimeCategory;

  num? get taxPerTimeId => _taxPerTimeId;
  String? get taxPerTimeCategory => _taxPerTimeCategory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tax_per_time_id'] = _taxPerTimeId;
    map['tax_per_time_category'] = _taxPerTimeCategory;
    return map;
  }

}