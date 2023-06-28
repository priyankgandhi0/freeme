import '../api_helpers.dart';
import '../request_constant.dart';
import '../response_item.dart';

class TimeCardInfoRepo {
  TimeCardInfoRepo._();


  static Future<ResponseItem> getTimeCardInfo() async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = '';
    var queryParameters = {
      RequestParam.service: MethodNames.timecardInfo,
      RequestParam.showError: false,
    };
    result = await BaseApiHelper.postRequest(
      requestUrl: AppUrls.baseUrl,
      queryParam: queryParameters,
      requestData: {},
      passAuthToken: true,
      isMultipart: false,
    );
    status = result.status;
    data = result.data;
    message = result.message;
    return ResponseItem(data: data, message: message, status: status);
  }

  static Future<ResponseItem> editTimecardInfo({
    String? firstName,
    String? lastName,
    String? middleName,
    String? unionName,
    String? socialSecurity,
    String? mobile,
    String? email,
    String? addressLine1,
    String? addressLine2,
    String? city,
    String? state,
    String? country,
    String? zip,
    String? gender,
    String? loanOut,
}) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = '';
    var queryParameters = {
      RequestParam.service: MethodNames.editTimecardInfo,
      RequestParam.showError: false,
    };
    result = await BaseApiHelper.postRequest(
      requestUrl: AppUrls.baseUrl,
      queryParam: queryParameters,
      requestData: {
        "first_name" : firstName,
        "middle_name" : middleName,
        "last_name" : lastName,
        "union" : unionName,
        "social_security" : socialSecurity,
        "mobile" : mobile,
        "email" : email,
        "address_line1" : addressLine1,
        "address_line2" : addressLine2,
        "city" : city,
        "state" : state,
        "zip" : zip,
        "country" : country,
        "gender" :gender,
        "loan_out" : loanOut
      },
      passAuthToken: true,
      isMultipart: false,
    );
    status = result.status;
    data = result.data;
    message = result.message;
    return ResponseItem(data: data, message: message, status: status);
  }

}