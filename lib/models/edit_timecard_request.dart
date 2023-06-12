class EditTimecardRequest {
  EditTimecardRequest({
    num? jobId,
    String? date,
    String? dayType,
    List<Locations>? locations,
    ClockedTimes? clockedTimes,
  }) {
    _jobId = jobId;
    _date = date;
    _dayType = dayType;
    _locations = locations;
    _clockedTimes = clockedTimes;
  }

  num? _jobId;
  String? _date;
  String? _dayType;
  List<Locations>? _locations;
  ClockedTimes? _clockedTimes;

  num? get jobId => _jobId;

  String? get date => _date;

  String? get dayType => _dayType;

  List<Locations>? get locations => _locations;

  ClockedTimes? get clockedTimes => _clockedTimes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['job_id'] = _jobId;
    map['date'] = _date;
    map['day_type'] = _dayType;
    if (_locations != null) {
      map['locations'] = _locations?.map((v) => v.toJson()).toList();
    }
    if (_clockedTimes != null) {
      map['clocked_times'] = _clockedTimes?.toJson();
    }
    return map;
  }
}

class ClockedTimes {
  ClockedTimes({
    String? callTime,
    String? firstMealStart,
    String? firstMealEnd,
    String? secondMealStart,
    String? secondMealEnd,
    String? wrap,
  }) {
    _callTime = callTime;
    _firstMealStart = firstMealStart;
    _firstMealEnd = firstMealEnd;
    _secondMealStart = secondMealStart;
    _secondMealEnd = secondMealEnd;
    _wrap = wrap;
  }

  ClockedTimes.fromJson(dynamic json) {
    _callTime = json['call_time'];
    _firstMealStart = json['first_meal_start'];
    _firstMealEnd = json['first_meal_end'];
    _secondMealStart = json['second_meal_start'];
    _secondMealEnd = json['second_meal_end'];
    _wrap = json['wrap'];
  }

  String? _callTime;
  String? _firstMealStart;
  String? _firstMealEnd;
  String? _secondMealStart;
  String? _secondMealEnd;
  String? _wrap;

  String? get callTime => _callTime;

  String? get firstMealStart => _firstMealStart;

  String? get firstMealEnd => _firstMealEnd;

  String? get secondMealStart => _secondMealStart;

  String? get secondMealEnd => _secondMealEnd;

  String? get wrap => _wrap;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['call_time'] = _callTime;
    map['first_meal_start'] = _firstMealStart;
    map['first_meal_end'] = _firstMealEnd;
    map['second_meal_start'] = _secondMealStart;
    map['second_meal_end'] = _secondMealEnd;
    map['wrap'] = _wrap;
    return map;
  }
}

class Locations {
  Locations({
    String? addressLine1,
    String? addressLine2,
    String? city,
    String? state,
    num? zip,
    String? country,
  }) {
    _addressLine1 = addressLine1;
    _addressLine2 = addressLine2;
    _city = city;
    _state = state;
    _zip = zip;
    _country = country;
  }

  String? _addressLine1;
  String? _addressLine2;
  String? _city;
  String? _state;
  num? _zip;
  String? _country;

  String? get addressLine1 => _addressLine1;

  String? get addressLine2 => _addressLine2;

  String? get city => _city;

  String? get state => _state;

  num? get zip => _zip;

  String? get country => _country;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address_line1'] = _addressLine1;
    map['address_line2'] = _addressLine2;
    map['city'] = _city;
    map['state'] = _state;
    map['zip'] = _zip;
    map['country'] = _country;
    return map;
  }
}
