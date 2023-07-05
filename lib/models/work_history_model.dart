import 'dart:convert';

class WorkHistoryModel {
  WorkHistoryModel.fromJson(dynamic json) {
    _workHistoryId = json['work_history_id'];
    _jobId = json['job_id'];
    _jobDescription = json['job_description'];
    _date = json['date'];
    _dayTypeId = json['day_type_id'];
    _callTime = json['call_time'];
    _firstMealStart = json['first_meal_start'];
    _firstMealEnd = json['first_meal_end'];
    _secondMealStart = json['second_meal_start'];
    _secondMealEnd = json['second_meal_end'];
    _wrap = json['wrap'];
    if (json['locations'] != null) {
      _locations = [];
      json['locations'].forEach((v) {
        _locations?.add(Location.fromJson(v));
      });
    }
  }

  num? _workHistoryId;
  num? _jobId;
  String? _jobDescription;
  String? _date;
  int? _dayTypeId;
  String? _callTime;
  String? _firstMealStart;
  String? _firstMealEnd;
  String? _secondMealStart;
  String? _secondMealEnd;
  String? _wrap;
  List<Location>? _locations;

  num? get workHistoryId => _workHistoryId;

  num? get jobId => _jobId;

  String? get jobDescription => _jobDescription;

  String? get date => _date;

  int? get dayTypeId => _dayTypeId;

  String? get callTime => _callTime;

  String? get firstMealStart => _firstMealStart;

  String? get firstMealEnd => _firstMealEnd;

  String? get secondMealStart => _secondMealStart;

  String? get secondMealEnd => _secondMealEnd;

  String? get wrap => _wrap;

  List<Location>? get locations => _locations;
}

class Location {
  Location.fromJson(dynamic json) {
    _locationId = json['location_id'];
    _jobId = json['job_id'];
    _date = json['date'];
    _addressLine1 = json['address_line1'];
    _addressLine2 = json['address_line2'];
    _city = json['city'];
    _state = json['state'];
    _zip = json['zip'];
    _country = json['country'];
  }

  int? _locationId;
  num? _jobId;
  String? _date;
  String? _addressLine1;
  String? _addressLine2;
  String? _city;
  String? _state;
  num? _zip;
  String? _country;

  int? get locationId => _locationId;

  num? get jobId => _jobId;

  String? get date => _date;

  String? get addressLine1 => _addressLine1;

  String? get addressLine2 => _addressLine2;

  String? get city => _city;

  String? get state => _state;

  num? get zip => _zip;

  String? get country => _country;
}
