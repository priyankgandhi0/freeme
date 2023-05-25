import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freeme/ui/widgets/flutter_time_picker_spinner.dart';
import 'package:freeme/utils/extension.dart';
import 'package:get/get.dart';

import '../../../../../constant/app_string.dart';
import '../../../../../constant/space_constant.dart';
import '../../../../../generated/assets.dart';
import '../../../../../theme/app_colors.dart';
import '../../../../../utils/route_manager.dart';
import '../../../../widgets/fm_button.dart';
import '../../../../widgets/fm_dialog.dart';
import '../../../../widgets/fm_image.dart';

class TimeCardTabScreen extends StatelessWidget {
  const TimeCardTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _timeAddressCard(),
          dataTableCard(),
          _duplicateTimeButton().paddingOnly(bottom: 124.sh()),
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
                  .onClick(
                    () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                  )
                  .paddingOnly(
                    top: 20.sh(),
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
          /*FmButton(
            ontap: () {},
            name: clockIn,
            type: ButtonType.greenCircular,
          ).paddingOnly(
            left: screenWPadding32.sw(),
            right: screenWPadding32.sw(),
            bottom: 24.sh(),
            top: 24.sh(),
          ),*/

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

  Widget _duplicateTimeButton() {
    return FmButton(
      ontap: () {
        //Get.toNamed(Routes.workHistory);
      },
      name: duplicateTimes,
      type: ButtonType.fullGreen,
    ).paddingOnly(
      top: screenHPadding16.sh(),
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
      ),
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
    ).paddingOnly(
      left: screenHPadding16.sw(),
      right: screenHPadding16.sw(),
      top: screenHPadding16.sh(),
    );
  }
}
