import 'dart:convert';
/// timecard_info_id : 2
/// user_token : "1564996b2243123a1fc876351915"
/// first_name : "naitik"
/// middle_name : "k"
/// last_name : "gondaliya"
/// union : "IATSE local 600"
/// social_security : "xxx-xxx-1234"
/// mobile_no : 123456789
/// email : "raju@gmail.com"
/// address_line1 : "1234 street dr"
/// address_line2 : "apt 111"
/// city : "los angeles"
/// state : "CA"
/// zip : 90210
/// country : "united states"
/// gender : "MALE"
/// loan_out : "factory LLC"

TimeCardInfoModel timeCardInfoModelFromJson(String str) => TimeCardInfoModel.fromJson(json.decode(str));
String timeCardInfoModelToJson(TimeCardInfoModel data) => json.encode(data.toJson());
class TimeCardInfoModel {
  TimeCardInfoModel({
      num? timecardInfoId, 
      String? userToken, 
      String? firstName, 
      String? middleName, 
      String? lastName, 
      String? union, 
      String? socialSecurity, 
      num? mobileNo, 
      String? email, 
      String? addressLine1, 
      String? addressLine2, 
      String? city, 
      String? state, 
      num? zip, 
      String? country, 
      String? gender, 
      String? loanOut,}){
    _timecardInfoId = timecardInfoId;
    _userToken = userToken;
    _firstName = firstName;
    _middleName = middleName;
    _lastName = lastName;
    _union = union;
    _socialSecurity = socialSecurity;
    _mobileNo = mobileNo;
    _email = email;
    _addressLine1 = addressLine1;
    _addressLine2 = addressLine2;
    _city = city;
    _state = state;
    _zip = zip;
    _country = country;
    _gender = gender;
    _loanOut = loanOut;
}

  TimeCardInfoModel.fromJson(dynamic json) {
    _timecardInfoId = json['timecard_info_id'];
    _userToken = json['user_token'];
    _firstName = json['first_name'];
    _middleName = json['middle_name'];
    _lastName = json['last_name'];
    _union = json['union'];
    _socialSecurity = json['social_security'];
    _mobileNo = json['mobile_no'];
    _email = json['email'];
    _addressLine1 = json['address_line1'];
    _addressLine2 = json['address_line2'];
    _city = json['city'];
    _state = json['state'];
    _zip = json['zip'];
    _country = json['country'];
    _gender = json['gender'];
    _loanOut = json['loan_out'];
  }
  num? _timecardInfoId;
  String? _userToken;
  String? _firstName;
  String? _middleName;
  String? _lastName;
  String? _union;
  String? _socialSecurity;
  num? _mobileNo;
  String? _email;
  String? _addressLine1;
  String? _addressLine2;
  String? _city;
  String? _state;
  num? _zip;
  String? _country;
  String? _gender;
  String? _loanOut;
TimeCardInfoModel copyWith({  num? timecardInfoId,
  String? userToken,
  String? firstName,
  String? middleName,
  String? lastName,
  String? union,
  String? socialSecurity,
  num? mobileNo,
  String? email,
  String? addressLine1,
  String? addressLine2,
  String? city,
  String? state,
  num? zip,
  String? country,
  String? gender,
  String? loanOut,
}) => TimeCardInfoModel(  timecardInfoId: timecardInfoId ?? _timecardInfoId,
  userToken: userToken ?? _userToken,
  firstName: firstName ?? _firstName,
  middleName: middleName ?? _middleName,
  lastName: lastName ?? _lastName,
  union: union ?? _union,
  socialSecurity: socialSecurity ?? _socialSecurity,
  mobileNo: mobileNo ?? _mobileNo,
  email: email ?? _email,
  addressLine1: addressLine1 ?? _addressLine1,
  addressLine2: addressLine2 ?? _addressLine2,
  city: city ?? _city,
  state: state ?? _state,
  zip: zip ?? _zip,
  country: country ?? _country,
  gender: gender ?? _gender,
  loanOut: loanOut ?? _loanOut,
);
  num? get timecardInfoId => _timecardInfoId;
  String? get userToken => _userToken;
  String? get firstName => _firstName;
  String? get middleName => _middleName;
  String? get lastName => _lastName;
  String? get union => _union;
  String? get socialSecurity => _socialSecurity;
  num? get mobileNo => _mobileNo;
  String? get email => _email;
  String? get addressLine1 => _addressLine1;
  String? get addressLine2 => _addressLine2;
  String? get city => _city;
  String? get state => _state;
  num? get zip => _zip;
  String? get country => _country;
  String? get gender => _gender;
  String? get loanOut => _loanOut;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['timecard_info_id'] = _timecardInfoId;
    map['user_token'] = _userToken;
    map['first_name'] = _firstName;
    map['middle_name'] = _middleName;
    map['last_name'] = _lastName;
    map['union'] = _union;
    map['social_security'] = _socialSecurity;
    map['mobile_no'] = _mobileNo;
    map['email'] = _email;
    map['address_line1'] = _addressLine1;
    map['address_line2'] = _addressLine2;
    map['city'] = _city;
    map['state'] = _state;
    map['zip'] = _zip;
    map['country'] = _country;
    map['gender'] = _gender;
    map['loan_out'] = _loanOut;
    return map;
  }

}