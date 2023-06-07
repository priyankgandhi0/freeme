
import 'dart:convert';

List<PaidByModel> paidByFromJson(dynamic str) {
  return (str as List).map((e) => PaidByModel.fromJson(e)).toList();
}

class PaidByModel {

  PaidByModel.fromJson(dynamic json) {
    _paidById = json['paid_by_id'];
    _paidByName = json['paid_by_name'];
  }
  num? _paidById;
  String? _paidByName;

  num? get paidById => _paidById;
  String? get paidByName => _paidByName;


}