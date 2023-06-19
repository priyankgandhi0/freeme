import 'dart:convert';

SummeryModel summeryModelFromJson(String str) => SummeryModel.fromJson(json.decode(str));
String summeryModelToJson(SummeryModel data) => json.encode(data.toJson());
class SummeryModel {
  SummeryModel({
      List<HourlySummary>? hourlySummary, 
      List<GrossEarnings>? grossEarnings, 
      num? grossEarningTotal,}){
    _hourlySummary = hourlySummary;
    _grossEarnings = grossEarnings;
    _grossEarningTotal = grossEarningTotal;
}

  SummeryModel.fromJson(dynamic json) {
    if (json['hourly_summary'] != null) {
      _hourlySummary = [];
      json['hourly_summary'].forEach((v) {
        _hourlySummary?.add(HourlySummary.fromJson(v));
      });
    }
    if (json['gross_earnings'] != null) {
      _grossEarnings = [];
      json['gross_earnings'].forEach((v) {
        _grossEarnings?.add(GrossEarnings.fromJson(v));
      });
    }
    _grossEarningTotal = json['gross_earning_total '];
  }
  List<HourlySummary>? _hourlySummary;
  List<GrossEarnings>? _grossEarnings;
  num? _grossEarningTotal;
SummeryModel copyWith({  List<HourlySummary>? hourlySummary,
  List<GrossEarnings>? grossEarnings,
  num? grossEarningTotal,
}) => SummeryModel(  hourlySummary: hourlySummary ?? _hourlySummary,
  grossEarnings: grossEarnings ?? _grossEarnings,
  grossEarningTotal: grossEarningTotal ?? _grossEarningTotal,
);
  List<HourlySummary>? get hourlySummary => _hourlySummary;
  List<GrossEarnings>? get grossEarnings => _grossEarnings;
  num? get grossEarningTotal => _grossEarningTotal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_hourlySummary != null) {
      map['hourly_summary'] = _hourlySummary?.map((v) => v.toJson()).toList();
    }
    if (_grossEarnings != null) {
      map['gross_earnings'] = _grossEarnings?.map((v) => v.toJson()).toList();
    }
    map['gross_earning_total '] = _grossEarningTotal;
    return map;
  }

}



GrossEarnings grossEarningsFromJson(String str) => GrossEarnings.fromJson(json.decode(str));
String grossEarningsToJson(GrossEarnings data) => json.encode(data.toJson());
class GrossEarnings {
  GrossEarnings({
      num? taxesId, 
      num? jobId, 
      String? userToken, 
      String? taxtType, 
      num? taxtAmount, 
      String? taxtPer, 
      num? isExample,}){
    _taxesId = taxesId;
    _jobId = jobId;
    _userToken = userToken;
    _taxtType = taxtType;
    _taxtAmount = taxtAmount;
    _taxtPer = taxtPer;
    _isExample = isExample;
}

  GrossEarnings.fromJson(dynamic json) {
    _taxesId = json['taxes_id'] ?? json['non_taxes_id'];
    _jobId = json['job_id'];
    _userToken = json['user_token'];
    _taxtType = json['taxt_type'] ?? json['non_taxt_type'];
    _taxtAmount = json['taxt_amount'] ?? json['non_taxt_amount'];
    _taxtPer = json['taxt_per'] ?? json['non_taxt_per'];
    _isExample = json['is_example'];
  }
  num? _taxesId;
  num? _jobId;
  String? _userToken;
  String? _taxtType;
  num? _taxtAmount;
  String? _taxtPer;
  num? _isExample;
GrossEarnings copyWith({  num? taxesId,
  num? jobId,
  String? userToken,
  String? taxtType,
  num? taxtAmount,
  String? taxtPer,
  num? isExample,
}) => GrossEarnings(  taxesId: taxesId ?? _taxesId,
  jobId: jobId ?? _jobId,
  userToken: userToken ?? _userToken,
  taxtType: taxtType ?? _taxtType,
  taxtAmount: taxtAmount ?? _taxtAmount,
  taxtPer: taxtPer ?? _taxtPer,
  isExample: isExample ?? _isExample,
);
  num? get taxesId => _taxesId;
  num? get jobId => _jobId;
  String? get userToken => _userToken;
  String? get taxtType => _taxtType;
  num? get taxtAmount => _taxtAmount;
  String? get taxtPer => _taxtPer;
  num? get isExample => _isExample;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['taxes_id'] = _taxesId;
    map['job_id'] = _jobId;
    map['user_token'] = _userToken;
    map['taxt_type'] = _taxtType;
    map['taxt_amount'] = _taxtAmount;
    map['taxt_per'] = _taxtPer;
    map['is_example'] = _isExample;
    return map;
  }

}


