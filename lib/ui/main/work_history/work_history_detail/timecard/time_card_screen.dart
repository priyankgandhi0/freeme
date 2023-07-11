import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freeme/ui/main/work_history/work_history_detail/timecard/timecard_controller.dart';
import 'package:freeme/ui/widgets/flutter_time_picker_spinner.dart';
import 'package:freeme/utils/extension.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../constant/app_string.dart';
import '../../../../../constant/space_constant.dart';
import '../../../../../generated/assets.dart';
import '../../../../../models/edit_timecard_request.dart';
import '../../../../../theme/app_colors.dart';
import '../../../../../utils/calender_utils.dart';
import '../../../../widgets/app_calender.dart';
import '../../../../widgets/fm_button.dart';
import '../../../../widgets/fm_dialog.dart';
import '../../../../widgets/fm_image.dart';

class TimeCardTabScreen extends StatelessWidget {
  TimeCardTabScreen({
    Key? key,
    required this.jobId,
    required this.dayId,
    required this.date,
    required this.endDate,
  }) : super(key: key);

  num jobId;
  num dayId;
  String date;
  String endDate;

  final controller = Get.put(TimeCardController());

  @override
  Widget build(BuildContext context) {
    controller.selectedDate = date;
    return SingleChildScrollView(
      child: GetBuilder<TimeCardController>(
        initState: (initState) {
          controller.selectedDate = date;
          Future.delayed(Duration.zero, () {
            controller.getWorkHistory(jobId, controller.selectedDate);
            controller.getJobInfo(jobId: jobId.toInt(), endDate: endDate);
          });
        },
        builder: (ctrl) {
          return Column(
            children: [
              _timeAddressCard(controller.selectedDate),
               dataTableCard(),
              _duplicateTimeButton(context).paddingOnly(bottom: 124.sh()),
              _buttons(context, ctrl),
            ],
          );
        },
      ),
    );
  }

  Widget _buttons(BuildContext context, TimeCardController ctrl) {
    if (ctrl.historyModel != null) {
      if (ctrl.historyModel?.callTime.isNullOrEmpty ?? false) {
        return _clockInButton(context);
      } else if (ctrl.historyModel?.firstMealStart.isNullOrEmpty ?? false) {
        return _lunchStartButton(context);
      } else if (ctrl.historyModel?.firstMealEnd.isNullOrEmpty ?? false) {
        return _lunchEndButton(context);
      } else if (ctrl.historyModel?.secondMealStart.isNullOrEmpty ?? false) {
        return _secondMealStartWrapButton(context);
      } else if (ctrl.historyModel?.secondMealEnd.isNullOrEmpty ?? false) {
        return _secondMealEndWrapButton(context);
      } else if (ctrl.historyModel?.wrap.isNullOrEmpty ?? false) {
        return _wrapButton(context);
      } else {
        return Container();
      }
    } else {
      return Container();
    }
  }

