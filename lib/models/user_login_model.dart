import 'dart:convert';



class UserModel {
  UserModel({
      num? userId, 
      String? userToken, 
      String? firstName, 
      String? middle, 
      String? lastName, 
      String? email, 
      String? union, 
      String? primaryPosition, 
      String? address, 
      String? website, 
      String? socialMedia, 
      String? userProfilePhoto, 
      num? industryId, 
      String? loginType, 
      String? mobile, 
      String? birthDate, 
      String? about, 
      String? authToken, 
      String? devicePushToken, 
      String? deviceType, 
      String? verifyEmail, 
      String? verifyPhone, 
      String? verifyEmailCode, 
      String? verifyForgotCode, 
      num? isLoggedOut, 
      String? industryName, 
      num? timecardId, 
      String? socialSecurity, 
      String? city, 
      String? state, 
      num? zip, 
      String? country, 
      String? gender, 
      String? loanOut,}){
    _userId = userId;
    _userToken = userToken;
    _firstName = firstName;
    _middle = middle;
    _lastName = lastName;
    _email = email;
    _union = union;
    _primaryPosition = primaryPosition;
    _address = address;
    _website = website;
    _socialMedia = socialMedia;
    _userProfilePhoto = userProfilePhoto;
    _industryId = industryId;
    _loginType = loginType;
    _mobile = mobile;
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
    _timecardId = timecardId;
    _socialSecurity = socialSecurity;
    _city = city;
    _state = state;
    _zip = zip;
    _country = country;
    _gender = gender;
    _loanOut = loanOut;
}

  UserModel.fromJson(dynamic json) {
    _userId = json['user_id'];
    _userToken = json['user_token'];
    _firstName = json['first_name'];
    _middle = json['middle'];
    _lastName = json['last_name'];
    _email = json['email'];
    _union = json['union'];
    _primaryPosition = json['primary_position'];
    _address = json['address'];
    _website = json['website'];
    _socialMedia = json['social_media'];
    _userProfilePhoto = json['user_profile_photo'];
    _industryId = json['industry_id'];
    _loginType = json['login_type'];
    _mobile = json['mobile'];
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
    _timecardId = json['timecard_id'];
    _socialSecurity = json['social_security'];
    _city = json['city'];
    _state = json['state'];
    _zip = json['zip'];
    _country = json['country'];
    _gender = json['gender'];
    _loanOut = json['loan_out'];
  }
  num? _userId;
  String? _userToken;
  String? _firstName;
  String? _middle;
  String? _lastName;
  String? _email;
  String? _union;
  String? _primaryPosition;
  String? _address;
  String? _website;
  String? _socialMedia;
  String? _userProfilePhoto;
  num? _industryId;
  String? _loginType;
  String? _mobile;
  String? _birthDate;
  String? _about;
  String? _authToken;
  String? _devicePushToken;
  String? _deviceType;
  String? _verifyEmail;
  String? _verifyPhone;
  String? _verifyEmailCode;
  String? _verifyForgotCode;
  num? _isLoggedOut;
  String? _industryName;
  num? _timecardId;
  String? _socialSecurity;
  String? _city;
  String? _state;
  num? _zip;
  String? _country;
  String? _gender;
  String? _loanOut;

  num? get userId => _userId;
  String? get userToken => _userToken;
  String? get firstName => _firstName;
  String? get middle => _middle;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get union => _union;
  String? get primaryPosition => _primaryPosition;
  String? get address => _address;
  String? get website => _website;
  String? get socialMedia => _socialMedia;
  String? get userProfilePhoto => _userProfilePhoto;
  num? get industryId => _industryId;
  String? get loginType => _loginType;
  String? get mobile => _mobile;
  String? get birthDate => _birthDate;
  String? get about => _about;
  String? get authToken => _authToken;
  String? get devicePushToken => _devicePushToken;
  String? get deviceType => _deviceType;
  String? get verifyEmail => _verifyEmail;
  String? get verifyPhone => _verifyPhone;
  String? get verifyEmailCode => _verifyEmailCode;
  String? get verifyForgotCode => _verifyForgotCode;
  num? get isLoggedOut => _isLoggedOut;
  String? get industryName => _industryName;
  num? get timecardId => _timecardId;
  String? get socialSecurity => _socialSecurity;
  String? get city => _city;
  String? get state => _state;
  num? get zip => _zip;
  String? get country => _country;
  String? get gender => _gender;
  String? get loanOut => _loanOut;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['user_token'] = _userToken;
    map['first_name'] = _firstName;
    map['middle'] = _middle;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['union'] = _union;
    map['primary_position'] = _primaryPosition;
    map['address'] = _address;
    map['website'] = _website;
    map['social_media'] = _socialMedia;
    map['user_profile_photo'] = _userProfilePhoto;
    map['industry_id'] = _industryId;
    map['login_type'] = _loginType;
    map['mobile'] = _mobile;
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
    map['timecard_id'] = _timecardId;
    map['social_security'] = _socialSecurity;
    map['city'] = _city;
    map['state'] = _state;
    map['zip'] = _zip;
    map['country'] = _country;
    map['gender'] = _gender;
    map['loan_out'] = _loanOut;
    return map;
  }

}