HourlySummary hourlySummaryFromJson(String str) => HourlySummary.fromJson(json.decode(str));
String hourlySummaryToJson(HourlySummary data) => json.encode(data.toJson());
class HourlySummary {
  HourlySummary({
      num? dayId, 
      num? jobId, 
      String? userToken, 
      String? date, 
      num? isExample, 
      num? workHistoryId, 
      String? jobDescription, 
      String? dayType, 
      String? callTime, 
      String? firstMealStart, 
      String? firstMealEnd, 
      String? secondMealStart, 
      String? secondMealEnd, 
      String? wrap,}){
    _dayId = dayId;
    _jobId = jobId;
    _userToken = userToken;
    _date = date;
    _isExample = isExample;
    _workHistoryId = workHistoryId;
    _jobDescription = jobDescription;
    _dayType = dayType;
    _callTime = callTime;
    _firstMealStart = firstMealStart;
    _firstMealEnd = firstMealEnd;
    _secondMealStart = secondMealStart;
    _secondMealEnd = secondMealEnd;
    _wrap = wrap;
}

  HourlySummary.fromJson(dynamic json) {
    _dayId = json['day_id'];
    _jobId = json['job_id'];
    _userToken = json['user_token'];
    _date = json['date'];
    _isExample = json['is_example'];
    _workHistoryId = json['work_history_id'];
    _jobDescription = json['job_description'];
    _dayType = json['day_type'];
    _callTime = json['call_time'];
    _firstMealStart = json['first_meal_start'];
    _firstMealEnd = json['first_meal_end'];
    _secondMealStart = json['second_meal_start'];
    _secondMealEnd = json['second_meal_end'];
    _wrap = json['wrap'];
  }
  num? _dayId;
  num? _jobId;
  String? _userToken;
  String? _date;
  num? _isExample;
  num? _workHistoryId;
  String? _jobDescription;
  String? _dayType;
  String? _callTime;
  String? _firstMealStart;
  String? _firstMealEnd;
  String? _secondMealStart;
  String? _secondMealEnd;
  String? _wrap;
HourlySummary copyWith({  num? dayId,
  num? jobId,
  String? userToken,
  String? date,
  num? isExample,
  num? workHistoryId,
  String? jobDescription,
  String? dayType,
  String? callTime,
  String? firstMealStart,
  String? firstMealEnd,
  String? secondMealStart,
  String? secondMealEnd,
  String? wrap,
}) => HourlySummary(  dayId: dayId ?? _dayId,
  jobId: jobId ?? _jobId,
  userToken: userToken ?? _userToken,
  date: date ?? _date,
  isExample: isExample ?? _isExample,
  workHistoryId: workHistoryId ?? _workHistoryId,
  jobDescription: jobDescription ?? _jobDescription,
  dayType: dayType ?? _dayType,
  callTime: callTime ?? _callTime,
  firstMealStart: firstMealStart ?? _firstMealStart,
  firstMealEnd: firstMealEnd ?? _firstMealEnd,
  secondMealStart: secondMealStart ?? _secondMealStart,
  secondMealEnd: secondMealEnd ?? _secondMealEnd,
  wrap: wrap ?? _wrap,
);
  num? get dayId => _dayId;
  num? get jobId => _jobId;
  String? get userToken => _userToken;
  String? get date => _date;
  num? get isExample => _isExample;
  num? get workHistoryId => _workHistoryId;
  String? get jobDescription => _jobDescription;
  String? get dayType => _dayType;
  String? get callTime => _callTime;
  String? get firstMealStart => _firstMealStart;
  String? get firstMealEnd => _firstMealEnd;
  String? get secondMealStart => _secondMealStart;
  String? get secondMealEnd => _secondMealEnd;
  String? get wrap => _wrap;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day_id'] = _dayId;
    map['job_id'] = _jobId;
    map['user_token'] = _userToken;
    map['date'] = _date;
    map['is_example'] = _isExample;
    map['work_history_id'] = _workHistoryId;
    map['job_description'] = _jobDescription;
    map['day_type'] = _dayType;
    map['call_time'] = _callTime;
    map['first_meal_start'] = _firstMealStart;
    map['first_meal_end'] = _firstMealEnd;
    map['second_meal_start'] = _secondMealStart;
    map['second_meal_end'] = _secondMealEnd;
    map['wrap'] = _wrap;
    return map;
  }

}