import 'package:flutter/material.dart';
import 'package:freeme/ui/main/time_card_edit/timecard__history_edit_controller.dart';
import 'package:intl/intl.dart';
import '../../../../../globle.dart';
import '../../widgets/dropdown.dart';
import '../../widgets/fm_appbar.dart';

class TimeCardEditHistoryScreen extends StatelessWidget {
  TimeCardEditHistoryScreen({
    Key? key,
  }) : super(key: key);

  final controller = Get.put(TimeCardEditController());

  String? title;
  num? jobId;
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
                      _clockedTimes(ctrl),
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

  Widget _clockedTimes(TimeCardEditController ctrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        clockedTimes.text(
          fontSize: 18,
          weight: FontWeight.w500,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              ...ctrl.clockTimeList
                  .map((e) => _clockTimeItem(
                        e.title.toString(),
                        e.time.toString(),
                      ))
                  .toList()

              /*_clockTimeItem(
                "Wrap:",
                "--:-- AM/PM",
                showBottomLine: false,
              ),*/
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

  Widget _clockTimeItem(String title, String value,
      {bool showBottomLine = false}) {
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
          )
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
}
