import 'dart:convert';


UserModel userLoginModelFromJson(String str) => UserModel.fromJson(json.decode(str));
String userLoginModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
      num? userId, 
      String? userToken, 
      String? firstName, 
      String? middle, 
      String? lastName, 
      List<UnionModel>? union,
      String? userEmail, 
      dynamic jobClassificationId, 
      dynamic subJobClassificationsId, 
      List<Address>? address, 
      List<Website>? website,
      List<SocialMedia>? socialMedia,
      String? userProfilePhoto, 
      num? industryId, 
      String? loginType, 
      dynamic birthDate, 
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
      num? isAddedByUser, 
      dynamic jobClassificationCategory, 
      dynamic subJobClassificationsCategory, 
      List<Email>? email, 
      List<Mobile>? mobile,}){
    _userId = userId;
    _userToken = userToken;
    _firstName = firstName;
    _middle = middle;
    _lastName = lastName;
    _union = union;
    _userEmail = userEmail;
    _jobClassificationId = jobClassificationId;
    _subJobClassificationsId = subJobClassificationsId;
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
    _isAddedByUser = isAddedByUser;
    _jobClassificationCategory = jobClassificationCategory;
    _subJobClassificationsCategory = subJobClassificationsCategory;
    _email = email;
    _mobile = mobile;
}

  UserModel.fromJson(dynamic json) {
    _userId = json['user_id'];
    _userToken = json['user_token'];
    _firstName = json['first_name'];
    _middle = json['middle'];
    _lastName = json['last_name'];
    if (json['union'] != null) {
      _union = [];
      json['union'].forEach((v) {
        _union?.add(UnionModel.fromJson(v));
      });
    }
    _userEmail = json['user_email'];
    _jobClassificationId = json['job_classification_id'];
    _subJobClassificationsId = json['sub_job_classifications_id'];
    if (json['address'] != null) {
      _address = [];
      json['address'].forEach((v) {
        _address?.add(Address.fromJson(v));
      });
    }
    if (json['website'] != null) {
      _website = [];
      json['website'].forEach((v) {
        _website?.add(Website.fromJson(v));
      });
    }
    if (json['social_media'] != null) {
      _socialMedia = [];
      json['social_media'].forEach((v) {
        _socialMedia?.add(SocialMedia.fromJson(v));
      });
    }
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
    _isAddedByUser = json['is_added_by_user'];
    _jobClassificationCategory = json['job_classification_category'];
    _subJobClassificationsCategory = json['sub_job_classifications_category'];
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

  num? _userId;
  String? _userToken;
  String? _firstName;
  String? _middle;
  String? _lastName;
  List<UnionModel>? _union;
  String? _userEmail;
  dynamic _jobClassificationId;
  dynamic _subJobClassificationsId;
  List<Address>? _address;
  List<Website>? _website;
  List<SocialMedia>? _socialMedia;
  String? _userProfilePhoto;
  num? _industryId;
  String? _loginType;
  dynamic _birthDate;
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
  num? _isAddedByUser;
  String? _jobClassificationCategory;
  String? _subJobClassificationsCategory;
  List<Email>? _email;
  List<Mobile>? _mobile;

  num? get userId => _userId;
  String? get userToken => _userToken;
  String? get firstName => _firstName;
  String? get middle => _middle;
  String? get lastName => _lastName;
  List<UnionModel>? get union => _union;
  String? get userEmail => _userEmail;
  dynamic get jobClassificationId => _jobClassificationId;
  dynamic get subJobClassificationsId => _subJobClassificationsId;
  List<Address>? get address => _address;
  List<Website>? get website => _website;
  List<SocialMedia>? get socialMedia => _socialMedia;
  String? get userProfilePhoto => _userProfilePhoto;
  num? get industryId => _industryId;
  String? get loginType => _loginType;
  dynamic get birthDate => _birthDate;
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
  num? get isAddedByUser => _isAddedByUser;
  String? get jobClassificationCategory => _jobClassificationCategory;
  String? get subJobClassificationsCategory => _subJobClassificationsCategory;
  List<Email>? get email => _email;
  List<Mobile>? get mobile => _mobile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['user_token'] = _userToken;
    map['first_name'] = _firstName;
    map['middle'] = _middle;
    map['last_name'] = _lastName;
    if (_union != null) {
      map['union'] = _union?.map((v) => v.toJson()).toList();
    }
    map['user_email'] = _userEmail;
    map['job_classification_id'] = _jobClassificationId;
    map['sub_job_classifications_id'] = _subJobClassificationsId;
    if (_address != null) {
      map['address'] = _address?.map((v) => v.toJson()).toList();
    }
    if (_website != null) {
      map['website'] = _website?.map((v) => v.toJson()).toList();
    }
    if (_socialMedia != null) {
      map['social_media'] = _socialMedia?.map((v) => v.toJson()).toList();
    }
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
    map['is_added_by_user'] = _isAddedByUser;
    map['job_classification_category'] = _jobClassificationCategory;
    map['sub_job_classifications_category'] = _subJobClassificationsCategory;
    if (_email != null) {
      map['email'] = _email?.map((v) => v.toJson()).toList();
    }
    if (_mobile != null) {
      map['mobile'] = _mobile?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}



Email emailFromJson(String str) => Email.fromJson(json.decode(str));
String emailToJson(Email data) => json.encode(data.toJson());
class Email {
  Email({
      num? emailId, 
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
  num? _emailId;
  String? _userToken;
  String? _email;
Email copyWith({  num? emailId,
  String? userToken,
  String? email,
}) => Email(  emailId: emailId ?? _emailId,
  userToken: userToken ?? _userToken,
  email: email ?? _email,
);
  num? get emailId => _emailId;
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

/// address_id : 54
/// user_token : "2764a536988aafe061da217a1727"
/// address_line1 : "jammu,kashmir.,ssakjdf,,sdc,,,,sdsd"
/// address_line2 : "sd.,lk,asdl/...,,,/';[]askljd"
/// city : "suart"
/// state : "gujrat"
/// zip : 395006
/// country : "india"

Address addressFromJson(String str) => Address.fromJson(json.decode(str));
String addressToJson(Address data) => json.encode(data.toJson());
class Address {
  Address({
      num? addressId, 
      String? userToken, 
      String? addressLine1, 
      String? addressLine2, 
      String? city, 
      String? state, 
      num? zip, 
      String? country,}){
    _addressId = addressId;
    _userToken = userToken;
    _addressLine1 = addressLine1;
    _addressLine2 = addressLine2;
    _city = city;
    _state = state;
    _zip = zip;
    _country = country;
}

  Address.fromJson(dynamic json) {
    _addressId = json['address_id'];
    _userToken = json['user_token'];
    _addressLine1 = json['address_line1'];
    _addressLine2 = json['address_line2'];
    _city = json['city'];
    _state = json['state'];
    _zip = json['zip'];
    _country = json['country'];
  }
  num? _addressId;
  String? _userToken;
  String? _addressLine1;
  String? _addressLine2;
  String? _city;
  String? _state;
  num? _zip;
  String? _country;
Address copyWith({  num? addressId,
  String? userToken,
  String? addressLine1,
  String? addressLine2,
  String? city,
  String? state,
  num? zip,
  String? country,
}) => Address(  addressId: addressId ?? _addressId,
  userToken: userToken ?? _userToken,
  addressLine1: addressLine1 ?? _addressLine1,
  addressLine2: addressLine2 ?? _addressLine2,
  city: city ?? _city,
  state: state ?? _state,
  zip: zip ?? _zip,
  country: country ?? _country,
);
  num? get addressId => _addressId;
  String? get userToken => _userToken;
  String? get addressLine1 => _addressLine1;
  String? get addressLine2 => _addressLine2;
  String? get city => _city;
  String? get state => _state;
  num? get zip => _zip;
  String? get country => _country;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address_id'] = _addressId;
    map['user_token'] = _userToken;
    map['address_line1'] = _addressLine1;
    map['address_line2'] = _addressLine2;
    map['city'] = _city;
    map['state'] = _state;
    map['zip'] = _zip;
    map['country'] = _country;
    return map;
  }

}


UnionModel unionModelFromJson(String str) => UnionModel.fromJson(json.decode(str));
String unionModelToJson(UnionModel data) => json.encode(data.toJson());
class UnionModel {
  UnionModel({
    num? unionId,
    String? userToken,
    num? unionTradeId,
    String? unionTradeTitle,
    String? unionTradeDescription,}){
    _unionId = unionId;
    _userToken = userToken;
    _unionTradeId = unionTradeId;
    _unionTradeTitle = unionTradeTitle;
    _unionTradeDescription = unionTradeDescription;
  }

  UnionModel.fromJson(dynamic json) {
    _unionId = json['union_id'];
    _userToken = json['user_token'];
    _unionTradeId = json['union_trade_id'];
    _unionTradeTitle = json['union_trade_title'];
    _unionTradeDescription = json['union_trade_description'];
  }
  num? _unionId;
  String? _userToken;
  num? _unionTradeId;
  String? _unionTradeTitle;
  String? _unionTradeDescription;
  UnionModel copyWith({  num? unionId,
    String? userToken,
    num? unionTradeId,
    String? unionTradeTitle,
    String? unionTradeDescription,
  }) => UnionModel(  unionId: unionId ?? _unionId,
    userToken: userToken ?? _userToken,
    unionTradeId: unionTradeId ?? _unionTradeId,
    unionTradeTitle: unionTradeTitle ?? _unionTradeTitle,
    unionTradeDescription: unionTradeDescription ?? _unionTradeDescription,
  );
  num? get unionId => _unionId;
  String? get userToken => _userToken;
  num? get unionTradeId => _unionTradeId;
  String? get unionTradeTitle => _unionTradeTitle;
  String? get unionTradeDescription => _unionTradeDescription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['union_id'] = _unionId;
    map['user_token'] = _userToken;
    map['union_trade_id'] = _unionTradeId;
    map['union_trade_title'] = _unionTradeTitle;
    map['union_trade_description'] = _unionTradeDescription;
    return map;
  }

}


Website websiteFromJson(String str) => Website.fromJson(json.decode(str));
String websiteToJson(Website data) => json.encode(data.toJson());
class Website {
  Website({
    num? websiteId,
    String? userToken,
    String? website,}){
    _websiteId = websiteId;
    _userToken = userToken;
    _website = website;
  }

  Website.fromJson(dynamic json) {
    _websiteId = json['website_id'];
    _userToken = json['user_token'];
    _website = json['website'];
  }
  num? _websiteId;
  String? _userToken;
  String? _website;
  Website copyWith({  num? websiteId,
    String? userToken,
    String? website,
  }) => Website(  websiteId: websiteId ?? _websiteId,
    userToken: userToken ?? _userToken,
    website: website ?? _website,
  );
  num? get websiteId => _websiteId;
  String? get userToken => _userToken;
  String? get website => _website;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['website_id'] = _websiteId;
    map['user_token'] = _userToken;
    map['website'] = _website;
    return map;
  }

}


Mobile mobileFromJson(String str) => Mobile.fromJson(json.decode(str));
String mobileToJson(Mobile data) => json.encode(data.toJson());
class Mobile {
  Mobile({
    num? numberId,
    String? userToken,
    num? mobileNo,}){
    _numberId = numberId;
    _userToken = userToken;
    _mobileNo = mobileNo;
  }

  Mobile.fromJson(dynamic json) {
    _numberId = json['number_id'];
    _userToken = json['user_token'];
    _mobileNo = json['mobile_no'];
  }
  num? _numberId;
  String? _userToken;
  num? _mobileNo;
  Mobile copyWith({  num? numberId,
    String? userToken,
    num? mobileNo,
  }) => Mobile(  numberId: numberId ?? _numberId,
    userToken: userToken ?? _userToken,
    mobileNo: mobileNo ?? _mobileNo,
  );
  num? get numberId => _numberId;
  String? get userToken => _userToken;
  num? get mobileNo => _mobileNo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['number_id'] = _numberId;
    map['user_token'] = _userToken;
    map['mobile_no'] = _mobileNo;
    return map;
  }

}


SocialMedia socialMediaFromJson(String str) => SocialMedia.fromJson(json.decode(str));
String socialMediaToJson(SocialMedia data) => json.encode(data.toJson());
class SocialMedia {
  SocialMedia({
    num? socialMediaId,
    String? userToken,
    String? socialMedia,}){
    _socialMediaId = socialMediaId;
    _userToken = userToken;
    _socialMedia = socialMedia;
  }

  SocialMedia.fromJson(dynamic json) {
    _socialMediaId = json['social_media_id'];
    _userToken = json['user_token'];
    _socialMedia = json['social_media'];
  }
  num? _socialMediaId;
  String? _userToken;
  String? _socialMedia;
  SocialMedia copyWith({  num? socialMediaId,
    String? userToken,
    String? socialMedia,
  }) => SocialMedia(  socialMediaId: socialMediaId ?? _socialMediaId,
    userToken: userToken ?? _userToken,
    socialMedia: socialMedia ?? _socialMedia,
  );
  num? get socialMediaId => _socialMediaId;
  String? get userToken => _userToken;
  String? get socialMedia => _socialMedia;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['social_media_id'] = _socialMediaId;
    map['user_token'] = _userToken;
    map['social_media'] = _socialMedia;
    return map;
  }

}
