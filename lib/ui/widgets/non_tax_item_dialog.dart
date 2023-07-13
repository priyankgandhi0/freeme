import 'package:flutter/material.dart';
import 'package:freeme/globle.dart';

import '../../api/repositories/quick_entry_repo.dart';
import '../../api/response_item.dart';
import '../../models/tax_per_time_model.dart';
import '../../models/taxed_item_types_model.dart';
import '../../models/taxed_nontaxed_item.dart';
import 'dropdown.dart';

class NonTaxItemDialog extends StatelessWidget {
  Function(TaxedNonTaxedModel model) onAddClick;

  NonTaxItemDialog(
      {Key? key, required this.onAddClick, this.defaultSelectedItem})
      : super(key: key);

  TaxedNonTaxedModel? defaultSelectedItem;

  final controller = Get.put(NonTaxItemDialogController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NonTaxItemDialogController>(
      initState: (initState) async {
        await controller.getAllTexedItemType();
        if (defaultSelectedItem != null) {
          controller.selectItemForEdit(defaultSelectedItem!);
        }
      },
      builder: (ctrl) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            topBar(context),
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
                fmDropDown(
                  child: nonTaxDropDownItem(ctrl),
                  onDropDownTap: (item) {
                    controller.onTypeListDropDownTap(item);
                  },
                  items: controller.typeList,
                  context: context,
                ).paddingOnly(
                  top: screenHPadding8.sh(),
                ),
                ctrl.typeError != null
                    ? Row(
                        children: [ctrl.typeError.text(fontColor: redColor)],
                      ).paddingOnly(
                        top: 4,
                      )
                    : Container(),
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
                          focusNode: FocusNode(),
                          hintText: "\$25",
                          textInputType: TextInputType.number,
                          controller: controller.amountController,
                        ).paddingOnly(
                          top: screenWPadding16.sw(),
                          left: screenWPadding16.sw(),
                          bottom: screenHPadding16.sh(),
                        ),
                      ).paddingOnly(
                        top: screenHPadding8.sh(),
                      ),
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
                      fmDropDown(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ctrl.selectedPerTime.text.text(
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
                                  top: screenHPadding16.sh(),
                                  bottom: screenHPadding16.sh(),
                                  left: screenWPadding16.sw(),
                                  right: screenWPadding16.sw(),
                                ),
                              ),
                              onDropDownTap: (item) {
                                controller.onPerHourListDropDownTap(item);
                              },
                              items: controller.perHourList,
                              context: context)
                          .paddingOnly(
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
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      ctrl.amountError != null
                          ? ctrl.amountError.text(fontColor: redColor)
                          : Container()
                    ],
                  ).paddingOnly(top: 4),
                ),
              ],
            ).paddingOnly(
              left: screenWPadding32.sw(),
              right: screenWPadding32.sw(),
            ),
            FmButton(
              ontap: () {
                if (controller.isValidate()) {
                  onAddClick(
                    TaxedNonTaxedModel(
                      type: controller.selectedTaxedItemType.text == "Other"
                          ? controller.typeManualController.text
                          : controller.selectedTaxedItemType.text,
                      timeDesc: controller.selectedPerTime.text,
                      timeId: controller.selectedPerTime.id,
                      amount: controller.amountController.text,
                      id: defaultSelectedItem?.id,
                      taxedItemId:
                          controller.selectedTaxedItemType.text == "Other"
                              ? 0
                              : controller.selectedTaxedItemType.id,
                      taxedTypeNote:
                          controller.selectedTaxedItemType.text == "Other"
                              ? ctrl.typeManualController.text
                              : null,
                    ),
                  );
                  controller.typeManualController.clear();
                  Navigator.of(context, rootNavigator: true).pop();
                }
              },
              name: add,
            ).paddingOnly(
              top: 24.sh(),
              bottom: 24.sh(),
              left: screenWPadding32.sw(),
              right: screenWPadding32.sw(),
            )
          ],
        );
      },
    );
  }

  topBar(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            addNonTaxItem
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
            .paddingOnly(
          top: 22.sh(),
          right: 22.sw(),
          left: 22.sw(),
          bottom: 22.sw(),
        )
            .onTap(
          () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ).positioned(right: 0)
      ],
    );
  }

  nonTaxDropDownItem(NonTaxItemDialogController ctrl) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ctrl.selectedTaxedItemType.text.text(
                fontColor: ctrl.selectedTaxedItemType.id != null
                    ? Colors.black
                    : greyTextColor,
                fontSize: 16,
              ),
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
          if (ctrl.selectedTaxedItemType.text == "Other") ...[
            Container(
              color: greyTextColor,
              height: 1,
              width: Get.width,
            ),
            FmEmptyTextField(
              focusNode: FocusNode(),
              textInputType: TextInputType.text,
              controller: ctrl.typeManualController,
              hintText: "Non-Taxed Item Note",
            ).paddingOnly(
              left: screenWPadding16.sw(),
              right: screenWPadding16.sw(),
              top: screenHPadding16.sw(),
              bottom: screenHPadding16.sw(),
            )
          ]
        ],
      ),
    );
  }
}

