import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:freeme/api/api_globle.dart';
import 'package:freeme/api/repositories/job_repo.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../api/response_item.dart';
import '../../../../calender_demo/utils.dart';
import '../../../../globle.dart';
import '../../../../models/edit_timecard_request.dart';
import '../../../../models/get_job_info_model.dart';
import '../../../../models/work_history_model.dart';
import '../../navigator/main_controller.dart';

class TimeCardController extends GetxController {
  var focusedDay = DateTime.now();
  late String selectedDate;
  DateTime currentDay = DateTime.now();

  DateTime clockInTime = DateTime.now();

  final Set<DateTime> selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  void onDaySelect(DateTime selectedDay, DateTime focusDay) {
    focusedDay = focusDay;
    /*if (selectedDays.contains(selectedDay)) {
      selectedDays.remove(selectedDay);
    } else {
      selectedDays.add(selectedDay);
    }*/
    selectedDays.clear();
    selectedDays.add(selectedDay);
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
    update();
  }

  WorkHistoryModel? historyModel;

  Future<void> getWorkHistory(num? jobId, String date) async {
    startLoading();
    ResponseItem response = await JobRepo.getWorkHistory(jobId ?? -1, date);
    if (response.status) {
      historyModel = WorkHistoryModel.fromJson(response.data);
      if (historyModel != null) {
        setUpData(historyModel!);
      }
      update();
      stopLoading();
    } else {
      stopLoading();
    }
  }

  List<ClockTime> clockTimeList = [];

  void setUpData(WorkHistoryModel model) {
    clockTimeList.clear();
    clockTimeList.add(ClockTime("Call Time:",
        model.callTime.isNullOrEmpty ? "--:-- AM/PM" : model.callTime));
    clockTimeList.add(ClockTime(
        "1st Meal Start:",
        model.firstMealStart.isNullOrEmpty
            ? "--:-- AM/PM"
            : model.firstMealStart));
    clockTimeList.add(ClockTime("1st Meal End:",
        model.firstMealEnd.isNullOrEmpty ? "--:-- AM/PM" : model.firstMealEnd));
    clockTimeList.add(ClockTime(
        "2nd Meal Start:",
        model.secondMealStart.isNullOrEmpty
            ? "--:-- AM/PM"
            : model.secondMealStart));
    clockTimeList.add(ClockTime(
        "2nd Meal End:",
        model.secondMealEnd.isNullOrEmpty
            ? "--:-- AM/PM"
            : model.secondMealEnd));
    clockTimeList.add(ClockTime(
        "Wrap:", model.wrap.isNullOrEmpty ? "--:-- AM/PM" : model.wrap));
  }

  Future<void> clockIn({
    required ClockedTimes clockInTime,
    required num jobId,
    required String date,
  }) async {
    startLoading();
    try {
      var request = EditTimecardRequest(
        jobId: jobId,
        date: date,
        clockedTimes: clockInTime,
      );
      ResponseItem response = await JobRepo.editWorkHistoryTimecard(
        request.toJson(),
      );
      if (response.status) {
        await getWorkHistory(jobId, date);
        update();
        stopLoading();
      } else {
        stopLoading();
      }
    } catch (e) {
      stopLoading();
    }
  }

  GetJobInfoModel? jobInfo;

  List<String> weekDays = [];
  Future<void> getJobInfo({
    required int jobId,
    required String endDate,
  }) async {
    startLoading();
    ResponseItem response = await JobRepo.getJobInfo(jobId);
    if (response.status) {
      jobInfo = GetJobInfoModel.fromJson(response.data);
      weekDays.clear();
      jobInfo?.days?.forEach((e) {
        if(changeToApiFormat(expandingChildItem(e))==endDate){
          weekDays.add(e.date.toString());
        }
      });
      stopLoading();
    } else {
      stopLoading();
    }
  }

