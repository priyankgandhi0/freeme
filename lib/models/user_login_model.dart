import 'dart:convert';


UserModel userLoginModelFromJson(String str) => UserModel.fromJson(json.decode(str));
String userLoginModelToJson(UserModel data) => json.encode(data.toJson());
class UserModel {
  UserModel({
      int? userId, 
      String? userToken, 
      String? firstName, 
      String? middle, 
      String? lastName, 
      String? union, 
      String? primaryPosition, 
      String? address, 
      String? website, 
      String? socialMedia, 
      String? userProfilePhoto, 
      int? industryId, 
      String? loginType, 
      String? birthDate, 
      String? about, 
      String? authToken, 
      String? devicePushToken, 
      String? deviceType, 
      String? verifyEmail, 
      String? verifyPhone, 
      String? verifyEmailCode, 
      String? verifyForgotCode, 
      int? isLoggedOut, 
      String? industryName,
    String? timecardInfoId,
    String? socialSecurity,
    String? city,
    String? state,
    String? zip,
    String? country,
    String? gender,
    String? loanOut,
      List<Email>? email, 
      List<Mobile>? mobile,}){
    _userId = userId;
    _userToken = userToken;
    _firstName = firstName;
    _middle = middle;
    _lastName = lastName;
    _union = union;
    _primaryPosition = primaryPosition;
    _address = address;
    _website = website;
    _socialMedia = socialMedia;
    _userProfilePhoto = userProfilePhoto;
    _industryId = industryId;
    _loginType = loginType;
    _birthDate = birthDate;
    _about = about;
    _authToken = authToken;
    _devicePushToken = devicePushToken;
    _deviceType = deviceType;
    _verifyEmail = verifyEmail;
    _verifyPhone = verifyPhone;
    _verifyEmailCode = verifyEmailCode;
    _verifyForgotCode = verifyForgotCode;
    _isLoggedOut = isLoggedOut;
    _industryName = industryName;
    _timecardInfoId = timecardInfoId;
    _socialSecurity = socialSecurity;
    _city = city;
    _state = state;
    _zip = zip;
    _country = country;
    _gender = gender;
    _loanOut = loanOut;
    _email = email;
    _mobile = mobile;
}

  UserModel.fromJson(dynamic json) {
    _userId = json['user_id'];
    _userToken = json['user_token'];
    _firstName = json['first_name'];
    _middle = json['middle'];
    _lastName = json['last_name'];
    _union = json['union'];
    _primaryPosition = json['primary_position'];
    _address = json['address'];
    _website = json['website'];
    _socialMedia = json['social_media'];
    _userProfilePhoto = json['user_profile_photo'];
    _industryId = json['industry_id'];
    _loginType = json['login_type'];
    _birthDate = json['birth_date'];
    _about = json['about'];
    _authToken = json['auth_token'];
    _devicePushToken = json['device_push_token'];
    _deviceType = json['device_type'];
    _verifyEmail = json['verify_email'];
    _verifyPhone = json['verify_phone'];
    _verifyEmailCode = json['verify_email_code'];
    _verifyForgotCode = json['verify_forgot_code'];
    _isLoggedOut = json['is_logged_out'];
    _industryName = json['industry_name'];
    _timecardInfoId = json['timecard_info_id'];
    _socialSecurity = json['social_security'];
    _city = json['city'];
    _state = json['state'];
    _zip = json['zip'];
    _country = json['country'];
    _gender = json['gender'];
    _loanOut = json['loan_out'];
    if (json['email'] != null) {
      _email = [];
      json['email'].forEach((v) {
        _email?.add(Email.fromJson(v));
      });
    }
    if (json['mobile'] != null) {
      _mobile = [];
      json['mobile'].forEach((v) {
        _mobile?.add(Mobile.fromJson(v));
      });
    }
  }
  int? _userId;
  String? _userToken;
  String? _firstName;
  String? _middle;
  String? _lastName;
  String? _union;
  String? _primaryPosition;
  String? _address;
  String? _website;
  String? _socialMedia;
  String? _userProfilePhoto;
  int? _industryId;
  String? _loginType;
  String? _birthDate;
  String? _about;
  String? _authToken;
  String? _devicePushToken;
  String? _deviceType;
  String? _verifyEmail;
  String? _verifyPhone;
  String? _verifyEmailCode;
  String? _verifyForgotCode;
  int? _isLoggedOut;
  String? _industryName;
  String? _timecardInfoId;
  String? _socialSecurity;
  String? _city;
  String? _state;
  String? _zip;
  String? _country;
  String? _gender;
  String? _loanOut;
  List<Email>? _email;
  List<Mobile>? _mobile;

