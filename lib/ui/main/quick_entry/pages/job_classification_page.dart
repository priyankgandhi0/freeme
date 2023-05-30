import 'package:flutter/material.dart';

import '../../../../globle.dart';
import '../quick_entry_controller.dart';

class JobClassificationPage extends StatelessWidget {
  JobClassificationPage({Key? key}) : super(key: key);

  final controller = Get.put(QuickEntryController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            "Job Classification"
                .text(
                  fontSize: 18,weight: FontWeight.w500
                )
                .paddingOnly(
                  left: screenWPadding16.sw(),
                ),
          ],
        ),
        _department(),
        _position(),
        _backNextButton()
      ],
    );
  }

  Widget _backNextButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FmButton(
          ontap: () {
            controller.pageController.jumpToPage(2);
          },
          width: 120,
          name: back,
        ),
        FmButton(
          ontap: () {
            controller.pageController.jumpToPage(4);
          },
          width: 120,
          name: next,
        )
      ],
    ).paddingOnly(
      top: screenHPadding16.sw(),
      bottom: screenHPadding16.sw(),
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
    );
  }

  Widget _position() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        position.text(fontSize: 16, fontColor: redColor),
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              "1st Assistant Camera".text(
                fontSize: 16,
                fontColor: greyTextColor,
              ),
              FmImage.assetImage(
                path: Assets.iconsDownIcon,
                height: 15.sh(),
                width: 15.sw(),
              )
            ],
          ).paddingOnly(
            top: 13.sh(),
            bottom: 13.sh(),
            left: screenWPadding16.sw(),
            right: screenWPadding16.sw(),
          ),
        ).paddingOnly(
          top: screenHPadding8.sh(),
        )
      ],
    ).paddingOnly(
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
      top: screenHPadding16.sw(),
    );
  }

  Widget _department() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        department.text(fontSize: 16, fontColor: redColor),
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              camera.text(
                fontSize: 16,
                fontColor: greyTextColor,
              ),
              FmImage.assetImage(
                path: Assets.iconsDownIcon,
                height: 15.sh(),
                width: 15.sw(),
              )
            ],
          ).paddingOnly(
            top: 13.sh(),
            bottom: 13.sh(),
            left: screenWPadding16.sw(),
            right: screenWPadding16.sw(),
          ),
        ).paddingOnly(
          top: screenHPadding8.sh(),
        )
      ],
    ).paddingOnly(
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
      top: screenHPadding16.sw(),
    );
  }
}
