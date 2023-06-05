import 'package:flutter/foundation.dart';

class AppUrls {
  static const String _devBaseURL = "http://codonnier.tech/naitik/free_me_app/dev";
  static const String _liveBaseURL = "http://codonnier.tech/naitik/free_me_app/dev";

  static const String baseUrl =
      '${kDebugMode ? _devBaseURL : _liveBaseURL}/Service.php?';

  static const String imageBaseUrlDev =
      'http://146.190.158.193/YurInvtd/app_images/profile_images/';
  static const String imageBaseUrl =
      'https://app.yurinvtd.com/YurInvtd/app_images/profile_images/';
}

class MethodNames {
  static const login = 'userLogin';

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
