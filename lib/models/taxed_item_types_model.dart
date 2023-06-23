import 'dart:convert';

List<TaxedItemTypesModel> taxedItemTypesModelFromJson(dynamic str) {
  return (str as List).map((e) => TaxedItemTypesModel.fromJson(e)).toList();
}

class TaxedItemTypesModel {
  TaxedItemTypesModel.fromJson(dynamic json) {
    _taxedItemId = json['taxed_item_id'];
    _taxedItem = json['taxed_item'];
  }

  int? _taxedItemId;
  String? _taxedItem;

  int? get taxedItemId => _taxedItemId;

  String? get taxedItem => _taxedItem;
}
