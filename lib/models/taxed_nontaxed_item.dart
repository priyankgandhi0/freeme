class TaxedNonTaxedModel {
  String? type;
  String? amount;
  int? timeId;
  num? id;
  String? taxedTypeNote;
  num? taxedItemId;
  String? timeDesc;

  Map<String, dynamic> toTaxedJson() {
    final map = <String, dynamic>{};
    map['taxes_id'] = id;
    map['taxt_type'] = type;
    map['taxt_amount'] = amount;
    map['tax_per_time_id'] = timeId;
    map['taxed_item_id'] = taxedItemId;
    map['taxed_type_note'] = taxedTypeNote;
    return map;
  }

  Map<String, dynamic> toNonTaxedJson() {
    final map = <String, dynamic>{};
    map['non_taxes_id'] = id;
    map['non_taxt_type'] = type;
    map['non_taxt_amount'] = amount;
    map['tax_per_time_id'] = timeId;
    map['taxed_item_id'] = taxedItemId;
    map['taxed_type_note'] = taxedTypeNote;
    return map;
  }

  TaxedNonTaxedModel({
    this.type,
    this.amount,
    this.timeId,
    this.id,
    this.taxedTypeNote,
    this.taxedItemId,
    this.timeDesc,
  });
}
