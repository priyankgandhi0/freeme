import 'dart:convert';

List<JobClassificationModel> jobClassificationModelFromJson(dynamic str) {
  return (str as List).map((e) => JobClassificationModel.fromJson(e)).toList();
}

class JobClassificationModel {
  JobClassificationModel.fromJson(dynamic json) {
    _jobClassificationId = json['job_classification_id'];
    _jobClassificationCategory = json['job_classification_category'];
  }

  int? _jobClassificationId;
  String? _jobClassificationCategory;

  int? get jobClassificationId => _jobClassificationId;

  String? get jobClassificationCategory => _jobClassificationCategory;
}
