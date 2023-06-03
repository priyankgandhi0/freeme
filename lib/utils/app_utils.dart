import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:freeme/api/request_constant.dart';
import 'package:package_info/package_info.dart';

import 'app_constant.dart';

class AppUtils{
  static Map<String, String> requestHeader(bool passAuthToken) {
    return {
      RequestHeaderKey.contentType: 'application/json',
      RequestHeaderKey.appSecret: 'YUR@#@INVTD232#\$',
      RequestHeaderKey.appTrackVersion: 'v1',
      RequestHeaderKey.appDeviceType: Platform.isIOS ? 'iOS' : 'android',
      RequestHeaderKey.appStoreVersion: box.read(AppConstant.appStoreVersion) ?? '',
      RequestHeaderKey.appDeviceModel: box.read(AppConstant.appDeviceModel) ?? '',
      RequestHeaderKey.appOsVersion: box.read(AppConstant.appOsVersion) ?? '',
      RequestHeaderKey.appStoreBuildNumber: box.read(AppConstant.appStoreBuildNumber) ?? '',
      if (passAuthToken)RequestHeaderKey.authToken: box.read(AppConstant.authToken) ?? '',
      if (passAuthToken)RequestHeaderKey.accessToken: box.read(AppConstant.accessToken) ?? '',
    };
  }

  static Future<void> putAppDeviceInfo() async {
    bool isiOS = Platform.isIOS;
    var deviceInfo = await appDeviceInfo();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    if (isiOS) {
      IosDeviceInfo iosDeviceInfo = (deviceInfo as IosDeviceInfo);
      await box.write(AppConstant.appDeviceModel, iosDeviceInfo.model);
      await box.write(
          AppConstant.appOsVersion, 'iOS ${iosDeviceInfo.systemVersion}');
    } else {
      AndroidDeviceInfo androidDeviceInfo = (deviceInfo as AndroidDeviceInfo);
      await box.write(AppConstant.appDeviceModel, androidDeviceInfo.model);
      await box.write(
          AppConstant.appOsVersion, androidDeviceInfo.version.release);
    }
    await box.write(AppConstant.appStoreVersion, packageInfo.version);
    await box.write(AppConstant.appStoreBuildNumber, packageInfo.buildNumber);
  }
  static Future<dynamic> appDeviceInfo() async {
    return Platform.isIOS
        ? await DeviceInfoPlugin().iosInfo
        : await DeviceInfoPlugin().androidInfo;
  }
}