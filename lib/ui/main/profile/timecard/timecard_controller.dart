import 'dart:collection';

import 'package:freeme/api/repositories/job_repo.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../api/response_item.dart';
import '../../../../calender_demo/utils.dart';
import '../../../../globle.dart';
import '../../../../models/work_history_model.dart';
import '../../navigator/main_controller.dart';

class TimeCardController extends GetxController{
  var focusedDay = DateTime.now();

  DateTime currentDay = DateTime.now();

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
      if(historyModel!=null){
        setUpData(historyModel!);
      }
      update();
      stopLoading();
    } else {
      stopLoading();
    }
  }

  List<ClockTime> clockTimeList = [

  ];

  void setUpData(WorkHistoryModel model) {
    clockTimeList.clear();
    clockTimeList.add(ClockTime("Call Time:",model.callTime.isNullOrEmpty?"--:-- AM/PM":model.callTime));
    clockTimeList.add(ClockTime("1st Meal Start:",model.firstMealStart.isNullOrEmpty?"--:-- AM/PM":model.firstMealStart));
    clockTimeList.add(ClockTime("1st Meal End:",model.firstMealEnd.isNullOrEmpty?"--:-- AM/PM":model.firstMealEnd));
    clockTimeList.add(ClockTime("2nd Meal Start:",model.secondMealStart.isNullOrEmpty?"--:-- AM/PM":model.secondMealStart));
    clockTimeList.add(ClockTime("2nd Meal End:",model.secondMealEnd.isNullOrEmpty?"--:-- AM/PM":model.secondMealEnd));
    clockTimeList.add(ClockTime("Wrap:",model.wrap.isNullOrEmpty?"--:-- AM/PM":model.wrap));

  }

}

class ClockTime {
  String? title;
  String? time;

  ClockTime(this.title, this.time);
}