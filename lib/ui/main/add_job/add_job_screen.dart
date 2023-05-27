import 'package:flutter/material.dart';

import '../../../globle.dart';
import '../../widgets/fm_appbar.dart';
import '../../widgets/fm_dialog.dart';
import 'add_job_controller.dart';

class AddJobScreen extends StatelessWidget {
  AddJobScreen({Key? key}) : super(key: key);

  final controller = Get.put(AddJobController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: fMAppBar(addJob, onBackClick: () {}),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FmButton(
                ontap: () {},
                name: autoPopulateLastEntry,
              ).paddingOnly(
                top: 24.sh(),
                left: screenWPadding16.sw(),
                right: screenWPadding16.sw(),
              ),
              _daysCard(),
              _discriptionCard(),
              _rateCard(),
              _jobClassificationCard(),
              _taxeditemCard(),
              _nonTaxItemsCard(context),
              _addJobButton()
            ],
          ),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }

  Widget _daysCard() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          daysStar.text(
            fontColor: redTextColor,
            fontSize: 16,
          ),
          Row(
            children: [
              selectDays
                  .text(
                    fontColor: greyTextColor,
                    fontSize: 16,
                  )
                  .paddingOnly(
                    right: 10.sw(),
                  ),
              FmImage.assetImage(
                path: Assets.iconsForwardIcon,
                height: 15.sh(),
                width: 8.sw(),
              )
            ],
          )
        ],
      ).paddingOnly(
        top: screenHPadding16.sh(),
        bottom: screenHPadding16.sh(),
        left: screenWPadding16.sw(),
        right: screenWPadding16.sw(),
      ),
    ).paddingOnly(
      top: 24.sh(),
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
    );
  }

  Widget _discriptionCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            offset: Offset(2, 3),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Column(
        children: [
          _detailItem(description, hint: "Commercial with Joey"),
          _detailItem(title, hint: "Commercial#1234"),
          _detailItem(producer, hint: "Full Name"),
          _detailItem(prodCompany, hint: "Company, LLC"),
          _expandableDetailItem()
        ],
      ),
    ).paddingOnly(
      top: screenHPadding16.sh(),
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
    );
  }

  Widget _rateCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            offset: Offset(2, 3),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Column(
        children: [
          _detailItemWithDropDown("Rate*",
              hint: "\$750", showDownIcon: false, labelColor: redTextColor),
          _detailItemWithDropDown(
            per,
            hint: "10 Hours",
          ),
          _detailItemWithDropDown(
            guarHours,
            hint: "10 Hours",
          ),
          _detailItemWithDropDown(
            w21099,
            hint: "Not Sure",
          ),
          _detailItemWithDropDown(
            paidBy,
            hint: "Ep Services",
          ),
          _detailItemWithDropDown(
            terms,
            hint: "Net 15",
          ),
        ],
      ),
    ).paddingOnly(
      top: screenHPadding16.sh(),
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
    );
  }

  Widget _jobClassificationCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            offset: Offset(2, 3),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Column(
        children: [
          _detailItemWithDropDown(jobClassification,
              hint: "Camera/1st Assist...",
              showDownIcon: true,
              labelColor: redTextColor,
              customSuffix: FmImage.assetImage(
                path: Assets.iconsForwardIcon,
                height: 15.sh(),
                width: 15.sw(),
                color: Colors.black,
              ).paddingOnly(
                right: screenWPadding16.sw(),
              )),
          _detailItemWithDropDown(
            type,
            hint: "Commercial",
          ),
          _detailItemWithDropDown(
            unionNonUnion,
            hint: "Non-Union",
          ),
          _detailItemWithDropDown(
            recommendedBy,
            hint: "Erica Chan",
          ),
          _detailItemWithDropDown(
            hiredby,
            hint: "Zachariah Dalton",
          ),
        ],
      ),
    ).paddingOnly(
      top: screenHPadding16.sh(),
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
    );
  }

  Widget _taxeditemCard() {
    return Column(
      children: [
        Row(
          children: [
            taxedItems.text(
              fontSize: 18,
              weight: FontWeight.w500,
            ),
          ],
        ),
        _iconTextButton(
          taxedItems,
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

  Widget _nonTaxItemsCard(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            nonTaxItem.text(
              fontSize: 18,
              weight: FontWeight.w500,
            ),
          ],
        ),
        _iconTextButton(addNonTaxItem, onclick: () {
          showNonTaxItems(context);
        }).paddingOnly(
          top: screenHPadding8.sh(),
        )
      ],
    ).paddingOnly(
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
      top: screenHPadding16.sh(),
    );
  }

  Widget _iconTextButton(String lable, {GestureTapCallback? onclick}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Row(
        children: [
          FmImage.assetImage(
            path: Assets.iconsPlusicon,
            height: 20.sh(),
            width: 20.sw(),
          ),
          lable
              .text(
                fontSize: 16,
              )
              .paddingOnly(
                left: 10,
              ),
        ],
      ).paddingOnly(
        top: screenHPadding16.sh(),
        bottom: screenHPadding16.sh(),
        left: screenWPadding16.sw(),
        right: screenWPadding16.sw(),
      ),
    ).onClick(
      onclick ?? () {},
    );
  }

  Widget _addJobButton() {
    return FmButton(
      ontap: () {},
      name: addJob,
    ).paddingOnly(
      top: screenHPadding32.sh(),
      bottom: screenHPadding32.sh(),
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
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

  Widget _detailItemWithDropDown(
    String lable, {
    bool showBorder = true,
    String? hint,
    bool showDownIcon = true,
    Color labelColor = Colors.black,
    Widget? customSuffix,
  }) {
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
                      fontColor: labelColor,
                      fontSize: 16,
                    )
                    .paddingOnly(left: 20.sw())
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                hint.text(fontColor: greyTextColor, fontSize: 16),
                showDownIcon
                    ? customSuffix ??
                        FmImage.assetImage(
                          path: Assets.iconsDownIcon,
                          height: 15.sh(),
                          width: 15.sw(),
                          color: greyTextColor,
                        ).paddingOnly(
                          right: screenWPadding16.sw(),
                        )
                    : Container()
              ],
            ),
          )
        ],
      ).paddingOnly(
        top: screenHPadding16.sh(),
        bottom: 16.sh(),
      ),
    );
  }

  Widget _expandableDetailItem() {
    return GetBuilder<AddJobController>(
        id: "CompanyAdddressExpanded",
        builder: (ctrl) {
          return ExpansionTile(
            title: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    companyAddress.text(
                      fontSize: 16,
                    )
                  ],
                )
              ],
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
                color: borderGreyColor,
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
          );
        });
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
      leftPadding: screenWPadding16.sw(),
      rightPadding: screenWPadding16.sw(),
    );
  }

  void showNonTaxItems(BuildContext context) {
    fMDialog(
      context: context,
      horizontalPadding: 16,
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
                        bottom: screenHPadding16.sh(),
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
                    top: 22.sh(),
                    right: 22.sw(),
                  )
                  .positioned(right: 0)
            ],
          ),
          Container(
            color: bottomLineGreyColor,
            width: Get.width,
            height: 1,
          ),
          Column(
            children: [
              Row(
                children: [
                  "Type".text(
                    fontSize: 16,
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "Mileage".text(fontColor: greyTextColor, fontSize: 16),
                    FmImage.assetImage(
                      path: Assets.iconsDownIcon,
                      fit: BoxFit.fill,
                      size: 14,
                    )
                  ],
                ).paddingOnly(
                  left: screenWPadding16.sw(),
                  right: screenWPadding16.sw(),
                  top: screenHPadding16.sw(),
                  bottom: screenHPadding16.sw(),
                ),
              ).paddingOnly(
                top: screenHPadding8.sh(),
              )
            ],
          ).paddingOnly(
            left: screenWPadding32.sw(),
            right: screenWPadding32.sw(),
            top: screenHPadding16.sh(),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Amount".text(
                      fontSize: 16,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: FmEmptyTextField(
                        hintText: "\$25",
                      ).paddingOnly(
                        top: screenWPadding16.sw(),
                        left: screenWPadding16.sw(),
                        bottom: screenHPadding16.sh(),
                      ),
                    ).paddingOnly(
                      top: screenHPadding8.sh(),
                    )
                  ],
                ).paddingOnly(right: 16),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    per.text(
                      fontSize: 16,
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
                          day.text(
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
                        top: screenHPadding16.sh(),
                        bottom: screenHPadding16.sh(),
                        left: screenWPadding16.sw(),
                        right: screenWPadding16.sw(),
                      ),
                    ).paddingOnly(
                      top: screenHPadding8.sh(),
                    )
                  ],
                ),
              ),
            ],
          ).paddingOnly(
            left: screenWPadding32.sw(),
            right: screenWPadding32.sw(),
            top: screenHPadding16.sh(),
          ),
          FmButton(
            ontap: () {},
            name: add,
          ).paddingOnly(
            top: 24.sh(),
            bottom: 24.sh(),
            left: screenWPadding32.sw(),
            right: screenWPadding32.sw(),
          )
        ],
      ),
    );
  }
}
