import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:freeme/utils/extension.dart';
import 'package:mime_type/mime_type.dart';

import '../api_helpers.dart';
import '../request_constant.dart';
import '../response_item.dart';

class ProfileRepo {
  ProfileRepo._();

  static Future<ResponseItem> editProfile({
    String? profile,
    String? firstName,
    String? lastName,
    String? mobile,
    String? email,
    String? address,
    String? website,
    String? socialMedia,
    required String? union,
    int? department,
    int? position,
    String? birthDate,
    String? about,
    String? removeMobileNumber,
    String? removeUnion,
    String? removeAddress,
    String? removeSocialMedia,
    String? removeWebsite,
    String? removeEmail,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = '';

    var queryParameters = {
      RequestParam.service: MethodNames.editProfile,
      RequestParam.showError: false,
    };

    MultipartFile? multipartFile;
    if (profile != null && profile.isNotEmpty  && !profile.isHttpUrl) {
      String fileName = profile.split('/').last;
      multipartFile = await MultipartFile.fromFile(profile, filename: fileName);
    }

    Map<String, dynamic> requestData = {
      "first_name": firstName,
      "last_name": lastName,
      "union": union,
      "job_classification_id": department,
      "sub_job_classifications_id": position,
      "birth_date": birthDate,
      "about": about,
      "profile_images": multipartFile,
      "remove_emails":removeEmail,
      "remove_union":removeUnion,
      "remove_mobile_no":removeMobileNumber,
      "remove_address":removeAddress,
      "remove_social_media":removeSocialMedia,
      "remove_website":removeWebsite,
      "mobile" : mobile,
      "email" : email,
      "address" : address,
      "website" : website,
      "social_media" : socialMedia
    };


    result = await BaseApiHelper.postRequest(
      requestUrl: AppUrls.baseUrl,
      queryParam: queryParameters,
      requestData:requestData,
      passAuthToken: true,
      isMultipart: true,
    );
    status = result.status;
    data = result.data;
    message = result.message;
    return ResponseItem(data: data, message: message, status: status);
  }

  static String transformToBase64(List<String> mobile){
   /* var bytes = utf8.encode(json.encode(mobile));
    var base64Str = base64.encode(bytes);
    return base64Str;*/
    return json.encode(mobile);
  }

  static Future<ResponseItem> changePassword({String? oldPassword,String? newPassword}) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = '';

    var queryParameters = {
      RequestParam.service: MethodNames.changePassword,
      RequestParam.showError: false,
    };
    result = await BaseApiHelper.postRequest(
      requestUrl: AppUrls.baseUrl,
      queryParam: queryParameters,
      requestData: {
        "old_password": oldPassword,
        "new_password" : newPassword
      },
      passAuthToken: true,
      isMultipart: false,
    );
    status = result.status;
    data = result.data;
    message = result.message;
    return ResponseItem(
      data: data,
      message: message,
      status: status,
    );
  }
}
