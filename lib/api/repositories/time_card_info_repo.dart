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

}