  Widget _wrapButton(BuildContext context) {
    return FmButton(
      ontap: () {
        showSelectTimeDialog(context);
      },
      name: wrap,
      type: ButtonType.red,
    ).paddingOnly(
      left: 16,
      right: 16,
      bottom: 24,
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

  showSelectTimeDialog(
    BuildContext context,
  ) {
    fMDialog(
      context: context,
      horizontalPadding: screenWPadding64.sw(),
      child: GetBuilder<TimeCardController>(
        builder: (ctrl) {
          return Column(
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
                time: DateTime.now().subtract(
                  const Duration(hours: 1,minutes: 1),
                ),
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
                itemWidth: 65,
                is24HourMode: false,
                onTimeChange: (time) {
                  controller.clockInTime = time;
                },
                alignment: Alignment.center,
              ),
              (ctrl.historyModel?.callTime.isNullOrEmpty ?? false)
                  ? FmButton(
                      ontap: () {
                        controller.clockIn(
                          clockInTime: ClockedTimes(
                            callTime:
                                changeToMyTimeFormat(controller.clockInTime),
                          ),
                          date: controller.selectedDate,
                          jobId: jobId,
                        );
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      name: clockIn,
                      type: ButtonType.greenCircular,
                    ).paddingOnly(
                      left: screenWPadding32.sw(),
                      right: screenWPadding32.sw(),
                      bottom: 24.sh(),
                      top: 24.sh(),
                    )
                  : (ctrl.historyModel?.firstMealStart.isNullOrEmpty ?? false)
                      ? _lunchStartWrapButtons(context)
                      : (ctrl.historyModel?.firstMealEnd.isNullOrEmpty ?? false)
                          ? _lunchEndWrapButtons(context)
                          : (ctrl.historyModel?.secondMealStart.isNullOrEmpty ??
                                  false)
                              ? _secondMealStartWrapButtons(context)
                              : (ctrl.historyModel?.secondMealEnd
                                          .isNullOrEmpty ??
                                      false)
                                  ? _secondMealEndWrapButtons(context)
                                  : _wrapWrapButtons(context),
            ],
          );
        },
      ),
    );
  }

  Widget _wrapWrapButtons(BuildContext context) {
    return Column(
      children: [
        FmButton(
          ontap: () {
            controller.clockIn(
              clockInTime: ClockedTimes(
                wrap: changeToMyTimeFormat(controller.clockInTime),
              ),
              date: controller.selectedDate,
              jobId: jobId,
            );
            Navigator.of(context, rootNavigator: true).pop();
          },
          name: wrap,
          type: ButtonType.red,
        ).paddingOnly(
            left: screenWPadding32.sw(),
            right: screenWPadding32.sw(),
            bottom: 24.sh(),
            top: screenHPadding16.sh())
      ],
    );
  }

  Widget _secondMealStartWrapButtons(BuildContext context) {
    return Column(
      children: [
        FmButton(
          ontap: () {
            if (controller.isSecondMealStartValidate(
              changeToMyTimeFormat(controller.clockInTime),
              context,
            )) {
              controller.clockIn(
                clockInTime: ClockedTimes(
                  secondMealStart: changeToMyTimeFormat(controller.clockInTime),
                ),
                date: controller.selectedDate,
                jobId: jobId,
              );
            }
            Navigator.of(context, rootNavigator: true).pop();
          },
          name: secondMealStart,
          type: ButtonType.yellow,
        ).paddingOnly(
          left: screenWPadding32.sw(),
          right: screenWPadding32.sw(),
          top: 24.sh(),
        ),
        FmButton(
          ontap: () {
            controller.clockIn(
              clockInTime: ClockedTimes(
                wrap: changeToMyTimeFormat(controller.clockInTime),
              ),
              date: controller.selectedDate,
              jobId: jobId,
            );
            Navigator.of(context, rootNavigator: true).pop();
          },
          name: wrap,
          type: ButtonType.red,
        ).paddingOnly(
            left: screenWPadding32.sw(),
            right: screenWPadding32.sw(),
            bottom: 24.sh(),
            top: screenHPadding16.sh())
      ],
    );
  }

  Widget _secondMealEndWrapButtons(BuildContext context) {
    return Column(
      children: [
        FmButton(
          ontap: () {
            if (controller.isSecondMealEndValidate(
              changeToMyTimeFormat(controller.clockInTime),
              context,
            )) {
              controller.clockIn(
                clockInTime: ClockedTimes(
                  secondMealEnd: changeToMyTimeFormat(controller.clockInTime),
                ),
                date: controller.selectedDate,
                jobId: jobId,
              );
            }
            Navigator.of(context, rootNavigator: true).pop();
          },
          name: secondMealEnd,
          type: ButtonType.yellow,
        ).paddingOnly(
          left: screenWPadding32.sw(),
          right: screenWPadding32.sw(),
          top: 24.sh(),
        ),
        FmButton(
          ontap: () {
            controller.clockIn(
              clockInTime: ClockedTimes(
                wrap: changeToMyTimeFormat(controller.clockInTime),
              ),
              date: controller.selectedDate,
              jobId: jobId,
            );
            Navigator.of(context, rootNavigator: true).pop();
          },
          name: wrap,
          type: ButtonType.red,
        ).paddingOnly(
            left: screenWPadding32.sw(),
            right: screenWPadding32.sw(),
            bottom: 24.sh(),
            top: screenHPadding16.sh())
      ],
    );
  }

  Widget _lunchStartWrapButtons(BuildContext context) {
    return Column(
      children: [
        FmButton(
          ontap: () {
            if (controller.isLunchStartValidate(
                changeToMyTimeFormat(controller.clockInTime), context)) {
              controller.clockIn(
                clockInTime: ClockedTimes(
                  firstMealStart: changeToMyTimeFormat(controller.clockInTime),
                ),
                date: controller.selectedDate,
                jobId: jobId,
              );
            }
            Navigator.of(context, rootNavigator: true).pop();
          },
          name: lunchStart,
          type: ButtonType.yellow,
        ).paddingOnly(
          left: screenWPadding32.sw(),
          right: screenWPadding32.sw(),
          top: 24.sh(),
        ),
        FmButton(
          ontap: () {
            controller.clockIn(
              clockInTime: ClockedTimes(
                wrap: changeToMyTimeFormat(controller.clockInTime),
              ),
              date: controller.selectedDate,
              jobId: jobId,
            );
            Navigator.of(context, rootNavigator: true).pop();
          },
          name: wrap,
          type: ButtonType.red,
        ).paddingOnly(
            left: screenWPadding32.sw(),
            right: screenWPadding32.sw(),
            bottom: 24.sh(),
            top: screenHPadding16.sh())
      ],
    );
  }

  Widget _lunchEndWrapButtons(BuildContext context) {
    return Column(
      children: [
        FmButton(
          ontap: () {
            if (controller.isLunchEndValidate(
              changeToMyTimeFormat(controller.clockInTime),
              context,
            )) {
              controller.clockIn(
                clockInTime: ClockedTimes(
                  firstMealEnd: changeToMyTimeFormat(controller.clockInTime),
                ),
                date: controller.selectedDate,
                jobId: jobId,
              );
            }
            Navigator.of(context, rootNavigator: true).pop();
          },
          name: lunchEnd,
          type: ButtonType.yellow,
        ).paddingOnly(
          left: screenWPadding32.sw(),
          right: screenWPadding32.sw(),
          top: 24.sh(),
        ),
        FmButton(
          ontap: () {
            controller.clockIn(
              clockInTime: ClockedTimes(
                wrap: changeToMyTimeFormat(controller.clockInTime),
              ),
              date: controller.selectedDate,
              jobId: jobId,
            );
            Navigator.of(context, rootNavigator: true).pop();
          },
          name: wrap,
          type: ButtonType.red,
        ).paddingOnly(
            left: screenWPadding32.sw(),
            right: screenWPadding32.sw(),
            bottom: 24.sh(),
            top: screenHPadding16.sh())
      ],
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

  Widget _timeAddressCard(String date) {
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
          )
              .paddingOnly(
            left: screenHPadding16.sw(),
            top: screenHPadding16.sw(),
            bottom: screenHPadding16.sw(),
          )
              .onTap(() {
            controller.changeDateToLeft(date);
          }),
          Expanded(
            child: Column(
              children: [
                changeToTimeCardDateFormat(date)
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
          )
              .paddingOnly(
            right: screenHPadding16.sw(),
            top: screenHPadding16.sw(),
            bottom: screenHPadding16.sw(),
          )
              .onTap(() {
            controller.changeDateToRight(date);
          })
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
          removeZeroFromAhed(data.time).text(fontSize: 16),
        ],
      ).paddingOnly(
        top: screenHPadding16.sh(),
        left: screenWPadding16.sw(),
        right: screenWPadding16.sw(),
      ),
    );
  }

  String changeToMyTimeFormat(DateTime clockInTime) {
    if (clockInTime.hour == 12) {
      return "12:${clockInTime.minute.toString().length == 1 ? "0${clockInTime.minute}" : clockInTime.minute} AM";
    }

    if (clockInTime.hour == 0) {
      return "12:${clockInTime.minute.toString().length == 1 ? "0${clockInTime.minute}" : clockInTime.minute} PM";
    }
    String formattedDate = DateFormat('hh:mm aa').format(clockInTime);
    return formattedDate;
  }

  String changeToTimeCardDateFormat(String date) {
    DateTime tempDate = DateFormat("yyyy-MM-dd").parse(date);
    return DateFormat('EEEE, MMMM d, yyyy').format(tempDate);
  }
}
