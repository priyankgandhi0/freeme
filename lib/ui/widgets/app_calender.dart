import 'package:flutter/material.dart';
import 'package:freeme/globle.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../constant/space_constant.dart';

class AppCalender extends StatefulWidget {
  OnDaySelected? onDaySelected;
  DateTime? currentDay = DateTime.now();
  DateTime? focusDay = DateTime.now();
  Function(DateTime focusedDay)? onMonthChange;

  Function(PageController pageController)? onCalenderCreated;
  Function? calenderBuildCompleted;
  Set<DateTime>? selectedDays;

  AppCalender({
    this.currentDay,
    this.onDaySelected,
    this.onMonthChange,
    this.onCalenderCreated,
    this.calenderBuildCompleted,
    this.focusDay,
    this.selectedDays,
    Key? key,
  }) : super(key: key);

  @override
  State<AppCalender> createState() => _AppCalenderState();
}

class _AppCalenderState extends State<AppCalender> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.calenderBuildCompleted != null) {
        widget.calenderBuildCompleted!();
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        border: Border.all(width: 1),
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 20),
        lastDay: DateTime.utc(2040, 10, 20),
        focusedDay: widget.focusDay!,
        headerVisible: true,
        // currentDay: widget.currentDay!,
        onDaySelected: widget.onDaySelected,
        selectedDayPredicate: (day) {
          return widget.selectedDays?.contains(day) ?? false;
        },
        calendarFormat: CalendarFormat.month,
        daysOfWeekVisible: true,
        sixWeekMonthsEnforced: false,
        daysOfWeekHeight: 40,
        rowHeight: 50,
        onCalendarCreated: widget.onCalenderCreated ?? (controller) {},
        shouldFillViewport: false,
        headerStyle: headerStyle(),
        availableCalendarFormats: const {
          CalendarFormat.month: 'Month',
        },
        daysOfWeekStyle: daysOfWeekStyle(),
        calendarStyle: calenderStyle(),
      ),
    ).paddingSymmetric(horizontal: screenWPadding16);
  }

  DaysOfWeekStyle daysOfWeekStyle() {
    return DaysOfWeekStyle(
      weekdayStyle: fMTextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      weekendStyle: fMTextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  BoxDecoration decoration() {
    return BoxDecoration(
      shape: BoxShape.circle,
      color: backGroundGreenColor,
      border: Border.all(
        color: Colors.black,
        width: 1,
      ),
    );
  }

  TextStyle fMTextStyle({
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
  }) {
    return TextStyle(
        color: color,
        fontFamily: sfPro,
        fontWeight: fontWeight,
        fontSize: fontSize);
  }

  HeaderStyle headerStyle() {
    return HeaderStyle(
      titleCentered: true,
      headerPadding: const EdgeInsets.only(top: 9),
      rightChevronVisible: true,
      leftChevronVisible: true,
      rightChevronPadding: 25.0.paddingHorizontal,
      leftChevronPadding: 25.0.paddingHorizontal,
      leftChevronIcon: const Icon(
        Icons.chevron_left,
        size: 30,
        color: Colors.black,
      ),
      rightChevronIcon: const Icon(
        Icons.chevron_right,
        size: 30,
        color: Colors.black,
      ),
      titleTextStyle: fMTextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      ),
    );
  }

  CalendarStyle calenderStyle() {
    return CalendarStyle(
      outsideDaysVisible: false,
      cellMargin: EdgeInsets.all(3),
      defaultTextStyle: fMTextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 15,
      ),
      weekendTextStyle: fMTextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 15,
      ),
      selectedTextStyle: fMTextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      todayTextStyle: fMTextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
      cellPadding: EdgeInsets.zero,
      selectedDecoration: decoration(),
      todayDecoration: decoration(),
    );
  }
}

