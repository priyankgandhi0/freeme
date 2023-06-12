import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freeme/ui/widgets/flutter_time_picker_spinner.dart';
import 'package:freeme/utils/extension.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../constant/app_string.dart';
import '../../../../../constant/space_constant.dart';
import '../../../../../generated/assets.dart';
import '../../../../../theme/app_colors.dart';
import '../../../../../utils/route_manager.dart';
import '../../../../widgets/app_calender.dart';
import '../../../../widgets/fm_button.dart';
import '../../../../widgets/fm_dialog.dart';
import '../../../../widgets/fm_image.dart';
import '../../../profile/timecard/timecard_controller.dart';

class TimeCardTabScreen extends StatelessWidget {
  TimeCardTabScreen({
    Key? key,
    required this.jobId,
    required this.dayId,
    required this.date,
  }) : super(key: key);

  num jobId;
  num dayId;
  String date;

  final controller = Get.put(TimeCardController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<TimeCardController>(
        initState: (initState) {
          Future.delayed(Duration.zero, () {
            controller.getWorkHistory(jobId, changeFormat(date));
          });
        },
        builder: (ctrl) {
          return Column(
            children: [
              _timeAddressCard(),
              dataTableCard(),
              _duplicateTimeButton(context).paddingOnly(bottom: 124.sh()),
              /* Expanded(
          child: Container(),
        ),*/
              _clockInButton(context),

              ///lunch start button
              //_lunchStartButton(context),

              ///lunch end button
              //_lunchEndButton(context),

              ///second meal button
              //_secondMealStartWrapButton(context),

              ///second meal end wrap
              _secondMealEndWrapButton(context)
            ],
          );
        },
      ),
    );
  }

  Widget _secondMealEndWrapButton(BuildContext context) {
    return FmButton(
      ontap: () {
        showSelectTimeDialog(context);
      },
      name: secondMealEndWrap,
      type: ButtonType.yellow,
    ).paddingOnly(
      left: 16,
      right: 16,
      bottom: 24,
    );
  }

  Widget _secondMealStartWrapButton(BuildContext context) {
    return FmButton(
      ontap: () {
        showSelectTimeDialog(context);
      },
      name: secondMealStartWrap,
      type: ButtonType.yellow,
    ).paddingOnly(
      left: 16,
      right: 16,
      bottom: 24,
    );
  }

  Widget _lunchEndButton(BuildContext context) {
    return FmButton(
      ontap: () {
        showSelectTimeDialog(context);
      },
      name: lunchEnd,
      type: ButtonType.yellow,
    ).paddingOnly(
      left: 16,
      right: 16,
      bottom: 24,
    );
  }

  Widget _lunchStartButton(BuildContext context) {
    return FmButton(
      ontap: () {
        showSelectTimeDialog(context);
      },
      name: lunchStartWrap,
      type: ButtonType.yellow,
    ).paddingOnly(
      left: 16,
      right: 16,
      bottom: 24,
    );
  }

  Widget _clockInButton(BuildContext context) {
    return FmButton(
      ontap: () {
        showSelectTimeDialog(context);
      },
      name: clockIn,
      type: ButtonType.greenCircular,
    ).paddingOnly(
      left: 16,
      right: 16,
      bottom: 24,
    );
  }

  showSelectTimeDialog(BuildContext context) {
    fMDialog(
      context: context,
      horizontalPadding: screenWPadding64.sw(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  "Select Time"
                      .text(
                        fontSize: 18,
                        weight: FontWeight.w500,
                      )
                      .paddingOnly(
                        top: screenHPadding16.sh(),
                        bottom: screenHPadding8.sh(),
                      ),
                ],
              ),
              FmImage.assetImage(
                path: Assets.iconsCloseIcon,
                fit: BoxFit.fill,
                size: 12,
              )
                  .onTap(
                    () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                  )
                  .paddingOnly(
                    top: 20.sh(),
                    bottom: 20.sh(),
                    left: 20.sh(),
                    right: screenWPadding16.sw(),
                  )
                  .positioned(right: 0)
            ],
          ),
          Container(
            width: Get.width,
            height: 1,
            color: bottomLineGreyColor,
          ),
          TimePickerSpinner(
            isForce2Digits: true,
            normalTextStyle: const TextStyle(
              fontFamily: sfPro,
              fontSize: 18,
              color: greyTextColor,
            ),
            highlightedTextStyle: const TextStyle(
                fontFamily: sfPro,
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w500),
            itemHeight: 36,
            is24HourMode: false,
            onTimeChange: (time) {},
          ),

          ///clock in
          FmButton(
            ontap: () {},
            name: clockIn,
            type: ButtonType.greenCircular,
          ).paddingOnly(
            left: screenWPadding32.sw(),
            right: screenWPadding32.sw(),
            bottom: 24.sh(),
            top: 24.sh(),
          ),

          ///lunch start
          /* FmButton(
            ontap: () {
              showSelectTimeDialog(context);
            },
            name: lunchStart,
            type: ButtonType.yellow,
          ).paddingOnly(
            left: screenWPadding32.sw(),
            right: screenWPadding32.sw(),
            top: 24.sh(),
          ),*/

          ///second meal start
          /* FmButton(
            ontap: () {
              showSelectTimeDialog(context);
            },
            name: secondMealStart,
            type: ButtonType.yellow,
          ).paddingOnly(
            left: screenWPadding32.sw(),
            right: screenWPadding32.sw(),
            top: 24.sh(),
          ),*/

          ///second meal end
          /*FmButton(
            ontap: () {
              showSelectTimeDialog(context);
            },
            name: secondMealEnd,
            type: ButtonType.yellow,
          ).paddingOnly(
            left: screenWPadding32.sw(),
            right: screenWPadding32.sw(),
            top: 24.sh(),
          ),*/

          ///wrapButtton
          /*FmButton(
            ontap: () {},
            name: wrap,
            type: ButtonType.red,
          ).paddingOnly(
            left: screenWPadding32.sw(),
            right: screenWPadding32.sw(),
            bottom: 24.sh(),
            top: screenHPadding16.sh()
          )*/
        ],
      ),
    );
  }

  Widget _duplicateTimeButton(BuildContext context) {
    return FmButton(
      ontap: () {
        showDuplicateTimeDialog(context);
      },
      name: duplicateTimes,
      type: ButtonType.fullGreen,
    ).paddingOnly(
      top: screenHPadding16.sh(),
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
    );
  }

  showDuplicateTimeDialog(BuildContext context) {
    fMDialog(
      context: context,
      horizontalPadding: 16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  duplicateTimes
                      .text(
                        fontSize: 18,
                        weight: FontWeight.w500,
                      )
                      .paddingOnly(
                        top: screenHPadding16.sh(),
                        bottom: screenHPadding16.sh(),
                      ),
                ],
              ),
              FmImage.assetImage(
                path: Assets.iconsCloseIcon,
                fit: BoxFit.fill,
                size: 12,
              )
                  .paddingOnly(
                top: 22.sh(),
                right: 22.sw(),
                left: 22.sw(),
                bottom: 22.sw(),
              )
                  .onTap(
                () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ).positioned(right: 0)
            ],
          ),
          Container(
            width: Get.width,
            height: 1,
            color: bottomLineGreyColor,
          ),
          _horizontalCalender(),
          _duplicateDialogButton(context)
        ],
      ),
    );
  }

  Widget _duplicateDialogButton(BuildContext context) {
    return FmButton(
      ontap: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
      name: duplicate,
    ).paddingOnly(
      top: screenHPadding8.sh(),
      bottom: 24.sh(),
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
    );
  }

  Widget _timeAddressCard() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
          color: Colors.white),
      child: Row(
        children: [
          FmImage.assetImage(
            path: Assets.iconsBackwordIcon,
            height: 15,
            width: 15,
          ).paddingOnly(
            left: screenHPadding16.sw(),
          ),
          Expanded(
            child: Column(
              children: [
                "Thursday, July 21, 2022"
                    .text(
                      fontSize: 16,
                      weight: FontWeight.w500,
                    )
                    .paddingOnly(
                      top: screenHPadding16.sh(),
                    ),
                "1812 W. Burbank Ave, Burbank, CA 91506"
                    .text(fontSize: 16, fontColor: greyTextColor)
                    .paddingOnly(
                      top: screenHPadding8.sh(),
                      bottom: screenHPadding16.sh(),
                    )
              ],
            ),
          ),
          FmImage.assetImage(
            path: Assets.iconsForwardIcon,
            height: 15,
            width: 15,
          ).paddingOnly(
            right: screenHPadding16.sw(),
          )
        ],
      ),
    ).paddingOnly(
        left: screenHPadding16.sw(),
        right: screenHPadding16.sw(),
        top: 24.sh());
  }

  dataTableCard() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                "Day Type"
                    .text(
                      fontSize: screenWPadding16.sw(),
                      weight: FontWeight.w500,
                    )
                    .paddingOnly(
                      left: screenWPadding16.sw(),
                      top: screenHPadding16.sh(),
                      bottom: screenHPadding16.sh(),
                    ),
                "Shoot Day"
                    .text(
                      fontSize: screenWPadding16.sw(),
                      weight: FontWeight.w500,
                    )
                    .paddingOnly(
                      right: screenWPadding16.sw(),
                      top: screenHPadding16.sh(),
                      bottom: screenHPadding16.sh(),
                    ),
              ],
            ),
          ),
          ListView.builder(
            itemCount: controller.clockTimeList.length,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return dayTypeListItem(controller.clockTimeList[index]);
            },
          ),
          SizedBox(
            height: screenHPadding16.sh(),
          )
        ],
      ),
    ).paddingOnly(
      left: screenHPadding16.sw(),
      right: screenHPadding16.sw(),
      top: screenHPadding16.sh(),
    );
  }

  Widget _horizontalCalender() {
    return GetBuilder<TimeCardController>(
      builder: (ctrl) {
        return WeeklyCalender(
          currentDay: ctrl.currentDay,
          focusDay: ctrl.focusedDay,
          onDaySelected: (selectedDay, focusDay) {
            ctrl.onDaySelect(selectedDay, focusDay);
          },
          onMonthChange: (date) {},
          selectedDays: ctrl.selectedDays,
          calenderFormat: CalendarFormat.week,
        ).paddingAll(10);
      },
    );
  }

  Widget dayTypeListItem(ClockTime data) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          data.title.text(fontSize: 16),
          data.time.text(fontSize: 16),
        ],
      ).paddingOnly(
        top: screenHPadding16.sh(),
        left: screenWPadding16.sw(),
        right: screenWPadding16.sw(),
      ),
    );
  }

  String changeFormat(String? date) {
    if (date != null) {
      DateTime tempDate = DateFormat("yyyy-MM-dd hh:mm:ss").parse(date);
      String formattedDate = DateFormat('yyyy-MM-dd').format(tempDate);
      return formattedDate;
    } else {
      return "";
    }
  }
}
