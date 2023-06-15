import 'package:flutter/material.dart';
import 'package:freeme/ui/main/time_card_edit/timecard__history_edit_controller.dart';
import 'package:intl/intl.dart';
import '../../../../../globle.dart';
import '../../../models/edit_timecard_request.dart';
import '../../widgets/dropdown.dart';
import '../../widgets/flutter_time_picker_spinner.dart';
import '../../widgets/fm_appbar.dart';
import '../../widgets/fm_dialog.dart';

class TimeCardEditHistoryScreen extends StatelessWidget {
  TimeCardEditHistoryScreen({
    Key? key,
  }) : super(key: key);

  final controller = Get.put(TimeCardEditController());

  String? title;
  num jobId = -1;
  num? dayId;
  String? date;

  @override
  Widget build(BuildContext context) {
    Map arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    title = arguments["title"] ?? "";
    jobId = arguments["job_id"] ?? -1;
    dayId = arguments["day_id"] ?? -1;
    date = arguments["date"] ?? "";
    controller.selectedDate = date ?? "";

    return WillPopScope(
      child: Scaffold(
        backgroundColor: backGroundWhiteColor,
        body: GetBuilder<TimeCardEditController>(initState: (init) {
          Future.delayed(
            Duration.zero,
            () async {
              await controller.getAllDayTypeList();
              controller.getAllCountryFromRaw(context);
              controller.getWorkHistory(jobId, date ?? "");
            },
          );
        }, builder: (ctrl) {
          return Column(
            children: [
              fMAppBar2(
                title: title,
                description: "Week Ending 7/23/2022",
                context: context,
                onBackClick: () {
                  FocusScope.of(context).unfocus();
                  Navigator.of(context).pop();
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _dateCard(date),
                      _dayTypeField(context, ctrl),
                      _addressLocationOne(context, ctrl),
                      _addressLocationTwo(context, ctrl),
                      _clockedTimes(ctrl, context),
                      _bottomButtons(context)
                    ],
                  ),
                ),
              )
            ],
          );
        }),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }

