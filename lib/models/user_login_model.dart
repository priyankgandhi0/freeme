import 'dart:convert';

import 'package:freeme/utils/extension.dart';

import '../api/request_constant.dart';

UserModel userLoginModelFromJson(String str) =>
    UserModel.fromJson(json.decode(str));

String userLoginModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    num? userId,
    String? userToken,
    String? firstName,
    String? middle,
    String? lastName,
    String? union,
    String? userEmail,
    num? jobClassificationId,
    num? subJobClassificationsId,
    List<Address>? address,
    List<Website>? website,
    List<SocialMedia>? socialMedia,
    String? userProfilePhoto,
    num? industryId,
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
    num? isLoggedOut,
    String? industryName,
    num? isAddedByUser,
    String? jobClassificationCategory,
    String? subJobClassificationsCategory,
    List<Email>? email,
    List<Mobile>? mobile,
  }) {
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
    _union = json['union'];
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
    if (json['user_profile_photo'] != null &&
        json['user_profile_photo'] is String &&
        (json['user_profile_photo'] as String).isNotEmpty) {
      _userProfilePhoto = AppUrls.baseImageUrl + json['user_profile_photo'];
    }

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
  String? _union;
  String? _userEmail;
  num? _jobClassificationId;
  num? _subJobClassificationsId;
  List<Address>? _address;
  List<Website>? _website;
  List<SocialMedia>? _socialMedia;
  String? _userProfilePhoto;
  num? _industryId;
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

  String? get union => _union;

  String? get userEmail => _userEmail;

  num? get jobClassificationId => _jobClassificationId;

  num? get subJobClassificationsId => _subJobClassificationsId;

  List<Address>? get address => _address;

  List<Website>? get website => _website;

  List<SocialMedia>? get socialMedia => _socialMedia;

  String? get userProfilePhoto => _userProfilePhoto;

  num? get industryId => _industryId;

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
    map['union'] = _union;
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
    map['user_profile_photo'] =
        (_userProfilePhoto?.contains(AppUrls.baseImageUrl) ?? false)
            ? _userProfilePhoto?.replaceAll(AppUrls.baseImageUrl, "")
            : _userProfilePhoto;
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

/// number_id : 23
/// user_token : "164941404e223664c5a124e681"
/// mobile_no : 9978848357

Mobile mobileFromJson(String str) => Mobile.fromJson(json.decode(str));

String mobileToJson(Mobile data) => json.encode(data.toJson());

class Mobile {
  Mobile({
    num? numberId,
    String? userToken,
    num? mobileNo,
  }) {
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

  Mobile copyWith({
    num? numberId,
    String? userToken,
    num? mobileNo,
  }) =>
      Mobile(
        numberId: numberId ?? _numberId,
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

/// email_id : 46
/// user_token : "164941404e223664c5a124e681"
/// email : "hardik@yopmail.com"

Email emailFromJson(String str) => Email.fromJson(json.decode(str));

String emailToJson(Email data) => json.encode(data.toJson());

class Email {
  Email({
    num? emailId,
    String? userToken,
    String? email,
  }) {
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

  Email copyWith({
    num? emailId,
    String? userToken,
    String? email,
  }) =>
      Email(
        emailId: emailId ?? _emailId,
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

/// website_id : 9
/// user_token : "164941404e223664c5a124e681"
/// website : "www.lll.com"

Website websiteFromJson(String str) => Website.fromJson(json.decode(str));

String websiteToJson(Website data) => json.encode(data.toJson());

class Website {
  Website({
    num? websiteId,
    String? userToken,
    String? website,
  }) {
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

  Website copyWith({
    num? websiteId,
    String? userToken,
    String? website,
  }) =>
      Website(
        websiteId: websiteId ?? _websiteId,
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

/// address_id : 9
/// user_token : "164941404e223664c5a124e681"
/// address : "vadodara"

Address addressFromJson(String str) => Address.fromJson(json.decode(str));

String addressToJson(Address data) => json.encode(data.toJson());

class Address {
  Address.fromJson(dynamic json) {
    _addressId = json['address_id'];
    _userToken = json['user_token'];
    _address = json['address'];
  }

  num? _addressId;
  String? _userToken;
  String? _address;

  num? get addressId => _addressId;

  String? get userToken => _userToken;

  String? get address => _address;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address_id'] = _addressId;
    map['user_token'] = _userToken;
    map['address'] = _address;
    return map;
  }
}

class SocialMedia {
  SocialMedia.fromJson(dynamic json) {
    _socialMediaId = json['social_media_id'];
    _userToken = json['user_token'];
    _socialMedia = json['social_media'];
  }

  num? _socialMediaId;
  String? _userToken;
  String? _socialMedia;

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
