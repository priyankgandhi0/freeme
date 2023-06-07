import 'package:freeme/api/api_helpers.dart';

import '../request_constant.dart';
import '../response_item.dart';

class QuickEntryRepo {
  QuickEntryRepo._();

  static Future<ResponseItem> quickEntrySubmit({
    List<String>? selectedDays,
    String? description,
    String? productionTitle,
    String? producer,
    String? productionCompany,
    String? companyAddressLine1,
    String? companyAddressLine2,
    String? city,
    String? state,
    String? zip,
    String? countryCode,
    int? rate,
    String? perHowManyHours,
    String? guaranteedHours,
    String? w2_1099,
    String? paidBy,
    String? terms,
    String? department,
    String? position,
    String? type,
    String? unionNonunion,
    String? recommendedBy,
    String? hiredBy,
    String? textType,
    int? textAmount,
    int? textPer,
    int? nonTextType,
    int? nonTextAmount,
    int? nonTextPer,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = '';
    var queryParameters = {
      RequestParam.service: MethodNames.quickEntry,
      RequestParam.showError: false,
    };
    result = await BaseApiHelper.postRequest(
      requestUrl: AppUrls.baseUrl,
      queryParam: queryParameters,
      requestData: {
        "days": [...selectedDays ?? []],
        "description": description,
        "production_tital": productionTitle,
        "producer": producer,
        "production_company": productionCompany,
        "company_address_line1": companyAddressLine1,
        "company_address_line2": companyAddressLine2,
        "city": city,
        "state": state,
        "zip": zip,
        "country": countryCode,
        "rate": rate,
        "per_how_many_hours": perHowManyHours,
        "guaranteed_hours": guaranteedHours,
        "w2_1099": w2_1099,
        "paid_by": paidBy,
        "terms": terms,
        "department": department,
        "position": position,
        "type": type,
        "union_nonunion": unionNonunion,
        "recommended_by": recommendedBy,
        "hired_by": hiredBy,
        "taxt_type": textType,
        "taxt_amount": textAmount,
        "taxt_per": textPer,
        "non_taxt_type": nonTextType,
        "non_taxt_amount": nonTextAmount,
        "non_taxt_per": nonTextPer,
      },
      passAuthToken: true,
      isMultipart: false,
    );
    status = result.status;
    data = result.data;
    message = result.message;
    return ResponseItem(data: data, message: message, status: status);
  }

  static Future<ResponseItem> getAllTypesList() async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = '';
    var queryParameters = {
      RequestParam.service: MethodNames.getAllTypes,
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

  static Future<ResponseItem> getAllTermsList() async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = '';
    var queryParameters = {
      RequestParam.service: MethodNames.getAllTerms,
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

  static Future<ResponseItem> getAllPaidByList() async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = '';
    var queryParameters = {
      RequestParam.service: MethodNames.getAllPaidBy,
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

  static Future<ResponseItem> getAllGuaranteedHourList() async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = '';
    var queryParameters = {
      RequestParam.service: MethodNames.getAllGuaranteedHour,
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
  static Future<ResponseItem> allPerHourList() async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = '';
    var queryParameters = {
      RequestParam.service: MethodNames.getAllPerHour,
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
