import 'package:flutter/material.dart';
import '../../../globle.dart';
import '../../../models/taxed_nontaxed_item.dart';
import '../../../utils/app_utils.dart';
import '../../widgets/app_calender.dart';
import '../../widgets/dropdown.dart';
import '../../widgets/fm_appbar.dart';
import '../../widgets/fm_dialog.dart';
import '../../widgets/non_tax_item_dialog.dart';
import '../../widgets/slidable/src/action_pane_motions.dart';
import '../../widgets/slidable/src/actions.dart';
import '../../widgets/slidable/src/slidable.dart';
import '../../widgets/tax_item_dialog.dart';
import 'add_job_controller.dart';

class AddJobScreen extends StatelessWidget {
  AddJobScreen({Key? key}) : super(key: key);

  final controller = Get.put(AddJobController());
  bool isForEdit = false;
  int jobId = -1;

  @override
  Widget build(BuildContext context) {
    Map arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    isForEdit = arguments["ForEdit"] ?? false;
    jobId = arguments["job_id"] ?? -1;

    return WillPopScope(
      child: Scaffold(
        appBar: fMAppBar(
          isForEdit ? editJob : addJob,
          onBackClick: () {
            Navigator.of(context).pop();
          },
        ),
        body: SingleChildScrollView(
          child: GetBuilder<AddJobController>(
            initState: (initState) async {
              await controller.loadAllDropDown();
              if (isForEdit) {
                Future.delayed(
                  Duration.zero,
                  () async {
                    controller.getJobInfo(
                      jobId: jobId,
                    );
                  },
                );
              }
            },
            builder: (ctrl) {
              return Column(
                children: [
                  isForEdit ? Container() : _autoPopulatedlastEntryButton(),
                  _daysDropdownButton(context, ctrl),
                  _discriptionCard(context),
                  _rateCard(context),
                  _jobClassificationCard(context, ctrl),
                  _taxedItemCard(context),
                  _nonTaxItemsCard(context),
                  isForEdit ? _saveButton(context) : _addJobButton(context)
                ],
              );
            },
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
      ontap: () {
        controller.autoPopulatelastEntry();
      },
      name: autoPopulateLastEntry,
    ).paddingOnly(
      top: 24.sh(),
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
    );
  }

  Widget _saveButton(BuildContext context) {
    return FmButton(
      ontap: () {
        controller.addJobButtonClick(context, jobId: jobId);
      },
      name: save,
    ).paddingOnly(
      top: screenHPadding32.sh(),
      bottom: screenHPadding32.sh(),
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
    );
  }

  Widget _daysDropdownButton(BuildContext context, AddJobController ctrl) {
    return _daysCard().onClick(() {
      showCalenderDropDown(context, ctrl);
    });
  }

  showCalenderDropDown(BuildContext context, AddJobController ctrl) {
    fMDialog(
      context: context,
      horizontalPadding: 16,
      child: GetBuilder<AddJobController>(
        id: "DaysDialogController",
        builder: (ctrl) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      selectDays
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
                      .paddingOnly(
                    top: 20.sh(),
                    right: screenWPadding16.sw(),
                    left: screenWPadding16.sw(),
                    bottom: screenWPadding16.sw(),
                  )
                      .onTap(
                    () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                  ).positioned(right: 0)
                ],
              ),
              Container(
                color: bottomLineGreyColor,
                width: Get.width,
                height: 1,
              ),
              AppCalender(
                currentDay: ctrl.currentDay,
                focusDay: ctrl.focusedDay,
                onDaySelected: (selectedDay, focusDay) {
                  ctrl.onDaySelect(selectedDay, focusDay);
                },
                onMonthChange: (date) {},
                selectedDays: ctrl.selectedDays,
              ).paddingOnly(
                top: screenHPadding16.sh(),
                left: screenWPadding16.sw(),
                right: screenWPadding16.sw(),
              ),
              Row(
                children: [
                  ctrl.calenderError != null
                      ? ctrl.calenderError.text(fontColor: redColor)
                      : Container(),
                ],
              ).paddingOnly(
                left: screenWPadding32.sw(),
                right: screenWPadding16.sw(),
                top: 4.sh(),
                bottom: screenHPadding16.sh(),
              ),
              FmButton(
                ontap: () {
                  controller.onSelectDaysClick(context);
                },
                name: select,
              ).paddingAll(10)
            ],
          );
        },
      ),
    ).whenComplete(() {
      controller.update();
    });
  }

  Widget _daysCard() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                daysStar.text(
                  fontColor: redTextColor,
                  fontSize: 16,
                ),
                controller.daysError != null
                    ? FmImage.assetImage(
                        path: Assets.iconsErrorIcon,
                        height: 15.sh(),
                        width: 15.sw(),
                      ).paddingOnly(right: 12)
                    : Container()
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: (controller.selectedDays.isNotEmpty
                          ? getDaysMonthWise(controller.selectedDays)
                          : selectDays)
                      .text(
                          fontColor: controller.selectedDays.isNotEmpty
                              ? Colors.black
                              : greyTextColor,
                          fontSize: 16,
                          overFlow: TextOverflow.ellipsis)
                      .paddingOnly(
                        right: 10.sw(),
                      ),
                ),
                FmImage.assetImage(
                  path: Assets.iconsForwardIcon,
                  height: 15.sh(),
                  width: 8.sw(),
                )
              ],
            ),
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

  String getDaysMonthWise(Set<DateTime> selectedDays) {
    String generatedDate = "";
    var coreMonths = selectedDays.toList().map((e) => e.month);
    List<int> months = coreMonths.toSet().toList();
    months.toList().forEach((e1) {
      generatedDate = "$generatedDate${monthList[e1]} ";
      generatedDate = generatedDate +
          selectedDays
              .toList()
              .where((element) => element.month == e1)
              .toList()
              .map((e) => e.day)
              .join(",");
    });
    return generatedDate;
  }

  Widget _discriptionCard(BuildContext context) {
    return Column(
      children: [
        Container(
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
              _detailItem(descriptionStar,
                  hint: "Commercial with Joey",
                  color: redTextColor,
                  controller: controller.descriptionController,
                  error: controller.descriptionError,
                  focusNode: FocusNode()),
              _detailItem(title,
                  hint: "Commercial#1234",
                  controller: controller.productionTitleController,
                  focusNode: FocusNode()),
              _detailItem(producer,
                  hint: "Full Name",
                  controller: controller.producerController,
                  focusNode: FocusNode()),
              _detailItem(prodCompany,
                  hint: "Company, LLC",
                  controller: controller.productionCompanyController,
                  focusNode: FocusNode()),
              _expandableDetailItem(context)
            ],
          ),
        ).paddingOnly(
          top: screenHPadding16.sh(),
          left: screenWPadding16.sw(),
          right: screenWPadding16.sw(),
        ),
        /*Row(
          children: [
            controller.descriptionError != null
                ? controller.descriptionError.text(fontColor: redColor).paddingOnly(   left: screenWPadding16.sw(), top: 4)
                : Container()

          ],
        )*/
      ],
    );
  }

  Widget _rateCard(BuildContext context) {
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
          _detailItem("Rate*",
              hint: "\$750",
              controller: controller.rateTextController,
              color: redColor,
              textInputType: TextInputType.number,
              error: controller.rateError,
              focusNode: FocusNode()),
          fmDropDown(
            child: _detailItemWithDropDown(
              perStar,
              labelColor: redColor,
              hint: controller.selectedPerHour.text,
            ),
            onDropDownTap: (item) {
              controller.onPerHourDropDownTap(item);
            },
            items: controller.allPerHour,
            context: context,
          ),
          fmDropDown(
            child: _detailItemWithDropDown(
              guarHours,
              hint: controller.selectedGuaranteedHour.text,
            ),
            onDropDownTap: (item) {
              controller.onPerGuaranteedHourDropDownTap(item);
            },
            items: controller.allGuaranteedHour,
            context: context,
          ),
          fmDropDown(
            child: _detailItemWithDropDown(
              w21099,
              hint: controller.selectedW2Or1099.text,
            ),
            onDropDownTap: (item) {
              controller.onw21099DropDownTap(item);
            },
            items: controller.w21099List,
            context: context,
          ),
          fmDropDown(
            child: _detailItemWithDropDown(
              paidBy,
              hint: controller.selectedPaidBy.text,
            ),
            onDropDownTap: (item) {
              controller.onPaidByDropDownTap(item);
            },
            items: controller.allPaidBy,
            context: context,
            width: 250,
          ),
          if (controller.selectedPaidBy.text == "Other") ...[
            _detailItem("",
                hint: "Paid By Notes",
                controller: controller.paidByManualController,
                focusNode: FocusNode()),
          ],
          fmDropDown(
            child: _detailItemWithDropDown(
              terms,
              hint: controller.selectedTerm.text,
            ),
            onDropDownTap: (item) {
              controller.onTermDropDownTap(item);
            },
            items: controller.allTerms,
            context: context,
            width: 180,
          ),
          if (controller.selectedTerm.text == "Other") ...[
            _detailItem("",
                hint: "Term Notes",
                controller: controller.termsManualController,
                focusNode: FocusNode()),
          ],
        ],
      ),
    ).paddingOnly(
      top: screenHPadding16.sh(),
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
    );
  }

  Widget _jobClassificationCard(BuildContext context, AddJobController ctrl) {
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
          _jobClassificationDetailItem(context),
          fmDropDown(
            child: _detailItemWithDropDown(
              type,
              hint: ctrl.selectedType.text,
            ),
            onDropDownTap: (item) {
              controller.onTypeDropDownTap(item);
            },
            items: controller.allTypes,
            context: context,
            width: 210,
          ),
          if (controller.selectedType.text == "Other") ...[
            _detailItem("",
                hint: "Type Notes",
                controller: controller.typeManualController,
                focusNode: FocusNode()),
          ],
          fmDropDown(
            showDash: true,
            child: _detailItemWithDropDown(
              unionNonUnion,
              hint: ctrl.selectedUnion.text,
            ),
            onDropDownTap: (item) {
              controller.onUnionNonUnionDropDownTap(item);
            },
            items: controller.unionNonUnionList,
            context: context,
          ),
          _detailItem(recommendedBy,
              hint: "Erica Chan",
              controller: controller.recommendedByController,
              focusNode: FocusNode()),
          _detailItem(hiredby,
              hint: "Zachariah Dalton",
              controller: controller.hiredByController,
              focusNode: FocusNode()),
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
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.black,
            ),
          ),
          child: Column(
            children: [
              ListView.builder(
                itemCount: controller.taxedItems.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _taxedNonTaxedItem(
                    controller.taxedItems[index],
                    index,
                    onRemoveIconClick: () {
                      controller.addDeleteButton(index);
                    },
                    onDeleteButtonClick: () {
                      controller.removeTaxedItem(controller.taxedItems[index]);
                    },
                  ).onClick(() {
                    "onTaxItemClick".debugPrint;
                    showTaxedItems(
                      context,
                      defaultItem: controller.taxedItems[index],
                    );
                  });
                },
              ),
              _iconTextButton(
                addTaxedItem,
                onclick: () {
                  showTaxedItems(context);
                },
              ).paddingOnly(
                top: /*controller.nonTaxedItem.isNotEmpty ? 0 :*/
                    screenHPadding16.sh(),
                left: screenWPadding16.sw(),
                right: screenWPadding16.sw(),
              )
            ],
          ).paddingOnly(
            bottom: screenHPadding16.sh(),
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

  ///***
  Widget _taxedNonTaxedItem(
    TaxedNonTaxedModel item,
    int index, {
    GestureTapCallback? onRemoveIconClick,
    required GestureTapCallback? onDeleteButtonClick,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Row(
              children: [
                FmImage.assetImage(
                  path: Assets.iconsMinusIcon,
                  height: 20.sh(),
                  width: 20.sw(),
                )
                    .paddingOnly(
                      top: screenHPadding16.sh(),
                      bottom: screenHPadding16.sh(),
                      left: screenWPadding16.sw(),
                      right: screenWPadding16.sw(),
                    )
                    .onClick(onRemoveIconClick ?? () {}),
                item.type.text(fontSize: 16)
              ],
            ),
            const Spacer(),
            Row(
              children: [
                "\$${item.amount} / ${item.timeDesc}".text(
                  fontSize: 16,
                ),
              ],
            ),
            const Spacer(),
            item.showDeleteButton
                ? Container(
                    width: 100,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(index == 0 ? 10 : 0),
                      ),
                    ),
                    child: "DELETE"
                        .text(fontColor: Colors.white, fontSize: 14)
                        .center,
                  ).onClick(
                    () {
                      if (onDeleteButtonClick != null) {
                        onDeleteButtonClick();
                      }
                    },
                  )
                : Container()
          ],
        ),
        Container(
          height: 1,
          width: Get.width,
          color: borderGreyColor,
        )
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
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.black,
            ),
          ),
          child: Column(
            children: [
              ListView.builder(
                itemCount: controller.nonTaxedItems.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _taxedNonTaxedItem(
                    controller.nonTaxedItems[index],
                    index,
                    onRemoveIconClick: () {
                      controller.addNonTaxDeleteButton(index);
                    },
                    onDeleteButtonClick: () {
                      controller
                          .removeNonTaxedItem(controller.nonTaxedItems[index]);
                    },
                  ).onClick(() {
                    showNonTaxItems(context,
                        defaultItem: controller.nonTaxedItems[index]);
                  });
                },
              ),
              _iconTextButton(
                addNonTaxItem,
                onclick: () {
                  showNonTaxItems(context);
                },
              ).paddingOnly(
                top: /*controller.nonTaxedItem.isNotEmpty ? 0 :*/
                    screenHPadding16.sh(),
                left: screenWPadding16.sw(),
                right: screenWPadding16.sw(),
              )
            ],
          ).paddingOnly(
            bottom: screenHPadding16.sh(),
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
    ).onTap(onclick ?? () {});
  }

  Widget _addJobButton(BuildContext context) {
    return FmButton(
      ontap: () {
        controller.addJobButtonClick(context);
      },
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
      String? error,
      double? leftPadding,
      double? rightPadding,
      Color? color = Colors.black,
      TextInputType? textInputType,
      required FocusNode focusNode,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                lable
                    .text(
                      fontColor: color,
                      fontSize: 16,
                    )
                    .paddingOnly(left: 20.sw()),
                error != null
                    ? FmImage.assetImage(
                        path: Assets.iconsErrorIcon,
                        height: 15.sh(),
                        width: 15.sw(),
                      ).paddingOnly(right: 12)
                    : Container()
              ],
            ),
          ),
          Expanded(
            child: FmEmptyTextField(
              hintText: hint,
              focusNode: focusNode,
              textInputType: textInputType,
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

  Widget _detailItemWithDropDown(String title,
      {bool showBorder = true,
      String? hint,
      bool showDownIcon = true,
      Color labelColor = Colors.black,
      Widget? customSuffix,
      String? error}) {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                title
                    .text(
                      fontColor: labelColor,
                      fontSize: 16,
                    )
                    .paddingOnly(
                      left: 20.sw(),
                    ),
                error != null
                    ? FmImage.assetImage(
                        path: Assets.iconsErrorIcon,
                        height: 15.sh(),
                        width: 15.sw(),
                      ).paddingOnly(right: 12)
                    : Container()
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: hint.text(
                      fontColor: Colors.black,
                      fontSize: 16,
                      overFlow: TextOverflow.ellipsis),
                ),
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

  Widget _expandableDetailItem(BuildContext context) {
    return GetBuilder<AddJobController>(
        id: "CompanyAdddressExpanded",
        initState: (init) {
          controller.getAllCountryFromRaw(context);
        },
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
                child: countryItemWithDropDown(ctrl.selectedCountry.text ?? ""),
                width: 240,
                onDropDownTap: (item) {
                  controller.onCountryDropDownTap(item);
                },
                items: controller.countryList,
                context: context,
              )
            ],
          );
        });
  }

  Widget _jobClassificationDetailItem(BuildContext context) {
    return GetBuilder<AddJobController>(
      id: "jobClassificationExpanded",
      initState: (init) {},
      builder: (ctrl) {
        return Column(
          children: [
            ExpansionTile(
              initiallyExpanded: true,
              title: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      jobClassification.text(fontSize: 16, fontColor: redColor)
                    ],
                  )
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ctrl.isJobClassificationExpanded
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
                ctrl.onJobClassificationExpansionChange(value);
              },
              children: [
                Container(
                  width: Get.width,
                  height: 1,
                  color: borderGreyColor,
                ),
                fmDropDown(
                  child: _detailItemWithDropDown(departmentStar,
                      labelColor: redColor,
                      hint:
                          ctrl.selectedDepartment.text?.replaceFirst("-", "/"),
                      error: controller.departmentError),
                  onDropDownTap: (item) {
                    controller.onDepartmentTap(item);
                  },
                  items: controller.allJobClassificationList,
                  context: context,
                  width: 215,
                ).paddingOnly(
                  left: screenWPadding8.sw(),
                ),
                fmDropDown(
                  showDash: true,
                  child: _detailItemWithDropDown(positionStar,
                      labelColor: redColor,
                      hint: controller.selectedPosition.text,
                      showBorder: false,
                      error: controller.positionError),
                  onDropDownTap: (item) {
                    controller.onPositionTap(item);
                  },
                  items: controller.allSubJobList,
                  context: context,
                  width: 230,
                ).paddingOnly(
                  left: screenWPadding8.sw(),
                ),
              ],
            ),
            ctrl.isJobClassificationExpanded
                ? Container()
                : Container(
                    height: 1,
                    width: Get.width,
                    color: borderGreyColor,
                  ),
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
      TextInputType? inputType,
      TextEditingController? controller}) {
    return _detailItem(label ?? "",
        hint: hint,
        showBorder: showBorder,
        leftPadding: screenWPadding16.sw(),
        rightPadding: screenWPadding16.sw(),
        controller: controller,
        textInputType: inputType,
        focusNode: FocusNode());
  }

  void showNonTaxItems(BuildContext context,
      {TaxedNonTaxedModel? defaultItem}) {
    fMDialog(
      context: context,
      horizontalPadding: 16,
      child: NonTaxItemDialog(
          defaultSelectedItem: defaultItem,
          onAddClick: (model) {
            if (model.id != null) {
              var index = controller.nonTaxedItems
                  .indexWhere((element) => element.id == model.id);
              controller.nonTaxedItems.removeAt(index);
              controller.nonTaxedItems.insert(index, model);
              controller.update();
            } else {
              controller.nonTaxedItems.add(model);
              controller.update();
            }
          }),
    ).whenComplete(
      () {
        Get.find<NonTaxItemDialogController>().whenDialogClose();
      },
    );
  }

  void showHoursDropDown() {}

  void showTaxedItems(BuildContext context, {TaxedNonTaxedModel? defaultItem}) {
    fMDialog(
      context: context,
      horizontalPadding: 16,
      child: TaxItemDialog(
        defaultSelectedItem: defaultItem,
        onAddClick: (TaxedNonTaxedModel model) {
          if (model.id != null) {
            var index = controller.taxedItems
                .indexWhere((element) => element.id == model.id);
            controller.taxedItems.removeAt(index);
            controller.taxedItems.insert(index, model);
            controller.update();
          } else {
            controller.taxedItems.add(model);
            controller.update();
          }
        },
      ),
    ).whenComplete(
      () {
        Get.find<TaxedItemDialogController>().whenDialogClose();
        Get.find<TaxedItemDialogController>().typeManualController.clear();
      },
    );
  }
}
