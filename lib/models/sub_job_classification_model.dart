import 'dart:convert';


List<SubJobClassificationModel> subJobClassificationModelFromJson(dynamic str){
  return (str as List).map((e) => SubJobClassificationModel.fromJson(e)).toList();
}

class SubJobClassificationModel {
  SubJobClassificationModel({
      int? subJobClassificationsId,
      num? jobClassificationId, 
      String? subJobClassificationsCategory,}){
    _subJobClassificationsId = subJobClassificationsId;
    _jobClassificationId = jobClassificationId;
    _subJobClassificationsCategory = subJobClassificationsCategory;
}

  SubJobClassificationModel.fromJson(dynamic json) {
    _subJobClassificationsId = json['sub_job_classifications_id'];
    _jobClassificationId = json['job_classification_id'];
    _subJobClassificationsCategory = json['sub_job_classifications_category'];
  }
  int? _subJobClassificationsId;
  num? _jobClassificationId;
  String? _subJobClassificationsCategory;

  int? get subJobClassificationsId => _subJobClassificationsId;
  num? get jobClassificationId => _jobClassificationId;
  String? get subJobClassificationsCategory => _subJobClassificationsCategory;


}