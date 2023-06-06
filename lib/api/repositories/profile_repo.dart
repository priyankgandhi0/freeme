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
    String? mobile,
    String? email,
    String? union,
    String? primaryPosition,
    String? address,
    String? website,
    String? socialMedia,
    String? birthDate,
    String? about,
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

    result = await BaseApiHelper.postRequest(
      requestUrl: AppUrls.baseUrl,
      queryParam: queryParameters,
      requestData: {
        "profile_images": multipartFile,
        "first_name": firstName,
        "last_name": lastName,
        "mobile": mobile,
        "email": email,
        "union": union,
        "primary_position": primaryPosition,
        "address": address,
        "website": website,
        "social_media": socialMedia,
        "birth_date": birthDate,
        "about": about,
      },
      passAuthToken: true,
      isMultipart: true,
    );
    status = result.status;
    data = result.data;
    message = result.message;
    return ResponseItem(data: data, message: message, status: status);
  }
}
