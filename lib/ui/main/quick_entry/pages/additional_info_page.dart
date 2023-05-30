import 'package:flutter/material.dart';
import 'package:freeme/globle.dart';

import '../quick_entry_controller.dart';

class AdditionalInfoPage extends StatelessWidget {
  AdditionalInfoPage({Key? key}) : super(key: key);

  final controller = Get.find<QuickEntryController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            additionalInfo.text(weight: FontWeight.w500, fontSize: 18)
          ],
        ).paddingOnly(
          left: screenWPadding16.sw(),
        ),
        _type(),
        _unionOrNonUnion(),
        Row(
          children: [
            network.text(
              weight: FontWeight.w500,
              fontSize: 18,
            ),
          ],
        ).paddingOnly(left: screenWPadding16.sw(), top: 24.sh()),
        _recommendedBy(),
        _hiredBy(),
        _backNextButton(),
      ],
    );
  }

  Widget _unionOrNonUnion() {
    return Column(
      children: [
        Row(
          children: [
            "Union or Non-Union?".text(
              fontSize: 16,
              weight: FontWeight.w400,
            ),
          ],
        ).paddingOnly(
          left: screenWPadding16.sw(),
        ),
        Row(
          children: [
            Expanded(
              child: _radioButton(
                isSelected: true,
                label: "Not Sure",
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: _radioButton(
                label: "Non Union",
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: _radioButton(
                label: "Union",
              ),
            ),
          ],
        ).paddingOnly(
          left: screenWPadding16.sw(),
          right: screenWPadding16.sw(),
          top: screenHPadding8.sh(),
        )
      ],
    ).paddingOnly(top: 16);
  }

  Widget _radioButton({
    bool isSelected = false,
    String? label,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Row(
        children: [
          isSelected
              ? FmImage.assetImage(
                  path: Assets.iconsSelectedRadio,
                  height: 15.sh(),
                  width: 15.sw(),
                ).paddingOnly(left: 6)
              : FmImage.assetImage(
                  path: Assets.iconsUnselectedRadio,
                  height: 15.sh(),
                  width: 15.sw(),
                ).paddingOnly(left: 6),
          label
              .text(
                fontSize: 16,
              )
              .paddingOnly(left: 6)
        ],
      ).paddingOnly(top: 13, bottom: 13),
    );
  }

  Widget _backNextButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FmButton(
          ontap: () {
            controller.pageController.jumpToPage(3);
          },
          width: 120,
          name: back,
        ),
        FmButton(
          ontap: () {
            controller.pageController.jumpToPage(5);
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

  Widget _hiredBy() {
    return Column(
      children: [
        FmTextField(
          hint: "Erica Chan",
          header: hiredBy,
          inputType: TextInputType.text,
          radius: 10,
        )
      ],
    ).paddingOnly(
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
    );
  }

  Widget _recommendedBy() {
    return Column(
      children: [
        FmTextField(
          hint: "Erica Chan",
          header: recommendedBy,
          inputType: TextInputType.text,
          radius: 10,
        )
      ],
    ).paddingOnly(
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
      top: screenHPadding8.sh(),
    );
  }

  Widget _type() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        type.text(
          fontSize: 16,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              "Commercial".text(
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