  String changeToApiFormat(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  DateTime expandingChildItem(Days e) {
    DateTime tempDate = DateFormat("yyyy-MM-dd").parse(e.date.toString());
    return findSaturdayDateOfTheWeek(tempDate);
  }

  DateTime findSaturdayDateOfTheWeek(DateTime dateTime) {
    return dateTime
        .add(Duration(days: DateTime.daysPerWeek - (dateTime.weekday + 1)));
  }

  void changeDateToLeft(String date) {
    if(weekDays.isNotEmpty){
      var index = weekDays.indexWhere((element) => element == date) ?? 0;
      if ((index - 1) >= 0) {
        getWorkHistory(jobInfo?.jobId, weekDays[index-1]);
        selectedDate = weekDays[index-1];
        update();
      }
    }
  }


  void changeDateToRight(String date) {
    if(weekDays.isNotEmpty){
      var index = weekDays.indexWhere((element) => element == date) ?? 0;
      if ((index + 1) < weekDays.length){
        getWorkHistory(jobInfo?.jobId, weekDays[index+1]);
        selectedDate = weekDays[index+1];
        update();
      }
    }
  }

  bool isLunchStartValidate(String time, BuildContext context) {
    if (historyModel?.callTime != null && historyModel?.date != null) {
      var time1 = convertToMyTimeFormat(
        historyModel?.callTime ?? "",
        historyModel?.date ?? "",
      );
      var time2 = convertToMyTimeFormat(
        time,
        historyModel?.date ?? "",
      );
      if (time2.isAfter(time1)) {
        return true;
      } else {
        lunchMustBeginAfterCallTime.errorSnack(context);
        return false;
      }
    }
    return false;
  }

  bool isLunchEndValidate(String time, BuildContext context) {
    if (historyModel?.firstMealStart != null && historyModel?.date != null) {
      var time1 = convertToMyTimeFormat(
        historyModel?.firstMealStart ?? "",
        historyModel?.date ?? "",
      );
      var time2 = convertToMyTimeFormat(
        time,
        historyModel?.date ?? "",
      );
      if (time2.isAfter(time1)) {
        return true;
      } else {
        lunchEndMustBeginAfterLunchStart.errorSnack(context);
        return false;
      }
    }
    return false;
  }

  bool isSecondMealStartValidate(String time, BuildContext context) {
    if (historyModel?.firstMealEnd != null && historyModel?.date != null) {
      var time1 = convertToMyTimeFormat(
        historyModel?.firstMealEnd ?? "",
        historyModel?.date ?? "",
      );
      var time2 = convertToMyTimeFormat(
        time,
        historyModel?.date ?? "",
      );
      if (time2.isAfter(time1)) {
        return true;
      } else {
        secondMealStartMustBeginAfterFirstMealEnd.errorSnack(context);
        return false;
      }
    }
    return false;
  }

  bool isSecondMealEndValidate(String time, BuildContext context) {
    if (historyModel?.secondMealStart != null && historyModel?.date != null) {
      var time1 = convertToMyTimeFormat(
        historyModel?.secondMealStart ?? "",
        historyModel?.date ?? "",
      );
      var time2 = convertToMyTimeFormat(
        time,
        historyModel?.date ?? "",
      );
      if (time2.isAfter(time1)) {
        return true;
      } else {
        secondMealEndMustBeginAfterSecondMealStart.errorSnack(context);
        return false;
      }
    }
    return false;
  }

  convertToMyTimeFormat(String time, String date) {
    var now = date.split("-");
    int hour = int.parse(time.split(":").first.toString());
    int minute = int.parse(time.split(":").last.substring(0, 2));
    bool isPm = time.contains("PM") ? true : false;
    return DateTime.utc(
        int.parse(now[0]),
        int.parse(now[1]),
        int.parse(now[2]),
        isPm
            ? hour != 12
                ? hour + 12
                : hour
            : hour,
        minute,
        0);
  }
}

class ClockTime {
  String? title;
  String? time;

  ClockTime(this.title, this.time);
}