  int? get userId => _userId;
  String? get userToken => _userToken;
  String? get firstName => _firstName;
  String? get middle => _middle;
  String? get lastName => _lastName;
  String? get union => _union;
  String? get primaryPosition => _primaryPosition;
  String? get address => _address;
  String? get website => _website;
  String? get socialMedia => _socialMedia;
  String? get userProfilePhoto => _userProfilePhoto;
  int? get industryId => _industryId;
  String? get loginType => _loginType;
  String? get birthDate => _birthDate;
  String? get about => _about;
  String? get authToken => _authToken;
  String? get devicePushToken => _devicePushToken;
  String? get deviceType => _deviceType;
  String? get verifyEmail => _verifyEmail;
  String? get verifyPhone => _verifyPhone;
  String? get verifyEmailCode => _verifyEmailCode;
  String? get verifyForgotCode => _verifyForgotCode;
  int? get isLoggedOut => _isLoggedOut;
  String? get industryName => _industryName;
  dynamic get timecardInfoId => _timecardInfoId;
  dynamic get socialSecurity => _socialSecurity;
  dynamic get city => _city;
  dynamic get state => _state;
  dynamic get zip => _zip;
  dynamic get country => _country;
  dynamic get gender => _gender;
  dynamic get loanOut => _loanOut;
  List<Email>? get email => _email;
  List<Mobile>? get mobile => _mobile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['user_token'] = _userToken;
    map['first_name'] = _firstName;
    map['middle'] = _middle;
    map['last_name'] = _lastName;
    map['union'] = _union;
    map['primary_position'] = _primaryPosition;
    map['address'] = _address;
    map['website'] = _website;
    map['social_media'] = _socialMedia;
    map['user_profile_photo'] = _userProfilePhoto;
    map['industry_id'] = _industryId;
    map['login_type'] = _loginType;
    map['birth_date'] = _birthDate;
    map['about'] = _about;
    map['auth_token'] = _authToken;
    map['device_push_token'] = _devicePushToken;
    map['device_type'] = _deviceType;
    map['verify_email'] = _verifyEmail;
    map['verify_phone'] = _verifyPhone;
    map['verify_email_code'] = _verifyEmailCode;
    map['verify_forgot_code'] = _verifyForgotCode;
    map['is_logged_out'] = _isLoggedOut;
    map['industry_name'] = _industryName;
    map['timecard_info_id'] = _timecardInfoId;
    map['social_security'] = _socialSecurity;
    map['city'] = _city;
    map['state'] = _state;
    map['zip'] = _zip;
    map['country'] = _country;
    map['gender'] = _gender;
    map['loan_out'] = _loanOut;
    if (_email != null) {
      map['email'] = _email?.map((v) => v.toJson()).toList();
    }
    if (_mobile != null) {
      map['mobile'] = _mobile?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Email {
  Email({
      int? emailId, 
      String? userToken, 
      String? email,}){
    _emailId = emailId;
    _userToken = userToken;
    _email = email;
}

  Email.fromJson(dynamic json) {
    _emailId = json['email_id'];
    _userToken = json['user_token'];
    _email = json['email'];
  }
  int? _emailId;
  String? _userToken;
  String? _email;
Email copyWith({  int? emailId,
  String? userToken,
  String? email,
}) => Email(  emailId: emailId ?? _emailId,
  userToken: userToken ?? _userToken,
  email: email ?? _email,
);
  int? get emailId => _emailId;
  String? get userToken => _userToken;
  String? get email => _email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email_id'] = _emailId;
    map['user_token'] = _userToken;
    map['email'] = _email;
    return map;
  }
}



class Mobile {
  Mobile({
    int? emailId,
    String? userToken,
    String? email,}){
    _mobileId = emailId;
    _userToken = userToken;
    _mobile = email;
  }

  Mobile.fromJson(dynamic json) {
    _mobileId = json['mobile_id'];
    _userToken = json['user_token'];
    _mobile = json['mobile'];
  }

  int? _mobileId;
  String? _userToken;
  String? _mobile;

  int? get mobileId => _mobileId;
  String? get userToken => _userToken;
  String? get mobile => _mobile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mobile_id'] = _mobileId;
    map['user_token'] = _userToken;
    map['mobile'] = _mobile;
    return map;
  }
}