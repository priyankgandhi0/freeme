import 'dart:convert';


List<DayType> dayTypeListFromJson(dynamic str){
  return (str as List).map((e) => DayType.fromJson(e)).toList();
}

class DayType {
  DayType({
      num? dayTypeId, 
      String? dayType,}){
    _dayTypeId = dayTypeId;
    _dayType = dayType;
}

  DayType.fromJson(dynamic json) {
    _dayTypeId = json['day_type_id'];
    _dayType = json['day_type'];
  }
  num? _dayTypeId;
  String? _dayType;
DayType copyWith({  num? dayTypeId,
  String? dayType,
}) => DayType(  dayTypeId: dayTypeId ?? _dayTypeId,
  dayType: dayType ?? _dayType,
);
  num? get dayTypeId => _dayTypeId;
  String? get dayType => _dayType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day_type_id'] = _dayTypeId;
    map['day_type'] = _dayType;
    return map;
  }

}