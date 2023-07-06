import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:freeme/globle.dart';
import 'package:freeme/ui/main/demo/demo_controller.dart';
import 'package:freeme/utils/extension.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../utils/calender_utils.dart';

class DemoScreen extends StatelessWidget {
  DemoScreen({Key? key}) : super(key: key);

  var controller = Get.put(DemoController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: GetBuilder<DemoController>(
        builder: (ctrl) {
          return Scaffold(
            backgroundColor: backGroundWhiteColor,
            bottomNavigationBar: bottomNavigationBar(),
            body: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),

                ///calender
                /*AppCalender(
                  currentDay: controller.currentDay,
                  focusDay: controller.focusedDay,
                  onDaySelected: (selectedDay, focusDay) {
                    controller.onDaySelect(selectedDay, focusDay);
                  },
                  onMonthChange: (date) {
                    // controller.onMonthChange(date);
                  },
                  selectedDays: ctrl.selectedDays,
                ),*/

                ///expandable
                /*Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(5)),
                  child: ExpansionTile(
                    title: "Sample".text(),
                    children: [
                      "Sample".text(),
                      "Sample".text(),
                      "Sample".text(),
                    ],
                  ),
                ).paddingOnly(
                    left: screenHPadding16.sw(),
                    right: screenHPadding16.sw(),
                    top: 20,
                    bottom: 20),*/

                ///buttons all
                /*FmButton(
                  ontap: () {
                    Get.toNamed(Routes.demoScreen);
                  },
                  name: logIn,
                  type: ButtonType.red,
                ).paddingOnly(
                  top: 48.sh(),
                  left: screenHPadding16.sw(),
                  right: screenHPadding16.sw(),
                ),*/

                ///data card
                //dataTableCard(),

                ///profile photo widget
                /*profileImage(150, 150,onCameraClick: (){
                  "camera clicked".debugPrint;
                }),*/

                ///circular button used in share profile in profile section
                /*FmButton(
                  ontap: () {
                    Get.toNamed(Routes.demoScreen);
                  },
                  name: logIn,
                  type: ButtonType.rounded,
                  assetPath: Assets.iconsLink,
                ).paddingOnly(
                  top: 48.sh(),
                  left: screenHPadding16.sw(),
                  right: screenHPadding16.sw(),
                ),*/


              ],
            ),
          );
        },
      ),
      onWillPop: () async {

        return false;
      },
    );
  }

  dataTableCard() {
    return Container(
      decoration: BoxDecoration(
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
            itemCount: 5,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "Call Time:".text(fontSize: 16),
                    "--:-- AM/PM".text(fontSize: 16),
                  ],
                ).paddingOnly(
                  top: screenHPadding16.sh(),
                  left: screenWPadding16.sw(),
                  right: screenWPadding16.sw(),
                ),
              );
            },
          ),
          SizedBox(
            height: screenHPadding16.sh(),
          )
        ],
      ),
    ).paddingOnly(left: 16.sw(), right: 16.sw());
  }

  profileImage(
    int height,
    int width, {
    GestureTapCallback? onCameraClick,
  }) {
    return Stack(
      children: [
        Container(
          height: height.sh(),
          width: width.sw(),
          decoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
        ),
        onCameraClick != null
            ? Container(
                height: 44,
                width: 44,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Container(
                  height: 38,
                  width: 38,
                  decoration: const BoxDecoration(
                    color: backGroundGreenColor,
                    shape: BoxShape.circle,
                  ),
                  child: FmImage.assetImage(
                    path: Assets.iconsCamera,
                    fit: BoxFit.fitWidth,
                  ).paddingOnly(
                    left: 11.sw(),
                    right: 11.sw(),
                    top: 12.sh(),
                    bottom: 12.sh(),
                  ),
                ).center,
              ).onTap(onCameraClick).positioned(
                  right: 0,
                  bottom: 0,
                )
            : Container()
      ],
    );
  }

  Widget bottomNavigationBar() {
    return Container(
      height: 98,
      width: Get.width,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
           bottomItem('Work History', Assets.iconsHistory),
          bottomItem('FreeMe Beta', Assets.iconsBeta),
          bottomItem('Account', Assets.iconsSetting),
        ],
      ),
    );
  }

  Widget bottomItem(String title, String asset) {
     return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FmImage.assetImage(
          path: asset,
          height: 26,
          width: 26,
        ),
        title
            .text(
              fontSize: 12,
            )
            .paddingOnly(
              top: 6.sh(),
            )
      ],
    );
  }
}


