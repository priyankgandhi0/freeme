import '../api_helpers.dart';
import '../request_constant.dart';
import '../response_item.dart';

class AuthRepo {
  AuthRepo._();

  static Future<ResponseItem> userLogin(
      {String? email, String? password}) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = '';

    var queryParameters = {
      RequestParam.service: MethodNames.login,
      RequestParam.showError: false,
    };
    result = await BaseApiHelper.postRequest(
      requestUrl: AppUrls.baseUrl,
      queryParam: queryParameters,
      requestData: {"email": email, "password": password},
      passAuthToken: false,
      isMultipart: false,
    );
    status = result.status;
    data = result.data;
    message = result.message;
    return ResponseItem(data: data, message: message, status: status);
  }

  static Future<ResponseItem> userRegister({
    String? industryId,
    String? firstName,
    String? industryName,
    String? lastName,
    String? email,
    String? password,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = '';

    var queryParameters = {
      RequestParam.service: MethodNames.userRegistration,
      RequestParam.showError: false,
    };
    result = await BaseApiHelper.postRequest(
      requestUrl: AppUrls.baseUrl,
      queryParam: queryParameters,
      requestData: {
        "industry_id": industryId,
        "industry_name": industryName,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "password": password
      },
      passAuthToken: false,
    );
    status = result.status;
    data = result.data;
    message = result.message;
    return ResponseItem(data: data, message: message, status: status);
  }

  static Future<ResponseItem> forgotPassword({
    String? email,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = '';
    bool isEmailSent = false;

    var queryParameters = {
      RequestParam.service: MethodNames.forgotPassword,
      RequestParam.showError: false,
    };
    result = await BaseApiHelper.postRequest(
      requestUrl: AppUrls.baseUrl,
      queryParam: queryParameters,
      requestData: {
        "email": email,
      },
      passAuthToken: false,
      isMultipart: false,
    );
    status = result.status;
    data = result.data;
    message = result.message;
    isEmailSent = result.isEmailSent;
    return ResponseItem(
      data: data,
      message: message,
      status: status,
      isEmailSent: isEmailSent,
    );
  }

  static Future<ResponseItem> changePassword({
    String? email,
    String? password,
    String? verifyCode,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = '';
    bool isEmailSent = false;

    var queryParameters = {
      RequestParam.service: MethodNames.changePasswordWithVerifyCode,
      RequestParam.showError: false,
    };
    result = await BaseApiHelper.postRequest(
      requestUrl: AppUrls.baseUrl,
      queryParam: queryParameters,
      requestData: {
        "email" : email,
        "new_password" : password,
        "verify_code" : verifyCode
      },
      passAuthToken: false,
      isMultipart: false,
    );
    status = result.status;
    data = result.data;
    message = result.message;
    isEmailSent = result.isEmailSent;
    return ResponseItem(
      data: data,
      message: message,
      status: status,
      isEmailSent: isEmailSent,
    );
  }


  static Future<ResponseItem> getAllIndustry() async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = '';

    var queryParameters = {
      RequestParam.service: MethodNames.getAllIndustries,
      RequestParam.showError: false,
    };
    result = await BaseApiHelper.postRequest(
      requestUrl: AppUrls.baseUrl,
      queryParam: queryParameters,
      requestData: {},
      passAuthToken: false,
      isMultipart: false,
    );
    status = result.status;
    data = result.data;
    message = result.message;
    return ResponseItem(data: data, message: message, status: status);
  }

  static Future<ResponseItem> userLogOut() async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = '';

    var queryParameters = {
      RequestParam.service: MethodNames.logout,
      RequestParam.showError: false,
    };
    result = await BaseApiHelper.postRequest(
      requestUrl: AppUrls.baseUrl,
      queryParam: queryParameters,
      requestData: { },
      passAuthToken: true,
      isMultipart: false,
    );
    status = result.status;
    data = result.data;
    message = result.message;
    return ResponseItem(data: data, message: message, status: status);
  }

  static Future<ResponseItem> getMyProfile() async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = '';

    var queryParameters = {
      RequestParam.service: MethodNames.myProfile,
      RequestParam.showError: false,
    };
    result = await BaseApiHelper.postRequest(
      requestUrl: AppUrls.baseUrl,
      queryParam: queryParameters,
      requestData: { },
      passAuthToken: true,
      isMultipart: false,
    );
    status = result.status;
    data = result.data;
    message = result.message;
    return ResponseItem(data: data, message: message, status: status);
  }
}
