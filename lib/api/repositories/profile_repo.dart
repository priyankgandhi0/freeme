import 'dart:convert';

import 'package:dio/dio.dart';
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
    List<String>? mobile,
    List<String>? email,
    List<String>? address,
    List<String>? website,
    List<String>? socialMedia,
    String? union,
    int? department,
    int? position,
    String? birthDate,
    String? about,
    String? removeMobileNumber,
    String? removeAddress,
    String? remoceSocialMedia,
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
    if (profile != null) {
      /* String fileName = profile.split('/').last;
      List<String> mimeType = mime(fileName)?.split('/') ?? [];
    multipartFile = await MultipartFile.fromFile(profile,
          filename: fileName, contentType: MediaType(mimeType[0], mimeType[1]));*/

      String fileName = profile.split('/').last;
      multipartFile = await MultipartFile.fromFile(profile, filename: fileName);
    }

    Map<String, dynamic> requestData =  {
      "first_name": firstName,
      "last_name": lastName,
      "union": union,
      "job_classification_id": department,
      "sub_job_classifications_id": position,
      "birth_date": birthDate,
      "about": about,
      "profile_images": multipartFile,
      "remove_emails":removeEmail,
      "remove_mobile_no":removeMobileNumber,
      "remove_address":removeAddress,
      "remove_social_media":remoceSocialMedia,
      "remove_website":removeWebsite,
      "mobile" : mobile?.join(","),
      "email" : email?.join(","),
      "address" : address?.join(","),
      "website" : website?.join(","),
      "social_media" : socialMedia?.join(",")
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
