import 'package:flutter/material.dart';
import 'package:freeme/ui/main/time_card_edit/timecard__history_edit_controller.dart';
import '../../../../../globle.dart';
import '../../widgets/fm_appbar.dart';

class TimeCardEditHistoryScreen extends StatelessWidget {
  TimeCardEditHistoryScreen({Key? key}) : super(key: key);

  final controller = Get.put(TimeCardEditController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: backGroundWhiteColor,
        body: Column(
          children: [
            fMAppBar2(
                title: "Commercial with Adam",
                description: "Week Ending 7/23/2022",
                context: context,
                onBackClick: () {
                  FocusScope.of(context).unfocus();
                  Navigator.of(context).pop();
                }),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _dateCard(),
                    _dayTypeField(),
                    _addressLocationOne(),
                    _addressLocationTwo(),
                    _clockedTimes(),
                    _bottomButtons()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }

  Widget _bottomButtons() {
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
            ontap: () {},
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

  Widget _clockedTimes() {
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
              _clockTimeItem(
                "Call Time:",
                "8:00 AM",
              ),
              _clockTimeItem(
                "1st Meal Start:",
                "2:00 PM",
              ),
              _clockTimeItem(
                "1st Meal End:",
                "2:45 PM",
              ),
              _clockTimeItem(
                "2nd Meal Start:",
                "4:00 PM",
              ),
              _clockTimeItem(
                "2nd Meal End:",
                "4:45 PM",
              ),
              _clockTimeItem(
                "Wrap:",
                "--:-- AM/PM",
                showBottomLine: false,
              ),
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

  Widget _addressLocationTwo() {
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
              _addressItem(addressLineOne),
              _addressItem(addressLineTwo),
              _addressItem(city),
              Row(
                children: [
                  Expanded(
                    child: _addressItem(
                      state,
                      showRightBorder: true,
                    ),
                  ),
                  Expanded(
                    child: _addressItem(
                      zip,
                      inputType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _addressItem(
                      country,
                      showBottomBorder: false,
                    ),
                  ),
                  FmImage.assetImage(
                    path: Assets.iconsForwardIcon,
                    height: 15,
                    width: 15,
                  ).paddingOnly(
                    right: screenWPadding16.sw(),
                  )
                ],
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

  Widget _addressLocationOne() {
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
              _addressItem(addressLineOne),
              _addressItem(addressLineTwo),
              _addressItem(city),
              Row(
                children: [
                  Expanded(
                    child: _addressItem(state, showRightBorder: true),
                  ),
                  Expanded(
                    child: _addressItem(
                      zip,
                      inputType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _addressItem(
                      country,
                      showBottomBorder: false,
                    ),
                  ),
                  FmImage.assetImage(
                    path: Assets.iconsForwardIcon,
                    height: 15,
                    width: 15,
                  ).paddingOnly(
                    right: screenWPadding16.sw(),
                  )
                ],
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
      TextInputType? inputType}) {
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
      ).paddingOnly(
        left: screenWPadding16.sw(),
        top: screenHPadding16.sh(),
        bottom: screenHPadding16.sh(),
      ),
    );
  }

  Widget _dayTypeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Day Type".text(
          fontSize: 18,
          weight: FontWeight.w500,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              "Shoot Day".text(
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
        ).paddingOnly(top: screenHPadding8.sh())
      ],
    ).paddingOnly(
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
      top: 24.sh(),
    );
  }

  Widget _dateCard() {
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
      child: "Thursday, July 21, 2022"
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
}