class NonTaxItemDialogController extends GetxController {
  TextEditingController amountController = TextEditingController();
  TextEditingController typeManualController = TextEditingController();

  @override
  void onInit() {
    getAllTexedItemType();
    getAllPerTimeDropDownItems();
    super.onInit();
  }

  List<MenuItem> typeList = [];

  Future getAllTexedItemType() async {
    ResponseItem response = await QuickEntryRepo.getTaxedItemTypeList();
    if (response.status) {
      typeList.clear();
      typeList.addAll(taxedItemTypesModelFromJson(response.data)
          .map((e) =>
              MenuItem(text: e.taxedItem, id: e.taxedItemId, isSelected: false))
          .toList());
      update();
    } else {}
  }

  MenuItem selectedTaxedItemType = MenuItem(text: "Select Type");

  void onTypeListDropDownTap(MenuItem item) {
    for (int i = 0; i < typeList.length; i++) {
      if (typeList[i].text == item.text) {
        if (typeList[i].isSelected) {
          typeList[i].isSelected = false;
          selectedTaxedItemType = MenuItem(text: "Select Type");
        } else {
          typeList[i].isSelected = true;
          selectedTaxedItemType = typeList[i];
        }
      } else {
        typeList[i].isSelected = false;
      }
    }
    update();
  }

  List<MenuItem> perHourList = [];

  Future getAllPerTimeDropDownItems() async {
    ResponseItem response = await QuickEntryRepo.getPerTimeList();
    if (response.status) {
      perHourList.clear();
      perHourList.addAll(taxPerTimeModelFromJson(response.data)
          .map(
            (e) => MenuItem(
              text: e.taxPerTimeCategory,
              id: e.taxPerTimeId,
              isSelected: false,
            ),
          )
          .toList());
      update();
    } else {}
  }

  MenuItem selectedPerTime = MenuItem(text: "Day", id: 1);

  void onPerHourListDropDownTap(MenuItem item) {
    for (int i = 0; i < perHourList.length; i++) {
      if (perHourList[i].text == item.text) {
        if (perHourList[i].isSelected) {
          perHourList[i].isSelected = false;
          selectedPerTime = MenuItem(text: "Day", id: 1);
        } else {
          perHourList[i].isSelected = true;
          selectedPerTime = perHourList[i];
        }
      } else {
        perHourList[i].isSelected = false;
      }
    }
    update();
  }

  String? typeError;
  String? amountError;

  bool isValidate() {
    if (selectedTaxedItemType.id == null || amountController.text.isEmpty) {
      if (selectedTaxedItemType.id == null) {
        typeError = "Enter Selected type";
      } else {
        typeError = null;
      }
      if (amountController.text.isEmpty) {
        amountError = "Enter Amount";
      } else {
        amountError = null;
      }
      update();
      return false;
    }
    typeError = null;
    amountError = null;
    update();
    return true;
  }

  void whenDialogClose() {
    onTypeListDropDownTap(MenuItem(text: "Select Type"));
    onPerHourListDropDownTap(MenuItem(text: "Day", id: 1));
    amountController.clear();
    update();
  }

  void selectItemForEdit(TaxedNonTaxedModel item) {
    selectedTaxedItemType =
        typeList.firstWhereOrNull((element) => element.text == item.type) ??
            MenuItem(text: "Select Type");
    selectedPerTime = perHourList
            .firstWhereOrNull((element) => element.text == item.timeId) ??
        MenuItem(text: "Day", id: 1);
    amountController.text = item.amount.toString();
    update();
  }
}
