import 'dart:convert';


List<GetJobInfoModel> getAllJobFromJson(dynamic json){
  return (json as List).map((e) => GetJobInfoModel.fromJson(e)).toList();
}

class GetJobInfoModel {
  GetJobInfoModel.fromJson(dynamic json) {
    _jobId = json['job_id'];
    _userToken = json['user_token'];
    _description = json['description'];
    _productionTital = json['production_tital'];
    _producer = json['producer'];
    _productionCompany = json['production_company'];
    _companyAddressLine1 = json['company_address_line1'];
    _companyAddressLine2 = json['company_address_line2'];
    _city = json['city'];
    _state = json['state'];
    _zip = json['zip'];
    _country = json['country'];
    _department = json['department'];
    _position = json['position'];
    _type = json['type'];
    _unionNonunion = json['union_nonunion'];
    _recommendedBy = json['recommended_by'];
    _hiredBy = json['hired_by'];
    _paymentId = json['payment_id'];
    _rate = json['rate'];
    _perHowManyHours = json['per_how_many_hours'];
    _guaranteedHours = json['guaranteed_hours'];
    _w21099 = json['w2_1099'];
    _paidBy = json['paid_by'];
    _terms = json['terms'];
    if (json['taxes'] != null) {
      _taxes = [];
      json['taxes'].forEach((v) {
        _taxes?.add(Taxes.fromJson(v));
      });
    }
    if (json['non_taxes'] != null) {
      _nonTaxes = [];
      json['non_taxes'].forEach((v) {
        _nonTaxes?.add(NonTaxes.fromJson(v));
      });
    }
    if (json['days'] != null) {
      _days = [];
      json['days'].forEach((v) {
        _days?.add(Days.fromJson(v));
      });
    }
  }

  num? _jobId;
  String? _userToken;
  String? _description;
  String? _productionTital;
  String? _producer;
  String? _productionCompany;
  String? _companyAddressLine1;
  String? _companyAddressLine2;
  String? _city;
  String? _state;
  num? _zip;
  String? _country;
  String? _department;
  String? _position;
  String? _type;
  String? _unionNonunion;
  String? _recommendedBy;
  String? _hiredBy;
  num? _paymentId;
  num? _rate;
  String? _perHowManyHours;
  String? _guaranteedHours;
  String? _w21099;
  String? _paidBy;
  String? _terms;
  List<Taxes>? _taxes;
  List<NonTaxes>? _nonTaxes;
  List<Days>? _days;

  num? get jobId => _jobId;

  String? get userToken => _userToken;

  String? get description => _description;

  String? get productionTital => _productionTital;

  String? get producer => _producer;

  String? get productionCompany => _productionCompany;

  String? get companyAddressLine1 => _companyAddressLine1;

  String? get companyAddressLine2 => _companyAddressLine2;

  String? get city => _city;

  String? get state => _state;

  num? get zip => _zip;

  String? get country => _country;

  String? get department => _department;

  String? get position => _position;

  String? get type => _type;

  String? get unionNonunion => _unionNonunion;

  String? get recommendedBy => _recommendedBy;

  String? get hiredBy => _hiredBy;

  num? get paymentId => _paymentId;

  num? get rate => _rate;

  String? get perHowManyHours => _perHowManyHours;

  String? get guaranteedHours => _guaranteedHours;

  String? get w21099 => _w21099;

  String? get paidBy => _paidBy;

  String? get terms => _terms;

  List<Taxes>? get taxes => _taxes;

  List<NonTaxes>? get nonTaxes => _nonTaxes;

  List<Days>? get days => _days;
}

Days daysFromJson(String str) => Days.fromJson(json.decode(str));

class Days {
  Days.fromJson(dynamic json) {
    _dayId = json['day_id'];
    _jobId = json['job_id'];
    _userToken = json['user_token'];
    _date = json['date'];
  }

  num? _dayId;
  num? _jobId;
  String? _userToken;
  String? _date;

  num? get dayId => _dayId;
  num? get jobId => _jobId;
  String? get userToken => _userToken;
  String? get date => _date;
}

class Taxes {
  Taxes.fromJson(dynamic json) {
    _taxtType = json['taxt_type'];
    _taxtAmount = json['taxt_amount'];
    _taxtPer = json['taxt_per'];
  }

  String? _taxtType;
  num? _taxtAmount;
  String? _taxtPer;

  String? get taxType => _taxtType;

  num? get taxAmount => _taxtAmount;

  String? get taxPer => _taxtPer;
}

class NonTaxes {
  NonTaxes.fromJson(dynamic json) {
    _nonTaxtType = json['non_taxt_type'];
    _nonTaxtAmount = json['non_taxt_amount'];
    _nonTaxtPer = json['non_taxt_per'];
  }

  String? _nonTaxtType;
  num? _nonTaxtAmount;
  String? _nonTaxtPer;

  String? get nonTaxtType => _nonTaxtType;

  num? get nonTaxtAmount => _nonTaxtAmount;

  String? get nonTaxtPer => _nonTaxtPer;
}
