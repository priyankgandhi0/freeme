import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../calender_demo/utils.dart';
import '../../../globle.dart';

class QuickEntryController extends GetxController {

  bool isExpanded = false;

  PageController pageController = PageController(initialPage: 0);
  int activatePage = 0;

  var focusedDay = DateTime.now();

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

  void onPageChange(int page) {
    activatePage = page;
    update();
  }

  onExpansionChange(bool value){
    isExpanded =value;
    update(["CompanyAdddressExpanded"]);
  }
}
