import 'dart:convert';

List<PerHourModel> perHourModelFromJson(dynamic str){
  return (str as List).map((e) => PerHourModel.fromJson(e)).toList();
}

class PerHourModel {
  PerHourModel.fromJson(dynamic json) {
    _hoursId = json['hours_id'];
    _hours = json['hours'];
  }
  num? _hoursId;
  String? _hours;

  num? get hoursId => _hoursId;
  String? get hours => _hours;
}