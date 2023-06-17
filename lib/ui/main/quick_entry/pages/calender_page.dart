import 'package:flutter/material.dart';
import 'package:freeme/globle.dart';
import '../../../widgets/app_calender.dart';
import '../quick_entry_controller.dart';

class CalenderPage extends StatelessWidget {
  CalenderPage({Key? key}) : super(key: key);

  final controller = Get.find<QuickEntryController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuickEntryController>(
      builder: (ctrl) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  "Which days are you working?*".text(
                    fontSize: 20,
                    fontColor: redColor,
                    weight: FontWeight.w600,
                  )
                ],
              ).paddingOnly(
                left: screenWPadding16.sw(),
                bottom: screenHPadding16.sh(),
              ),
              AppCalender(
                // currentDay: controller.currentDay,
                focusDay: controller.focusedDay,
                onDaySelected: (selectedDay, focusDay) {
                  controller.onDaySelect(selectedDay, focusDay);
                },
                onMonthChange: (date) {},
                selectedDays: ctrl.selectedDays,
                error: ctrl.calenderError,
              ),
              /*Row(
                children: [
                  controller.calenderError != null
                      ? controller.calenderError.text(fontColor: redColor)
                      : Container(),
                ],
              ).paddingOnly(
                left: screenWPadding16.sw(),
                top: screenHPadding8.sh(),
              ),*/
              FmButton(
                ontap: () {
                  controller.moveToSecondPage();
                },
                name: next,
              ).paddingOnly(
                left: screenWPadding16.sw(),
                right: screenWPadding16.sw(),
                top: screenHPadding32.sh(),
              )
            ],
          ),
        );
      },
    );
  }
}
