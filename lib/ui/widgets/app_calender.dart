import 'package:flutter/material.dart';
import 'package:freeme/globle.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import '../../constant/space_constant.dart';

class AppCalender extends StatefulWidget {
  OnDaySelected? onDaySelected;
  DateTime? currentDay = DateTime.now();
  DateTime? focusDay = DateTime.now();
  Function(DateTime focusedDay)? onMonthChange;

  Function(PageController pageController)? onCalenderCreated;
  Function? calenderBuildCompleted;
  Set<DateTime>? selectedDays;
  CalendarFormat? calenderFormat;
  String? error;

  AppCalender({
    this.currentDay,
    this.onDaySelected,
    this.onMonthChange,
    this.onCalenderCreated,
    this.calenderBuildCompleted,
    this.focusDay,
    this.selectedDays,
    this.calenderFormat,
    this.error,
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
        border: Border.all(
          width: 1,
          color: widget.error != null ? redColor : Colors.black,
        ),
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
        calendarFormat: widget.calenderFormat ?? CalendarFormat.month,
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
      todayDecoration: todaysDecoration(),
    );
  }

  BoxDecoration todaysDecoration() {
    return BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white,
      border: Border.all(
        color: Colors.white,
        width: 1,
      ),
    );
  }
}

class WeeklyCalender extends StatefulWidget {
  OnDaySelected? onDaySelected;
  DateTime? currentDay = DateTime.now();
  DateTime? focusDay = DateTime.now();
  Function(DateTime focusedDay)? onMonthChange;

  Function(PageController pageController)? onCalenderCreated;
  Function? calenderBuildCompleted;
  Set<DateTime>? selectedDays;
  CalendarFormat? calenderFormat;

  WeeklyCalender({
    this.currentDay,
    this.onDaySelected,
    this.onMonthChange,
    this.onCalenderCreated,
    this.calenderBuildCompleted,
    this.focusDay,
    this.selectedDays,
    this.calenderFormat,
    Key? key,
  }) : super(key: key);

  @override
  State<WeeklyCalender> createState() => _WeeklyCalenderState();
}

class _WeeklyCalenderState extends State<WeeklyCalender> {
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

  late PageController pageController;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 20),
      lastDay: DateTime.utc(2040, 10, 20),
      focusedDay: widget.focusDay!,
      headerVisible: true,
      // currentDay: widget.currentDay!,
      onDaySelected: widget.onDaySelected,
      selectedDayPredicate: (day) {
        return widget.selectedDays?.contains(day) ?? false;
      },
      calendarFormat: widget.calenderFormat ?? CalendarFormat.month,
      daysOfWeekVisible: true,
      sixWeekMonthsEnforced: false,
      rowHeight: 82,
      daysOfWeekHeight: 10,
      onCalendarCreated: (controller) {
        pageController = controller;
      },
      shouldFillViewport: false,
      headerStyle: headerStyle(),
      availableCalendarFormats: const {
        CalendarFormat.week: 'Week',
      },
      calendarStyle: calenderStyle(),
      calendarBuilders: calenderBuilders(),
    );
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
      color: backGroundGreenColor,
      //borderRadius: BorderRadius.circular(10),
      border: Border(
        left: BorderSide(
          color: Colors.black,
          width: 1,
        ),
        right: BorderSide(
          color: Colors.black,
          width: 1,
        ),
        bottom: BorderSide(
          color: Colors.black,
          width: 1,
        ),
        top: BorderSide(
          color: backGroundGreenColor,
          width: 1,
        ),
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
      rightChevronVisible: false,
      leftChevronVisible: false,
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

  calenderBuilders() {
    return CalendarBuilders(
      defaultBuilder: (context, day, focusedDay) =>
          defaultBuilder(context, day, focusedDay),
      todayBuilder: (context, day, focusedDay) =>
          defaultBuilder(context, day, focusedDay),
      disabledBuilder: (context, day, focusedDay) =>
          defaultBuilder(context, day, focusedDay),
      outsideBuilder: (context, day, focusedDay) =>
          defaultBuilder(context, day, focusedDay),
      dowBuilder: (context, day) {
        return Container();
      },
      headerTitleBuilder: (context, day) {
        return headerTitleBuilder(context, day);
      },
      selectedBuilder: (context, day, focusedDay) =>
          selectedBuilder(context, day, focusedDay),
    );
  }

  headerTitleBuilder(BuildContext context, DateTime day) {
    var formattedDate = DateFormat("MMMM").format(day);

    return Row(
      children: [
        "$formattedDate ${day.year}".text(
          fontSize: 18,
          weight: FontWeight.w500,
        ),
        Expanded(child: Container()),
        FmImage.assetImage(
          path: Assets.iconsBackwordIcon,
          height: 15.sh(),
          width: 15.sw(),
          color: darkGreenColor2,
        ).onTap(
          () {
            pageController.previousPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut);
          },
        ),
        const SizedBox(
          width: 38,
        ),
        FmImage.assetImage(
          path: Assets.iconsForwardIcon,
          height: 15.sh(),
          width: 15.sw(),
          color: darkGreenColor2,
        ).onTap(() {
          pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut);
        })
      ],
    ).paddingOnly(
      left: screenWPadding8.sw(),
      right: screenWPadding8.sw(),
    );
  }

  Widget? defaultBuilder(
    BuildContext context,
    DateTime day,
    DateTime focusedDay,
  ) {
    return Container(
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.all(
          Radius.circular(50),
        ),
        border: Border.all(
          color: borderGreyColor,
        ),
      ),
      child: Column(
        children: [
          Text(
            DateFormat('E').format(day).toString().characters.first,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: sfPro,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            day.day.toString(), // Date
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: sfPro,
            ),
          )
        ],
      ).paddingAll(8),
    );
  }

  Widget? selectedBuilder(
    BuildContext context,
    DateTime day,
    DateTime focusedDay,
  ) {
    return Container(
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: backGroundGreenColor.withOpacity(0.5),
        borderRadius: const BorderRadius.all(
          Radius.circular(50),
        ),
        border: Border.all(
          color: darkGreenColor2.withOpacity(0.5),
        ),
      ),
      child: Column(
        children: [
          Text(
            DateFormat('E').format(day).toString().characters.first,
            style: const TextStyle(
              color: darkGreenColor2,
              fontSize: 16,
              fontFamily: sfPro,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            day.day.toString(), // Date
            style: const TextStyle(
              color: darkGreenColor2,
              fontSize: 15,
              fontFamily: sfPro,
            ),
          )
        ],
      ).paddingAll(8),
    );
  }
}
