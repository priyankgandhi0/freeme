import 'dart:convert';

class SummeryModel {
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

  List<HourlySummary>? get hourlySummary => _hourlySummary;

  List<GrossEarnings>? get grossEarnings => _grossEarnings;

  num? get grossEarningTotal => _grossEarningTotal;
}

class GrossEarnings {
  GrossEarnings.fromJson(dynamic json) {
    _taxesId = json['taxes_id'];
    _jobId = json['job_id'];
    _userToken = json['user_token'];
    _taxtTypeId = json['taxt_type_id'];
    _taxtType = json['taxt_type'];
    _taxtAmount = json['taxted_amount'];
    _taxtPer = json['taxt_per'];
    _taxPerTimeId = json['tax_per_time_id'];
    _isExample = json['is_example'];
    _taxedItemId = json['taxed_item_id'];
    _taxedItem = json['taxed_item'];
    _isAddedByUser = json['is_added_by_user'];
    _taxPerTimeCategory = json['tax_per_time_category'];
    _taxtedAmount = json['taxted_amount'];
  }

  num? _taxesId;
  num? _jobId;
  String? _userToken;
  num? _taxtTypeId;
  String? _taxtType;
  num? _taxtAmount;
  String? _taxtPer;
  num? _taxPerTimeId;
  num? _isExample;
  num? _taxedItemId;
  String? _taxedItem;
  num? _isAddedByUser;
  String? _taxPerTimeCategory;
  num? _taxtedAmount;

  num? get taxesId => _taxesId;

  num? get jobId => _jobId;

  String? get userToken => _userToken;

  num? get taxtTypeId => _taxtTypeId;

  String? get taxtType => _taxtType;

  num? get taxtAmount => _taxtAmount;

  String? get taxtPer => _taxtPer;

  num? get taxPerTimeId => _taxPerTimeId;

  num? get isExample => _isExample;

  num? get taxedItemId => _taxedItemId;

  String? get taxedItem => _taxedItem;

  num? get isAddedByUser => _isAddedByUser;

  String? get taxPerTimeCategory => _taxPerTimeCategory;

  num? get taxtedAmount => _taxtedAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['taxes_id'] = _taxesId;
    map['job_id'] = _jobId;
    map['user_token'] = _userToken;
    map['taxt_type_id'] = _taxtTypeId;
    map['taxt_type'] = _taxtType;
    map['taxt_amount'] = _taxtAmount;
    map['taxt_per'] = _taxtPer;
    map['tax_per_time_id'] = _taxPerTimeId;
    map['is_example'] = _isExample;
    map['taxed_item_id'] = _taxedItemId;
    map['taxed_item'] = _taxedItem;
    map['is_added_by_user'] = _isAddedByUser;
    map['tax_per_time_category'] = _taxPerTimeCategory;
    map['taxted_amount'] = _taxtedAmount;
    return map;
  }
}

class HourlySummary {


  HourlySummary.fromJson(dynamic json) {
    _dayId = json['day_id'];
    _jobId = json['job_id'];
    _userToken = json['user_token'];
    _date = json['date'];
    _isExample = json['is_example'];
    _description = json['description'];
    _productionTitle = json['production_title'];
    _producer = json['producer'];
    _productionCompany = json['production_company'];
    _companyAddressLine1 = json['company_address_line1'];
    _companyAddressLine2 = json['company_address_line2'];
    _city = json['city'];
    _state = json['state'];
    _zip = json['zip'];
    _country = json['country'];
    _jobClassificationId = json['job_classification_id'];
    _subJobClassificationsId = json['sub_job_classifications_id'];
    _typeId = json['type_id'];
    _department = json['department'];
    _position = json['position'];
    _type = json['type'];
    _unionNonunion = json['union_nonunion'];
    _recommendedBy = json['recommended_by'];
    _hiredBy = json['hired_by'];
    _notes = json['notes'];
    _workHistoryId = json['work_history_id'];
    _jobDescription = json['job_description'];
    _dayTypeId = json['day_type_id'];
    _callTime = json['call_time'];
    _firstMealStart = json['first_meal_start'];
    _firstMealEnd = json['first_meal_end'];
    _secondMealStart = json['second_meal_start'];
    _secondMealEnd = json['second_meal_end'];
    _wrap = json['wrap'];
    _paymentDetails = json['payment_details'] != null
        ? PaymentDetails.fromJson(json['payment_details'])
        : null;

  }

