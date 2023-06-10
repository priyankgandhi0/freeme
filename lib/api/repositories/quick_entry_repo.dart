import 'package:freeme/api/api_helpers.dart';

import '../../models/taxed_nontaxed_item.dart';
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
    List<TaxedNonTaxedModel>? taxedItems,
    List<TaxedNonTaxedModel>? nonTaxedItems,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = '';
    var queryParameters = {
      RequestParam.service: MethodNames.quickEntry,
      RequestParam.showError: false,
    };

    var reqData = {
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
      "taxed_items": taxedItems?.map((e) => e.toJson()).toList(),
      "non_taxed_items": nonTaxedItems?.map((e) => e.toJson()).toList()
    };

    result = await BaseApiHelper.postRequest(
      requestUrl: AppUrls.baseUrl,
      queryParam: queryParameters,
      requestData: reqData,
      passAuthToken: true,
      isMultipart: false,
    );
    status = result.status;
    data = result.data;
    message = result.message;
    return ResponseItem(data: data, message: message, status: status);
  }

  static Future<ResponseItem> addJobSubmit({
    String? jobId,
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
    List<TaxedNonTaxedModel>? taxedItems,
    List<TaxedNonTaxedModel>? nonTaxedItems,
  }) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = '';
    var queryParameters = {
      RequestParam.service: jobId!=null?MethodNames.editJob:MethodNames.addJob,
      RequestParam.showError: false,
    };

    var reqData = {
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
      "taxed_items": taxedItems?.map((e) => e.toJson()).toList(),
      "non_taxed_items": nonTaxedItems?.map((e) => e.toJson()).toList()
    };
    if (jobId != null) {
      reqData["job_id"] = jobId;
    }
    result = await BaseApiHelper.postRequest(
      requestUrl: AppUrls.baseUrl,
      queryParam: queryParameters,
      requestData: reqData,
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

  static Future<ResponseItem> allJobClassificationsList() async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = '';
    var queryParameters = {
      RequestParam.service: MethodNames.getAllJobClassifications,
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

  static Future<ResponseItem> allSubJobClassificationList(num id) async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = '';
    var queryParameters = {
      RequestParam.service: MethodNames.getAllSubJobClassifications,
      RequestParam.showError: false,
    };
    result = await BaseApiHelper.postRequest(
      requestUrl: AppUrls.baseUrl,
      queryParam: queryParameters,
      requestData: {"job_classification_id": id},
      passAuthToken: true,
      isMultipart: false,
    );
    status = result.status;
    data = result.data;
    message = result.message;
    return ResponseItem(data: data, message: message, status: status);
  }

  static Future<ResponseItem> getTaxedItemTypeList() async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = '';
    var queryParameters = {
      RequestParam.service: MethodNames.getAllTaxedItemType,
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

  static Future<ResponseItem> getPerTimeList() async {
    ResponseItem result;
    bool status = true;
    dynamic data;
    String message = '';
    var queryParameters = {
      RequestParam.service: MethodNames.getAllTaxPerTime,
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
