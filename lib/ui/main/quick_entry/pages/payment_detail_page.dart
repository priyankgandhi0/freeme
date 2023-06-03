import 'package:flutter/material.dart';
import 'package:freeme/globle.dart';
import 'package:freeme/utils/extension.dart';

import '../quick_entry_controller.dart';

class PaymentDetailPage extends StatelessWidget {
    PaymentDetailPage({Key? key}) : super(key: key);

  final controller = Get.find<QuickEntryController>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
          _rateAndOther(),
          _guaranteedHours(),
          _w2Or1099(),
          _paidBy(),
          _terms(),
          _backNextButton()
        ],
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
            controller.pageController.jumpToPage(3);
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

  Widget _terms(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        terms.text(
          fontSize: 16,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              "Net 30".text(
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
  
  
  Widget _paidBy(){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          paidBy.text(
            fontSize: 16,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(10),
                color: Colors.white
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                entertainmentPartners.text(
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
                isSelected: true,
                label: "Not Sure",
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: _radioButton(
                label: "W2",
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: _radioButton(
                label: "1099",
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

  Widget _guaranteedHours() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        perHowManyHours.text(
          fontSize: 16,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(10),
              color: Colors.white
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              "10 hours".text(
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

  Widget _rateAndOther() {
    return Row(
      children: [
        Expanded(
          child: FmTextField(
            hint: "\$500",
            header: rateStar,
            inputType: TextInputType.emailAddress,
            radius: 10,
            headerColor: redColor,
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
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "10 hours".text(
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
          ),
        )
      ],
    ).paddingOnly(left: screenWPadding16.sw(), right: screenWPadding16.sw());
  }
}
