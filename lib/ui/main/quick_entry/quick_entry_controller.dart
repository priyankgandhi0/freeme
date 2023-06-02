import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../calender_demo/utils.dart';
import '../../../globle.dart';
import '../../widgets/dropdown.dart';

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



  List<MenuItem> typeByList = [
    MenuItem(text: "Not Sure", isSelected: true),
    MenuItem(text: "Commercial", isSelected: false),
    MenuItem(text: "Episodic Scripted", isSelected: false),
    MenuItem(text: "Music Video", isSelected: false),
    MenuItem(text: "Episodic Unscripted", isSelected: false),
    MenuItem(text: "Short Film", isSelected: false),
    MenuItem(text: "Other", isSelected: false),
  ];

  void onTypeDropDownTap(MenuItem item) {
    for (int i = 0; i <  typeByList.length; i++) {
      if ( typeByList[i].text == item.text) {
        if ( typeByList[i].isSelected) {
           typeByList[i].isSelected = false;
        } else {
           typeByList[i].isSelected = true;
        }
      } else {
         typeByList[i].isSelected = false;
      }
    }
     update();
  }
}
