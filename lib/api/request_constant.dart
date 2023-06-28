import 'package:flutter/foundation.dart';

class AppUrls {
  static const String _devBaseURL = "http://codonnier.tech/naitik/free_me_app/staging";
  static const String _liveBaseURL = "http://codonnier.tech/naitik/free_me_app/staging";


  static const String baseUrl =
      '${kDebugMode ? _devBaseURL : _liveBaseURL}/Service.php?';

  static const String imageBaseUrlDev =
      'http://146.190.158.193/YurInvtd/app_images/profile_images/';
  static const String imageBaseUrl =
      'https://app.yurinvtd.com/YurInvtd/app_images/profile_images/';

  static const String baseImageUrl = "https://codonnier.tech/naitik/free_me_app/app_images/profile_images/";
}

class MethodNames {
  static const login = 'userLogin';
  static const userRegistration = 'userRegistration';
  static const forgotPassword = 'forgotPassword';
  static const changePasswordWithVerifyCode = 'changePasswordWithVerifyCode';
  static const getAllIndustries = 'getAllIndustries';
  static const logout = 'logout';
  static const myProfile = 'myProfile';
  static const editProfile = 'editProfile';
  static const changePassword = 'changePassword';
  static const quickEntry = 'quickEntry';
  static const getAllTypes = 'getAllTypes';
  static const getAllTerms = 'getAllTerms';
  static const getAllPaidBy = 'getAllPaidBy';
  static const getAllGuaranteedHour = 'getAllGuaranteedHour';
  static const getAllPerHour = 'getAllPerHour';
  static const getAllJobClassifications = 'getAllJobClassifications';
  static const getAllSubJobClassifications = 'getAllSubJobClassifications';
  static const getAllTaxedItemType = 'getAllTaxedItemType';
  static const getAllTaxPerTime = 'getAllTaxPerTime';
  static const addJob = 'addJob';
  static const addNewJob = 'addNewJob';
  static const editJob = 'editJob';
  static const getJobInfo = 'getJobInfo';
  static const getAllJobs = 'getAllJobs';
  static const getWorkHistory = 'getWorkHistory';
  static const editWorkHistoryTimecard = 'editWorkHistoryTimecard';
  static const getAllDayTypes = 'getAllDayTypes';
  static const getJobLastEntry = 'getJobLastEntry';
  static const getNotes = 'getNotes';
  static const editNotes = 'editNotes';
  static const getSummary = 'getSummary';
  static const timecardInfo = 'timecardInfo';
  static const editTimecardInfo = 'editTimecardInfo';


}

class RequestParam {
  static const service = "Service"; // -> pass method name
  static const showError = "show_error"; // -> bool in String
}

class RequestHeaderKey {
  static const contentType = "Content-Type";
  static const userAgent = "User-Agent";
  static const appSecret = "App-Secret";
  static const appTrackVersion = "App-Track-Version";
  static const appDeviceType = "App-Device-Type";
  static const appStoreVersion = "App-Store-Version";
  static const appDeviceModel = "App-Device-Model";
  static const appOsVersion = "App-Os-Version";
  static const appStoreBuildNumber = "App-Store-Build-Number";
  static const authToken = "Auth-Token";
  static const accessToken = "Access-Token";
}
