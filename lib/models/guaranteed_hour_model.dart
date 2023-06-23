import 'dart:convert';

List<GuaranteedHourModel> guaranteedHourModelFromJson(dynamic str) {
  return (str as List).map((e) => GuaranteedHourModel.fromJson(e)).toList();
}



class GuaranteedHourModel {
  GuaranteedHourModel.fromJson(dynamic json) {
    _guaranteedHourId = json['guaranteed_hour_id'];
    _guaranteedHour = json['guaranteed_hour'];
  }

  int? _guaranteedHourId;
  String? _guaranteedHour;

  int? get guaranteedHourId => _guaranteedHourId;

  String? get guaranteedHour => _guaranteedHour;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['guaranteed_hour_id'] = _guaranteedHourId;
    map['guaranteed_hour'] = _guaranteedHour;
    return map;
  }
}
