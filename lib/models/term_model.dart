import 'dart:convert';

List<TermModel> termModelFromJson(dynamic str) {
  return (str as List).map((e) => TermModel.fromJson(e)).toList();
}

class TermModel {
  TermModel.fromJson(dynamic json) {
    _termsId = json['terms_id'];
    _term = json['term'];
  }

  num? _termsId;
  String? _term;

  num? get termsId => _termsId;

  String? get term => _term;
}
