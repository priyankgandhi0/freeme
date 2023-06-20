class TaxedNonTaxedModel{
  String? type;
  String? amount;
  String? per;
  num? id;
  String? taxedTypeNote;
  num? taxedItemId;


  Map<String, dynamic> toTaxedJson() {
    final map = <String, dynamic>{};
    map['taxes_id'] = id;
    map['taxt_type'] = type;
    map['taxt_amount'] = amount;
    map['taxt_per'] = per;
    map['taxed_item_id'] = taxedItemId;
    map['taxed_type_note'] = taxedTypeNote;
    return map;
  }

  Map<String, dynamic> toNonTaxedJson() {
    final map = <String, dynamic>{};
    map['non_taxes_id'] = id;
    map['non_taxt_type'] = type;
    map['non_taxt_amount'] = amount;
    map['non_taxt_per'] = per;
    map['taxed_item_id'] = taxedItemId;
    map['taxed_type_note'] = taxedTypeNote;
    return map;
  }

  TaxedNonTaxedModel(
      {this.type,
      this.amount,
      this.per,
      this.id,
      this.taxedTypeNote,
      this.taxedItemId});
}