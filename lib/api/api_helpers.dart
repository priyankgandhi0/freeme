import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import '../utils/app_constant.dart';
import '../utils/route_manager.dart';
import 'api_exception.dart';
import '../utils/app_utils.dart';
import 'response_item.dart';

class BaseApiHelper {

  static Future<ResponseItem> getRequest({
    required String requestUrl,
    required Map<String, dynamic> queryParam,
    required bool passAuthToken,
  }) async {
    dio = Dio();
    return await dio
        .get(
          requestUrl,
          queryParameters: queryParam,
          options: Options(headers: AppUtils.requestHeader(passAuthToken)),
        )
        .then((value) => onValue(value))
        .onError((error, stackTrace) => onError(error));
  }

  static Future<ResponseItem> postRequest({
    required String requestUrl,
    required Map<String, dynamic> queryParam,
    required Map<String, dynamic> requestData,
    required bool passAuthToken,
    bool isMultipart = false,
  }) async {
    dio = Dio();
    FormData? formData;
    if (isMultipart) {
      formData = FormData.fromMap(requestData);
    }
    return await dio
        .post(
          requestUrl,
          queryParameters: queryParam,
          data: isMultipart ? formData : json.encode(requestData),
          options: Options(headers: AppUtils.requestHeader(passAuthToken)),
        )
        .then((value) => onValue(value))
        .onError((error, stackTrace) => onError(error));
  }

  static Future onValue(Response response) async {
    log(response.requestOptions.method, name: 'REQUEST_METHOD');
    log(response.requestOptions.path, name: 'REQUEST_URL');
    log(json.encode(response.requestOptions.queryParameters),
        name: 'REQUEST_PARAMS');
    log(json.encode(response.requestOptions.headers), name: 'REQUEST_HEADERS');
    if ((response.requestOptions.contentType ?? 'application/json') ==
        'application/json') {
      log(response.requestOptions.data, name: 'REQUEST_DATA');
    } else {
      var logData = {};
      for (var element in (response.requestOptions.data as FormData).fields) {
        logData[element.key] = element.value;
      }
      log(json.encode(logData), name: 'REQUEST_DATA');
    }
    log(json.encode(response.data), name: 'RESPONSE');
    final ResponseItem responseData = ResponseItem.fromJson(response.data);
    bool status = false;
    String message;
    dynamic data;

    if (response.statusCode == 200) {
      message = responseData.message;
      if (responseData.status) {
        status = true;
        data = responseData.data;
        data ??= response.data;
      } else {
        if (responseData.forceLogout!) {
          box.erase();
          box.write(AppConstant.isTutorialDone, true);
          await AppUtils.putAppDeviceInfo();
          await getx.Get.offNamedUntil(Routes.login, (route) => false,
              arguments: false);
        }
      }
    } else {
      message = AppConstant.errorText;
    }
    ResponseItem result = ResponseItem(
      data: data,
      message: message,
      status: status,
    );
    result.wholeData = response.data;
    result.isEmailSent = responseData.isEmailSent;

    return result;
  }

  static onError(error) {
    log('Error caused: $error');
    bool status = false;
    String message = 'Unsuccessful request';
    if (error is SocketException) {
      message = ResponseException('No internet connection').toString();
    } else if (error is FormatException) {
      message = ResponseException('Something wrong in response.').toString() +
          error.toString();
    }
    return ResponseItem(data: null, message: message, status: status);
  }
}
