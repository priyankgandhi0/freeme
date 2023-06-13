class TaxedNonTaxedModel{
  String? type;
  String? amount;
  String? per;
  num? id;

  TaxedNonTaxedModel({this.type, this.amount, this.per,this.id});

  Map<String, dynamic> toTaxedJson() {
    final map = <String, dynamic>{};
    map['taxes_id'] = id;
    map['taxt_type'] = type;
    map['taxt_amount'] = amount;
    map['taxt_per'] = per;
    return map;
  }

  Map<String, dynamic> toNonTaxedJson() {
    final map = <String, dynamic>{};
    map['non_taxes_id'] = id;
    map['non_taxt_type'] = type;
    map['non_taxt_amount'] = amount;
    map['non_taxt_per'] = per;
    return map;
  }

}