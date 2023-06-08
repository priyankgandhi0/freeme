import 'dart:convert';

List<JobClassificationModel> jobClassificationModelFromJson(dynamic str) {
  return (str as List).map((e) => JobClassificationModel.fromJson(e)).toList();
}

class JobClassificationModel {
  JobClassificationModel.fromJson(dynamic json) {
    _jobClassificationId = json['job_classification_id'];
    _jobClassificationCategory = json['job_classification_category'];
  }

  num? _jobClassificationId;
  String? _jobClassificationCategory;

  num? get jobClassificationId => _jobClassificationId;

  String? get jobClassificationCategory => _jobClassificationCategory;
}
