import 'package:flutter/material.dart';
import 'package:freeme/globle.dart';
import 'package:freeme/utils/extension.dart';

import '../../../widgets/dropdown.dart';
import '../quick_entry_controller.dart';

class PaymentDetailPage extends StatelessWidget {
  PaymentDetailPage({Key? key}) : super(key: key);

  final controller = Get.find<QuickEntryController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<QuickEntryController>(
        builder: (ctrl) {
          return Column(
            children: [
              Row(
                children: [
                  "Payment Details"
                      .text(
                        fontSize: 18,
                        weight: FontWeight.w500,
                      )
                      .paddingOnly(
                        left: screenWPadding16.sw(),
                      ),
                ],
              ),
              _rateAndOther(ctrl, context),
              _guaranteedHours(context, ctrl),
              _w2Or1099(),
              _paidBy(ctrl, context),
              _terms(ctrl, context),
              _backNextButton()
            ],
          );
        },
      ),
    );
  }

  Widget _backNextButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FmButton(
          ontap: () {
            controller.pageController.jumpToPage(1);
          },
          width: 120,
          name: back,
        ),
        FmButton(
          ontap: () {
            controller.moveToFourthPage();
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

  Widget _terms(QuickEntryController ctrl, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        terms.text(
          fontSize: 16,
        ),
        fmDropDown(
          child: termsDropDownItem(ctrl.selectedTerm.text ?? ""),
          onDropDownTap: (item) {
            ctrl.onTermsDropDownTap(item);
          },
          items: ctrl.allTerms,
          context: context,
        ),
      ],
    ).paddingOnly(
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
      top: screenHPadding16.sw(),
    );
  }

  Widget termsDropDownItem(String? selected) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              selected.text(
                fontSize: 16,
                fontColor: Colors.black,
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
          if (controller.selectedTerm.text == "Other") ...[
            Container(
              width: Get.width,
              height: 1,
              color: greyTextColor,
            ),
            FmEmptyTextField(
              hintText: cardBrandJob,
              textInputType: TextInputType.text,
              controller: controller.termsManualController,
            ).paddingOnly(
              top: 13.sh(),
              bottom: 13.sh(),
              left: screenWPadding16.sw(),
              right: screenWPadding16.sw(),
            ),
          ]
        ],
      ),
    ).paddingOnly(
      top: screenHPadding8.sh(),
    );
  }

  Widget _paidBy(QuickEntryController ctrl, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        paidBy.text(
          fontSize: 16,
        ),
        fmDropDown(
            child: _paidByDropDownItem(ctrl.selectedPaidBy.text ?? ""),
            onDropDownTap: (item) {
              ctrl.onPaidByDropDownTap(item);
            },
            items: ctrl.allPaidBy,
            context: context,
            width: 245),
      ],
    ).paddingOnly(
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
      top: screenHPadding16.sw(),
    );
  }

  Widget _paidByDropDownItem(String selected) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              selected.text(
                fontSize: 16,
                fontColor: Colors.black,
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
          if (controller.selectedPaidBy.text == "Other") ...[
            Container(
              width: Get.width,
              color: greyTextColor,
              height: 1,
            ),
            FmEmptyTextField(
              hintText: "PaidBy Note",
              textInputType: TextInputType.text,
              controller: controller.paidByManualController,
            ).paddingOnly(
              top: 13.sh(),
              bottom: 13.sh(),
              left: screenWPadding16.sw(),
              right: screenWPadding16.sw(),
            ),
          ]
        ],
      ),
    ).paddingOnly(
      top: screenHPadding8.sh(),
    );
  }

  Widget _w2Or1099() {
    return Column(
      children: [
        Row(
          children: [
            w2Or1099.text(fontSize: 16, weight: FontWeight.w400),
          ],
        ).paddingOnly(
          left: screenWPadding16.sw(),
        ),
        Row(
          children: [
            Expanded(
              child: _radioButton(
                isSelected: controller.w2or1099Options[0].isSelected,
                label: controller.w2or1099Options[0].text,
              ).onClick(() {
                controller.onW2or1099OptionsClick(0);
              }),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: _radioButton(
                isSelected: controller.w2or1099Options[1].isSelected,
                label: controller.w2or1099Options[1].text,
              ).onClick(() {
                controller.onW2or1099OptionsClick(1);
              }),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: _radioButton(
                isSelected: controller.w2or1099Options[2].isSelected,
                label: controller.w2or1099Options[2].text,
              ).onClick(() {
                controller.onW2or1099OptionsClick(2);
              }),
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

  Widget _guaranteedHours(BuildContext context, QuickEntryController ctrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        guaranteedHours.text(
          fontSize: 16,
        ),
        fmDropDown(
          child: guaranteedHourDropDownItem(
              ctrl.selectedGuaranteedHour.text ?? ""),
          onDropDownTap: (item) {
            controller.guaranteedHourClick(item);
          },
          items: controller.allGuaranteedHour,
          context: context,
        ),
      ],
    ).paddingOnly(
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
      top: screenHPadding16.sw(),
    );
  }

  Widget guaranteedHourDropDownItem(String selected) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          selected.text(
            fontSize: 16,
            fontColor: Colors.black,
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
    );
  }

  Widget _rateAndOther(QuickEntryController ctrl, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FmTextField(
            hint: "\$500",
            header: rateStar,
            inputType: TextInputType.number,
            radius: 10,
            controller: ctrl.rateTextController,
            headerColor: redColor,
            error: controller.rateError,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              perHowManyHours.text(
                fontSize: 16,
                fontColor: redColor,
              ),
              fmDropDown(
                child: perHowManyHour(ctrl.selectedPerHour.text ?? ""),
                onDropDownTap: (item) {
                  controller.onPerHourDropDownTap(item);
                },
                items: controller.allPerHour,
                context: context,
              ),
            ],
          ).paddingOnly(
            left: screenWPadding16.sw(),
          ),
        )
      ],
    ).paddingOnly(left: screenWPadding16.sw(), right: screenWPadding16.sw());
  }

  perHowManyHour(String selected) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          selected.text(
            fontSize: 16,
            fontColor: Colors.black,
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
    );
  }
}
