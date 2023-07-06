import 'dart:collection';

import 'package:flutter/src/widgets/framework.dart';
import 'package:freeme/api/api_globle.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../api/repositories/job_repo.dart';
import '../../../../../api/response_item.dart';
import '../../../../../utils/calender_utils.dart';
import '../../../../../globle.dart';
import '../../../../../models/get_job_info_model.dart';
import '../../../navigator/main_controller.dart';

class JobInfoController extends GetxController {
  var focusedDay = DateTime.now();

  @override
  void onInit() {
    super.onInit();
  }

  DateTime currentDay = DateTime.now();

  final Set<DateTime> selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  void onDaySelect(DateTime selectedDay, DateTime focusDay) {
    focusedDay = focusDay;
    if (selectedDays.contains(selectedDay)) {
      selectedDays.remove(selectedDay);
    } else {
      selectedDays.add(selectedDay);
    }
    currentDay = focusDay;
    update();
  }

  startLoading() {
    Future.delayed(Duration.zero, () {
      Get.find<HomeController>().startLoading();
    });
  }

  stopLoading() {
    Future.delayed(Duration.zero, () {
      Get.find<HomeController>().stopLoading();
    });
  }

  GetJobInfoModel? jobInfo;
  Future<void> getJobInfo({
    required int jobId,
  }) async {
    startLoading();
    ResponseItem response = await JobRepo.getJobInfo(jobId);
    if (response.status) {
      jobInfo = GetJobInfoModel.fromJson(response.data);
      setCalenderData();
      stopLoading();
    } else {
      stopLoading();
    }
  }

  void setCalenderData() {
    selectedDays.clear();
    jobInfo?.days?.forEach((element) {
      DateTime tempDate = DateFormat("yyyy-MM-dd").parse(element.date.toString());
      onDaySelect(tempDate, tempDate);
    });

  }

  void clearController() {
    selectedDays.clear();
    jobInfo = null;
  }
}
