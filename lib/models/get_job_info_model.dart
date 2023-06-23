import 'dart:convert';



List<GetJobInfoModel> getAllJobFromJson(dynamic json){
  return (json as List).map((e) => GetJobInfoModel.fromJson(e)).toList();
}

class GetJobInfoModel {

  GetJobInfoModel.fromJson(dynamic json) {
    _jobId = json['job_id'];
    _userToken = json['user_token'];
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
    _unionNonunion = json['union_nonunion'];
    _recommendedBy = json['recommended_by'];
    _hiredBy = json['hired_by'];
    _notes = json['notes'];
    _isExample = json['is_example'];
    _jobIsExample = json['job_is_example']==1;
    _paymentId = json['payment_id'];
    _rate = json['rate'];
    _hoursId = json['hours_id'];
    _guaranteedHourId = json['guaranteed_hour_id'];
    _w21099 = json['w2_1099'];
    _paidById = json['paid_by_id'];
    _termsId = json['terms_id'];
    _jobClassificationCategory = json['job_classification_category'];
    _subJobClassificationsCategory = json['sub_job_classifications_category'];
    _type = json['type'];
    _hours = json['hours'];
    _guaranteedHour = json['guaranteed_hour'];
    _paidByName = json['paid_by_name'];
    _term = json['term'];
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
  String? _unionNonunion;
  String? _recommendedBy;
  String? _hiredBy;
  String? _notes;
  num? _isExample;
  bool? _jobIsExample;
  num? _paymentId;
  num? _rate;
  num? _hoursId;
  num? _guaranteedHourId;
  String? _w21099;
  num? _paidById;
  num? _termsId;
  String? _jobClassificationCategory;
  String? _subJobClassificationsCategory;
  String? _type;
  String? _hours;
  String? _guaranteedHour;
  String? _paidByName;
  String? _term;
  List<Taxes>? _taxes;
  List<NonTaxes>? _nonTaxes;
  List<Days>? _days;

  num? get jobId => _jobId;
  String? get userToken => _userToken;
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
  String? get unionNonunion => _unionNonunion;
  String? get recommendedBy => _recommendedBy;
  String? get hiredBy => _hiredBy;
  String? get notes => _notes;
  num? get isExample => _isExample;
  bool? get jobIsExample => _jobIsExample;
  num? get paymentId => _paymentId;
  num? get rate => _rate;
  num? get hoursId => _hoursId;
  num? get guaranteedHourId => _guaranteedHourId;
  String? get w21099 => _w21099;
  num? get paidById => _paidById;
  num? get termsId => _termsId;
  String? get jobClassificationCategory => _jobClassificationCategory;
  String? get subJobClassificationsCategory => _subJobClassificationsCategory;
  String? get type => _type;
  String? get hours => _hours;
  String? get guaranteedHour => _guaranteedHour;
  String? get paidByName => _paidByName;
  String? get term => _term;
  List<Taxes>? get taxes => _taxes;
  List<NonTaxes>? get nonTaxes => _nonTaxes;
  List<Days>? get days => _days;


}

class Days {


  Days.fromJson(dynamic json) {
    _dayId = json['day_id'];
    _jobId = json['job_id'];
    _userToken = json['user_token'];
    _date = json['date'];
    _isExample = json['is_example'];
  }
  num? _dayId;
  num? _jobId;
  String? _userToken;
  String? _date;
  num? _isExample;

  num? get dayId => _dayId;
  num? get jobId => _jobId;
  String? get userToken => _userToken;
  String? get date => _date;
  num? get isExample => _isExample;


}


class NonTaxes {

  NonTaxes.fromJson(dynamic json) {
    _nonTaxesId = json['non_taxes_id'];
    _jobId = json['job_id'];
    _userToken = json['user_token'];
    _taxtTypeId = json['taxt_type_id'];
    _nonTaxtAmount = json['non_taxt_amount'];
    _taxPerTimeId = json['tax_per_time_id'];
    _isExample = json['is_example'];
    _taxedItem = json['taxed_item'];
    _taxPerTimeCategory = json['tax_per_time_category'];
  }
  num? _nonTaxesId;
  num? _jobId;
  String? _userToken;
  num? _taxtTypeId;
  num? _nonTaxtAmount;
  num? _taxPerTimeId;
  num? _isExample;
  String? _taxedItem;
  String? _taxPerTimeCategory;

  num? get nonTaxesId => _nonTaxesId;
  num? get jobId => _jobId;
  String? get userToken => _userToken;
  num? get taxtTypeId => _taxtTypeId;
  num? get nonTaxtAmount => _nonTaxtAmount;
  num? get taxPerTimeId => _taxPerTimeId;
  num? get isExample => _isExample;
  String? get taxedItem => _taxedItem;
  String? get taxPerTimeCategory => _taxPerTimeCategory;



}


class Taxes {

  Taxes.fromJson(dynamic json) {
    _taxesId = json['taxes_id'];
    _jobId = json['job_id'];
    _userToken = json['user_token'];
    _taxtTypeId = json['taxt_type_id'];
    _taxtAmount = json['taxt_amount'];
    _taxPerTimeId = json['tax_per_time_id'];
    _isExample = json['is_example'];
    _taxedItem = json['taxed_item'];
    _taxPerTimeCategory = json['tax_per_time_category'];
  }
  num? _taxesId;
  num? _jobId;
  String? _userToken;
  num? _taxtTypeId;
  num? _taxtAmount;
  num? _taxPerTimeId;
  num? _isExample;
  String? _taxedItem;
  String? _taxPerTimeCategory;

  num? get taxesId => _taxesId;
  num? get jobId => _jobId;
  String? get userToken => _userToken;
  num? get taxtTypeId => _taxtTypeId;
  num? get taxtAmount => _taxtAmount;
  num? get taxPerTimeId => _taxPerTimeId;
  num? get isExample => _isExample;
  String? get taxedItem => _taxedItem;
  String? get taxPerTimeCategory => _taxPerTimeCategory;


}