  num? _dayId;
  num? _jobId;
  String? _userToken;
  String? _date;
  num? _isExample;
  String? _description;
  String? _productionTitle;
  String? _producer;
  String? _productionCompany;
  String? _companyAddressLine1;
  String? _companyAddressLine2;
  String? _city;
  String? _state;
  num? _zip;
  String? _country;
  num? _jobClassificationId;
  num? _subJobClassificationsId;
  num? _typeId;
  String? _department;
  String? _position;
  String? _type;
  String? _unionNonunion;
  String? _recommendedBy;
  String? _hiredBy;
  String? _notes;
  num? _workHistoryId;
  String? _jobDescription;
  int? _dayTypeId;
  String? _callTime;
  String? _firstMealStart;
  String? _firstMealEnd;
  String? _secondMealStart;
  String? _secondMealEnd;
  String? _wrap;
  PaymentDetails? _paymentDetails;

  num? get dayId => _dayId;

  num? get jobId => _jobId;

  String? get userToken => _userToken;

  String? get date => _date;

  num? get isExample => _isExample;

  String? get description => _description;

  String? get productionTitle => _productionTitle;

  String? get producer => _producer;

  String? get productionCompany => _productionCompany;

  String? get companyAddressLine1 => _companyAddressLine1;

  String? get companyAddressLine2 => _companyAddressLine2;

  String? get city => _city;

  String? get state => _state;

  num? get zip => _zip;

  String? get country => _country;

  num? get jobClassificationId => _jobClassificationId;

  num? get subJobClassificationsId => _subJobClassificationsId;

  num? get typeId => _typeId;

  String? get department => _department;

  String? get position => _position;

  String? get type => _type;

  String? get unionNonunion => _unionNonunion;

  String? get recommendedBy => _recommendedBy;

  String? get hiredBy => _hiredBy;

  String? get notes => _notes;

  num? get workHistoryId => _workHistoryId;

  String? get jobDescription => _jobDescription;

  int? get dayTypeId => _dayTypeId;

  String? get callTime => _callTime;

  String? get firstMealStart => _firstMealStart;

  String? get firstMealEnd => _firstMealEnd;

  String? get secondMealStart => _secondMealStart;

  String? get secondMealEnd => _secondMealEnd;

  String? get wrap => _wrap;

  PaymentDetails? get paymentDetails => _paymentDetails;


  HourlySummary(this._date);
}

class PaymentDetails {
  PaymentDetails.fromJson(dynamic json) {
    _paymentId = json['payment_id'];
    _jobId = json['job_id'];
    _userToken = json['user_token'];
    _rate = json['rate'];
    _hoursId = json['hours_id'];
    _guaranteedHourId = json['guaranteed_hour_id'];
    _w21099 = json['w2_1099'];
    _paidById = json['paid_by_id'];
    _termsId = json['terms_id'];
    _perHowManyHours = json['per_how_many_hours'];
    _guaranteedHours = json['guaranteed_hours'];
    _paidBy = json['paid_by'];
    _terms = json['terms'];
    _isExample = json['is_example'];
    _hours = json['hours'];
    _totalHours = json['total_hours'];
  }

  num? _paymentId;
  num? _jobId;
  String? _userToken;
  num? _rate;
  num? _hoursId;
  num? _guaranteedHourId;
  String? _w21099;
  num? _paidById;
  num? _termsId;
  String? _perHowManyHours;
  String? _guaranteedHours;
  String? _paidBy;
  String? _terms;
  num? _isExample;
  String? _hours;
  num? _totalHours;

  num? get paymentId => _paymentId;

  num? get jobId => _jobId;

  String? get userToken => _userToken;

  num? get rate => _rate;

  num? get hoursId => _hoursId;

  num? get guaranteedHourId => _guaranteedHourId;

  String? get w21099 => _w21099;

  num? get paidById => _paidById;

  num? get termsId => _termsId;

  String? get perHowManyHours => _perHowManyHours;

  String? get guaranteedHours => _guaranteedHours;

  String? get paidBy => _paidBy;

  String? get terms => _terms;

  num? get isExample => _isExample;

  String? get hours => _hours;

  num? get totalHours => _totalHours;
}