  Widget _bottomButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FmButton(
            ontap: () {},
            name: delete,
            type: ButtonType.delete,
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: FmButton(
            ontap: () {
              controller.saveEditTimeCard(
                jobId ?? -1,
                date ?? "",
                context,
              );
            },
            name: save,
          ),
        )
      ],
    ).paddingOnly(
        top: screenHPadding32.sh(),
        left: screenWPadding16.sh(),
        right: screenWPadding16.sh(),
        bottom: 24);
  }

  Widget _clockedTimes(TimeCardEditController ctrl, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        clockedTimes.text(
          fontSize: 18,
          weight: FontWeight.w500,
        ),
        ctrl.historyModel != null
            ? Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    _clockTimeItem(
                        "Call Time",
                        ctrl.historyModel!.callTime.isNullOrEmpty
                            ? "--:-- AM/PM"
                            : ctrl.historyModel?.callTime ?? "", onclick: () {
                      showSelectTimeDialog(context, "Call Time");
                    }),
                    _clockTimeItem(
                        "1st Meal Start:",
                        ctrl.historyModel!.firstMealStart.isNullOrEmpty
                            ? "--:-- AM/PM"
                            : ctrl.historyModel?.firstMealStart ?? "",
                        onclick: () {
                      showSelectTimeDialog(context,"1st Meal Start");
                    }),
                    _clockTimeItem(
                        "1st Meal End:",
                        ctrl.historyModel!.firstMealEnd.isNullOrEmpty
                            ? "--:-- AM/PM"
                            : ctrl.historyModel?.firstMealEnd ?? "",
                        onclick: () {
                      showSelectTimeDialog(context,"1st Meal End");
                    }),
                    _clockTimeItem(
                        "2nd Meal Start:",
                        ctrl.historyModel!.secondMealStart.isNullOrEmpty
                            ? "--:-- AM/PM"
                            : ctrl.historyModel?.secondMealStart ?? "",
                        onclick: () {
                      showSelectTimeDialog(context,"2nd Meal Start");
                    }),
                    _clockTimeItem(
                        "2nd Meal End:",
                        ctrl.historyModel!.secondMealEnd.isNullOrEmpty
                            ? "--:-- AM/PM"
                            : ctrl.historyModel?.secondMealEnd ?? "",
                        onclick: () {
                      showSelectTimeDialog(context,"2nd Meal End");
                    }),
                    _clockTimeItem(
                        "Wrap:",
                        ctrl.historyModel!.wrap.isNullOrEmpty
                            ? "--:-- AM/PM"
                            : ctrl.historyModel?.wrap ?? "", onclick: () {
                      showSelectTimeDialog(context,"Wrap");
                    })
                  ],
                ),
              ).paddingOnly(
                top: screenHPadding8.sh(),
              )
            : Container()
      ],
    ).paddingOnly(
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
      top: screenHPadding16.sh(),
    );
  }

  Widget _clockTimeItem(String title, String value,
      {bool showBottomLine = false, GestureTapCallback? onclick}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: showBottomLine ? borderGreyColor : Colors.transparent,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          title.text(fontSize: 16),
          Container(
            decoration: BoxDecoration(
              color: borderGreyColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: value
                .text(
                  fontSize: 16,
                )
                .paddingOnly(
                  left: 8.sw(),
                  right: 8.sw(),
                  top: 5.sh(),
                  bottom: 5.sh(),
                ),
          ).onClick(onclick ?? () {})
        ],
      ).paddingOnly(
        left: screenWPadding16.sw(),
        top: 11.sh(),
        bottom: 11.sh(),
        right: screenWPadding16.sw(),
      ),
    );
  }

  Widget _addressLocationTwo(
    BuildContext context,
    TimeCardEditController ctrl,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        location2.text(fontSize: 18, weight: FontWeight.w500),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              _addressItem(addressLineOne,
                  controller: ctrl.l2addressl1Controller),
              _addressItem(addressLineTwo,
                  controller: ctrl.l2addressl2Controller),
              _addressItem(city, controller: ctrl.l2CityController),
              Row(
                children: [
                  Expanded(
                    child: _addressItem(state,
                        showRightBorder: true,
                        controller: ctrl.l2StateController),
                  ),
                  Expanded(
                    child: _addressItem(zip,
                        inputType: TextInputType.number,
                        controller: ctrl.l2ZipController),
                  ),
                ],
              ),
              fmDropDown(
                child: Row(
                  children: [
                    Expanded(
                      child: (ctrl.locationTwoCountry.text)
                          .text(fontSize: 16)
                          .paddingAll(16),
                    ),
                    FmImage.assetImage(
                      path: Assets.iconsForwardIcon,
                      height: 15,
                      width: 15,
                    ).paddingOnly(
                      right: screenWPadding16.sw(),
                    )
                  ],
                ),
                width: 240,
                onDropDownTap: (item) {
                  controller.onLocationTwoCountrySelect(item);
                },
                items: controller.locationTwoCountryList,
                context: context,
              )
            ],
          ),
        ).paddingOnly(
          top: screenHPadding8.sh(),
        )
      ],
    ).paddingOnly(
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
      top: screenHPadding16.sh(),
    );
  }

  Widget _addressLocationOne(
      BuildContext context, TimeCardEditController ctrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Location 1".text(fontSize: 18, weight: FontWeight.w500),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              _addressItem(
                addressLineOne,
                controller: controller.l1addressl1Controller,
              ),
              _addressItem(
                addressLineTwo,
                controller: controller.l1addressl2Controller,
              ),
              _addressItem(
                city,
                controller: controller.l1CityController,
              ),
              Row(
                children: [
                  Expanded(
                    child: _addressItem(
                      state,
                      showRightBorder: true,
                      controller: controller.l1StateController,
                    ),
                  ),
                  Expanded(
                    child: _addressItem(
                      zip,
                      inputType: TextInputType.number,
                      controller: controller.l1ZipController,
                    ),
                  ),
                ],
              ),
              fmDropDown(
                child: Row(
                  children: [
                    Expanded(
                      child: (ctrl.locationOneCountry.text)
                          .text(fontSize: 16)
                          .paddingAll(16),
                    ),
                    FmImage.assetImage(
                      path: Assets.iconsForwardIcon,
                      height: 15,
                      width: 15,
                    ).paddingOnly(
                      right: screenWPadding16.sw(),
                    )
                  ],
                ),
                width: 240,
                onDropDownTap: (item) {
                  controller.onLocationOneCountrySelect(item);
                },
                items: controller.locationOneCountryList,
                context: context,
              )
            ],
          ),
        ).paddingOnly(
          top: screenHPadding8.sh(),
        )
      ],
    ).paddingOnly(
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
      top: screenHPadding16.sh(),
    );
  }

  Widget _addressItem(String hint,
      {bool showRightBorder = false,
      bool showBottomBorder = true,
      TextInputType? inputType,
      TextEditingController? controller}) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: showBottomBorder ? borderGreyColor : Colors.transparent,
          ),
          right: BorderSide(
            color: showRightBorder ? borderGreyColor : Colors.transparent,
          ),
        ),
      ),
      child: FmEmptyTextField(
        hintText: hint,
        textInputType: inputType,
        controller: controller,
      ).paddingOnly(
        left: screenWPadding16.sw(),
        top: screenHPadding16.sh(),
        bottom: screenHPadding16.sh(),
      ),
    );
  }

  Widget _dayTypeField(BuildContext context, TimeCardEditController ctrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Day Type".text(
          fontSize: 18,
          weight: FontWeight.w500,
        ),
        fmDropDown(
          child: _dayTimeDropDownItem(ctrl.selectedDayType),
          onDropDownTap: (item) {
            controller.onDayTypeSelect(item);
          },
          items: controller.dayTypeList,
          context: context,
        ).paddingOnly(top: screenHPadding8.sh())
      ],
    ).paddingOnly(
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
      top: 24.sh(),
    );
  }

  Widget _dayTimeDropDownItem(MenuItem item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          item.text.text(
            fontSize: 16,
          ),
          FmImage.assetImage(
            path: Assets.iconsDownIcon,
            fit: BoxFit.fill,
            size: 15,
          )
        ],
      ).paddingOnly(
        left: screenWPadding16.sw(),
        right: screenWPadding16.sw(),
        top: screenHPadding16.sw(),
        bottom: screenHPadding16.sw(),
      ),
    );
  }

  Widget _dateCard(String? date) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: changeToTextDateFormat(date)
          .text(
            weight: FontWeight.w500,
            fontSize: 16,
          )
          .paddingOnly(
            top: screenHPadding16.sh(),
            bottom: screenHPadding16.sh(),
          )
          .center,
    ).paddingOnly(
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
      top: 24.sh(),
    );
  }

  /*String changeFormat(String? date) {
    if (date != null) {
      DateTime tempDate = DateFormat("yyyy-MM-dd hh:mm:ss").parse(date);
      String formattedDate = DateFormat('yyyy-MM-dd').format(tempDate);
      return formattedDate;
    } else {
      return "";
    }
  }*/

  String changeToTextDateFormat(String? date) {
    if (date != null) {
      DateTime tempDate = DateFormat("yyyy-MM-dd").parse(date);
      return DateFormat('EEEE, MMM dd,yyyy').format(tempDate);
    } else {
      return "";
    }
  }

  ///dialog
  ///
  ///

  showSelectTimeDialog(
    BuildContext context,
    String time,
  ) {
    fMDialog(
      context: context,
      horizontalPadding: screenWPadding64.sw(),
      child: GetBuilder<TimeCardEditController>(
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
                onTimeChange: (time) {
                  controller.clockInTime = time;
                },
              ),
              time == "Call Time"
                  ? _callTimeButton(context)
                  : time == "1st Meal Start"
                      ? _lunchStartWrapButtons(context)
                      : time == "1st Meal End"
                          ? _lunchEndWrapButtons(context)
                          : time == "2nd Meal Start"
                              ? _secondMealStartWrapButtons(context)
                              : time == "2nd Meal End"
                                  ? _secondMealEndWrapButtons(context)
                                  : time == "Wrap"
                                      ? _wrapWrapButtons(context)
                                      : Container(),
            ],
          );
        },
      ),
    );
  }

  Widget _callTimeButton(BuildContext context) {
    return FmButton(
      ontap: () {
        controller.clockIn(
          clockInTime: ClockedTimes(
            callTime: changeToMyTimeFormat(controller.clockInTime),
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
}
