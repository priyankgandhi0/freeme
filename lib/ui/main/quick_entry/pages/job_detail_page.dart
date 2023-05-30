import 'package:flutter/material.dart';
import 'package:freeme/globle.dart';

import '../../../../constant/app_string.dart';
import '../../../widgets/fm_textfield.dart';
import '../quick_entry_controller.dart';

class JobDetailPage extends StatelessWidget {
  JobDetailPage({Key? key}) : super(key: key);

  final controller = Get.find<QuickEntryController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              "Job Details".text(
                fontSize: 18,
                weight: FontWeight.w500,
              ),
            ],
          ).paddingOnly(
            left: screenWPadding16.sw(),
          ),
          FmTextField(
            hint: commercialWithJoey,
            header: descriptionStar,
            inputType: TextInputType.emailAddress,
            headerColor: redColor,
            radius: 10,
          ).paddingOnly(
            left: screenHPadding16.sw(),
            right: screenHPadding16.sw(),
          ),
          FmTextField(
            hint: cardBrandJob,
            header: productionTitle,
            inputType: TextInputType.emailAddress,
            radius: 10,
          ).paddingOnly(
            left: screenHPadding16.sw(),
            right: screenHPadding16.sw(),
          ),
          FmTextField(
            hint: "Jane Smith",
            header: producer,
            inputType: TextInputType.emailAddress,
            radius: 10,
          ).paddingOnly(
            left: screenHPadding16.sw(),
            right: screenHPadding16.sw(),
          ),
          FmTextField(
            hint: companyLLc,
            header: productionCompany,
            inputType: TextInputType.emailAddress,
            radius: 10,
          ).paddingOnly(
            left: screenHPadding16.sw(),
            right: screenHPadding16.sw(),
          ),
          Row(
            children: [
              "Company Address"
                  .text(
                    fontSize: 16,
                  )
                  .paddingOnly(
                    left: screenWPadding16.sw(),
                    top: screenHPadding16.sh(),
                    bottom: screenHPadding8.sw(),
                  ),
            ],
          ),
          _expandableDetailItem(),
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
            controller.pageController.jumpToPage(0);
          },
          width: 120,
          name: back,
        ),
        FmButton(
          ontap: () {
            controller.pageController.jumpToPage(2);
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

  Widget _expandableDetailItem() {
    return GetBuilder<QuickEntryController>(
      id: "CompanyAdddressExpanded",
      builder: (ctrl) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTileTheme(
            dense: true,
            child: ExpansionTile(
              title: SizedBox(
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        companyAddressStar.text(
                            fontSize: 16,
                            fontColor:
                                ctrl.isExpanded ? Colors.black : greyTextColor)
                      ],
                    )
                  ],
                ),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ctrl.isExpanded
                      ? FmImage.assetImage(
                          path: Assets.iconsDownIcon,
                          height: 20.sh(),
                          width: 15.sw(),
                        )
                      : FmImage.assetImage(
                          path: Assets.iconsForwardIcon,
                          height: 15.sh(),
                          width: 8.sw(),
                        )
                ],
              ),
              onExpansionChanged: (value) {
                ctrl.onExpansionChange(value);
              },
              children: [
                Container(
                  width: Get.width,
                  height: 1,
                  color: Colors.black,
                ),
                expandedChildItem(
                  label: addressLineOne,
                  hint: "1234 Street Dr.",
                ),
                expandedChildItem(
                  label: addressLineTwo,
                  hint: "Apt 111",
                ),
                expandedChildItem(
                  label: city,
                  hint: "Los Angeles",
                ),
                expandedChildItem(
                  label: state,
                  hint: "CA",
                ),
                expandedChildItem(
                  label: zip,
                  hint: "91506",
                ),
                expandedChildItem(
                  label: country,
                  hint: "United States",
                  showBorder: false,
                ),
              ],
            ),
          ),
        ).paddingOnly(left: 16, right: 16);
      },
    );
  }

  Widget expandedChildItem({
    String? label,
    String? hint,
    bool showBorder = true,
  }) {
    return _detailItem(
      label ?? "",
      hint: hint,
      showBorder: showBorder,
    );
  }

  Widget _detailItem(String lable,
      {bool showBorder = true,
      String? hint,
      double? leftPadding,
      double? rightPadding}) {
    return Container(
      decoration: BoxDecoration(
        border: showBorder
            ? const Border(
                bottom: BorderSide(
                  color: borderGreyColor,
                  width: 1,
                ),
              )
            : null,
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                lable
                    .text(
                      fontColor: Colors.black,
                      fontSize: 16,
                    )
                    .paddingOnly(left: 20.sw())
              ],
            ),
          ),
          Expanded(
            child: FmEmptyTextField(
              hintText: hint,
            ),
          )
        ],
      ).paddingOnly(
        top: screenHPadding16.sh(),
        bottom: 16.sh(),
        left: leftPadding ?? 0,
        right: rightPadding ?? 0,
      ),
    );
  }
}
