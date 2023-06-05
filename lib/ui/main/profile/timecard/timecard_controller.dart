import 'dart:collection';

import 'package:table_calendar/table_calendar.dart';

import '../../../../calender_demo/utils.dart';
import '../../../../globle.dart';

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


  var dayTypeList = [
    DayType("Call Time:","8:00 AM"),
    DayType("1st Meal Start:","2:00 PM"),
    DayType("1st Meal End:","2:45 PM"),
    DayType("2nd Meal Start:","--:-- AM/PM"),
    DayType("2nd Meal End:","--:-- AM/PM"),
    DayType("Wrap:","--:-- AM/PM"),
  ];
}

class DayType {
  String? dayType;
  String? shootDay;

  DayType(this.dayType, this.shootDay);
}