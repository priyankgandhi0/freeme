import 'package:flutter/material.dart';
import 'package:freeme/globle.dart';

import '../../../../constant/app_string.dart';
import '../../../widgets/dropdown.dart';
import '../../../widgets/fm_textfield.dart';
import '../quick_entry_controller.dart';

class JobDetailPage extends StatelessWidget {
  JobDetailPage({Key? key}) : super(key: key);

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
                inputType: TextInputType.text,
                headerColor: redColor,
                radius: 10,
                error: ctrl.descriptionError,
                controller: ctrl.descriptionController,
              ).paddingOnly(
                left: screenHPadding16.sw(),
                right: screenHPadding16.sw(),
              ),
              FmTextField(
                hint: cardBrandJob,
                header: productionTitle,
                inputType: TextInputType.text,
                radius: 10,
                error: ctrl.productionTitleError,
                controller: ctrl.productionTitleController,
              ).paddingOnly(
                left: screenHPadding16.sw(),
                right: screenHPadding16.sw(),
              ),
              FmTextField(
                hint: "Jane Smith",
                header: producer,
                inputType: TextInputType.text,
                controller: ctrl.producerController,
                radius: 10,
                error: ctrl.producerError,
              ).paddingOnly(
                left: screenHPadding16.sw(),
                right: screenHPadding16.sw(),
              ),
              FmTextField(
                hint: companyLLc,
                header: productionCompany,
                inputType: TextInputType.text,
                radius: 10,
                error: ctrl.productionCompanyError,
                controller: ctrl.productionCompanyController,
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
              _expandableDetailItem(context),
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
            controller.pageController.jumpToPage(0);
          },
          width: 120,
          name: back,
        ),
        FmButton(
          ontap: () {
            controller.moveToThirdPage();
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

  Widget _expandableDetailItem(BuildContext context) {
    return GetBuilder<QuickEntryController>(
      id: "CompanyAdddressExpanded",
      initState: (init) {
        controller.getAllCountryFromRaw(context);
      },
      builder: (ctrl) {
        return Column(
          children: [
            Container(
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
                                fontColor: ctrl.isExpanded
                                    ? Colors.black
                                    : greyTextColor)
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
                      controller: ctrl.addressLIne1Controller,
                    ),
                    expandedChildItem(
                      label: addressLineTwo,
                      hint: "Apt 111",
                      controller: ctrl.addressLIne2Controller,
                    ),
                    expandedChildItem(
                      label: city,
                      hint: "Los Angeles",
                      controller: ctrl.cityController,
                    ),
                    expandedChildItem(
                      label: state,
                      hint: "CA",
                      controller: ctrl.stateController,
                    ),
                    expandedChildItem(
                      label: zip,
                      hint: "91506",
                      inputType: TextInputType.number,
                      controller: ctrl.zipController,
                    ),
                    fmDropDown(
                      child:
                          countryItemWithDropDown(ctrl.selectedCountry?.text ?? ""),
                      width: 240,
                      onDropDownTap: (item) {
                        controller.onCountryDropDownTap(item);
                      },
                      items: controller.countryList,
                      context: context,
                    )
                  ],
                ),
              ),
            ).paddingOnly(left: 16, right: 16),
            ctrl.addressError != null
                ? Row(
                    children: [
                      ctrl.addressError.text(fontColor: redColor),
                    ],
                  ).paddingOnly(
                    left: screenWPadding16.sw(),
                    top: screenHPadding8.sw(),
                  )
                : Container()
          ],
        );
      },
    );
  }

  Widget countryItemWithDropDown(String selectedCountry) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              "Country".text(fontSize: 16).paddingOnly(
                    left: screenWPadding16.sw(),
                    top: screenHPadding16.sh(),
                    bottom: screenHPadding16.sh(),
                  ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (selectedCountry).text(fontSize: 16),
              FmImage.assetImage(
                path: Assets.iconsDownIcon,
                height: 15.sh(),
                width: 15.sw(),
              ).paddingOnly(
                right: screenWPadding16.sw(),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget expandedChildItem(
      {String? label,
      String? hint,
      bool showBorder = true,
      TextEditingController? controller,
      TextInputType? inputType}) {
    return _detailItem(label ?? "",
        hint: hint,
        type: inputType,
        showBorder: showBorder,
        controller: controller);
  }

  Widget _detailItem(String lable,
      {bool showBorder = true,
      String? hint,
      double? leftPadding,
      double? rightPadding,
      TextInputType? type,
      TextEditingController? controller}) {
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
              textInputType: type,
              controller: controller,
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
