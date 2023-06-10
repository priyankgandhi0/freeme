class TaxedNonTaxedModel{
  String? type;
  String? amount;
  String? per;

  TaxedNonTaxedModel({this.type, this.amount, this.per});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['taxt_type'] = type;
    map['taxt_amount'] = amount;
    map['taxt_per'] = per;
    return map;
  }

}