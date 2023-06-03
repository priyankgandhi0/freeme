import 'dart:collection';

import 'package:table_calendar/table_calendar.dart';

import '../../../calender_demo/utils.dart';
import '../../../globle.dart';
import '../../widgets/dropdown.dart';

class AddJobController extends GetxController {
  bool isExpanded = false;

  onExpansionChange(bool value) {
    isExpanded = value;
    update(["CompanyAdddressExpanded"]);
  }

  var nonTaxedItem = [
    NonTaxedItem("Monitor", "\$250 / Day"),

  ];

  var taxedItem = [
    NonTaxedItem("Monitor", "\$250 / Day"),

  ];



  List<MenuItem> perHoursList = [
    MenuItem(text: "10 hours", isSelected: true),
    MenuItem(text: "Hourly", isSelected: false),
    MenuItem(text: "8 hours", isSelected: false),
    MenuItem(text: "12 hours", isSelected: false),
  ];

  List<MenuItem> guaranteedHoursList = [
    MenuItem(text: "Not Sure", isSelected: true),
    MenuItem(text: "8 hours", isSelected: false),
    MenuItem(text: "10 hours", isSelected: false),
    MenuItem(text: "12 hours", isSelected: false),
  ];
  List<MenuItem> w21099List = [
    MenuItem(text: "Not Sure", isSelected: true),
    MenuItem(text: "W2", isSelected: false),
    MenuItem(text: "1099", isSelected: false),
  ];

  List<MenuItem> paidByList = [
    MenuItem(text: "Not Sure", isSelected: true),
    MenuItem(text: "ABS Payroll", isSelected: false),
    MenuItem(text: "Cast & Crew", isSelected: false),
    MenuItem(text: "Entertainment Partners", isSelected: false),
    MenuItem(text: "Extreme reach", isSelected: false),
    MenuItem(text: "Greenslate", isSelected: false),
    MenuItem(text: "Media services", isSelected: false),
    MenuItem(text: "NPI Entertainment Payroll", isSelected: false),
    MenuItem(text: "Payday", isSelected: false),
    MenuItem(text: "The Jacobson Group", isSelected: false),
    MenuItem(text: "The TEAM Services", isSelected: false),
    MenuItem(text: "Other", isSelected: false),
  ];

  List<MenuItem> termsList = [
    MenuItem(text: "Not Sure", isSelected: true),
    MenuItem(text: "Net 15", isSelected: false),
    MenuItem(text: "Net 30", isSelected: false),
    MenuItem(text: "Other", isSelected: false),
  ];

  List<MenuItem> typeList = [
    MenuItem(text: "Not Sure", isSelected: true),
    MenuItem(text: "Commercial", isSelected: false),
    MenuItem(text: "Episodic Scripted", isSelected: false),
    MenuItem(text: "Music Video", isSelected: false),
    MenuItem(text: "Episodic Unscripted", isSelected: false),
    MenuItem(text: "Short Film", isSelected: false),
    MenuItem(text: "Other", isSelected: false),
  ];

  List<MenuItem> unionNonUnionList = [
    MenuItem(text: "Not Sure", isSelected: true),
    MenuItem(text: "Yes", isSelected: false),
    MenuItem(text: "No", isSelected: false),
  ];


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
    update(["DaysDialogController"]);
  }
}

class NonTaxedItem {
  String name;
  String value;

  NonTaxedItem(this.name, this.value);
}
