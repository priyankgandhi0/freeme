import 'package:freeme/api/api_helpers.dart';
import 'package:freeme/api/request_constant.dart';

import '../response_item.dart';

class JobRepo {
  JobRepo._();

  static Future<ResponseItem> getJobInfo(int jobId) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = '';
    var queryParameters = {
      RequestParam.service: MethodNames.getJobInfo,
      RequestParam.showError: false,
    };
    result = await BaseApiHelper.postRequest(
      requestUrl: AppUrls.baseUrl,
      queryParam: queryParameters,
      requestData: {
        "job_id" : jobId
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
