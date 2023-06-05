import '../api_helpers.dart';
import '../request_constant.dart';
import '../response_item.dart';

class AuthRepo {
  AuthRepo._();

  static Future<ResponseItem> userLogin({String? email,String? password}) async {
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
      requestData: {
        "email" : email,
        "password" : password
      },
      passAuthToken: false,
      isMultipart: false,
    );
    status = result.status;
    data = result.data;
    message = result.message;
    return ResponseItem(data: data, message: message, status: status);
  }
}
