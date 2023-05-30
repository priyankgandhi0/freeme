import 'package:flutter/material.dart';

import '../../../globle.dart';
import '../../widgets/fm_appbar.dart';
import '../../widgets/fm_dialog.dart';
import '../../widgets/non_tax_item_dialog.dart';
import 'add_job_controller.dart';

class AddJobScreen extends StatelessWidget {
  AddJobScreen({Key? key}) : super(key: key);

  final controller = Get.put(AddJobController());
  bool isForEdit = false;

  @override
  Widget build(BuildContext context) {
    Map arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    isForEdit = arguments["ForEdit"] ?? false;

    return WillPopScope(
      child: Scaffold(
        appBar: fMAppBar(
          isForEdit ? editJob : addJob,
          onBackClick: () {},
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              isForEdit ? Container() : _autoPopulatedlastEntryButton(),
              _daysCard(),
              _discriptionCard(),
              _rateCard(),
              _jobClassificationCard(),
              _taxedItemCard(context),
              _nonTaxItemsCard(context),
              isForEdit ? _saveButton() : _addJobButton()
            ],
          ),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }

  Widget _autoPopulatedlastEntryButton() {
    return FmButton(
      ontap: () {},
      name: autoPopulateLastEntry,
    ).paddingOnly(
      top: 24.sh(),
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
    );
  }

  Widget _saveButton() {
    return FmButton(
      ontap: () {},
      name: save,
    ).paddingOnly(
      top: screenHPadding32.sh(),
      bottom: screenHPadding32.sh(),
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
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
    ).onClick(() {}).paddingOnly(
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

  Widget _taxedItemCard(BuildContext context) {
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
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.black,
            ),
          ),
          child: Column(
            children: [
              ListView.builder(
                itemCount: controller.nonTaxedItem.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _taxedNonTaxedItem(
                    controller.nonTaxedItem[index],
                  );
                },
              ),
              _iconTextButton(
                taxedItems,
                onclick: () {
                  showNonTaxItems(context);
                },
              )
            ],
          ).paddingOnly(
            top: controller.nonTaxedItem.isNotEmpty ? 0 : screenHPadding16.sh(),
            bottom: screenHPadding16.sh(),
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
      top: screenHPadding16.sh(),
    );
  }

  Widget _taxedNonTaxedItem(NonTaxedItem item) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  FmImage.assetImage(
                    path: Assets.iconsMinusIcon,
                    height: 20.sh(),
                    width: 20.sw(),
                  ),
                  item.name.text(fontSize: 16).paddingOnly(
                        left: 10.sw(),
                      )
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  item.value.text(fontSize: 16),
                ],
              ),
            )
          ],
        ).paddingOnly(top: 16, bottom: 16)
      ],
    );
  }

  Widget _nonTaxItemsCard(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            nonTaxItems.text(
              fontSize: 18,
              weight: FontWeight.w500,
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.black,
            ),
          ),
          child: Column(
            children: [
              ListView.builder(
                itemCount: controller.nonTaxedItem.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _taxedNonTaxedItem(
                    controller.nonTaxedItem[index],
                  );
                },
              ),
              _iconTextButton(
                addNonTaxItem,
                onclick: () {
                  showNonTaxItems(context);
                },
              )
            ],
          ).paddingOnly(
            top: controller.nonTaxedItem.isNotEmpty ? 0 : screenHPadding16.sh(),
            bottom: screenHPadding16.sh(),
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
      top: screenHPadding16.sh(),
    );
  }

  Widget _iconTextButton(String lable, {GestureTapCallback? onclick}) {
    return Row(
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
    ).onClick(onclick ?? () {});
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
                    companyAddressStar.text(
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
      child: NonTaxItemDialog(),
    );
  }
}
