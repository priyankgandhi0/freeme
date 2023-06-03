import 'package:flutter/material.dart';
import 'package:freeme/globle.dart';

import 'dropdown.dart';

class TaxItemDialog extends StatelessWidget {
  TaxItemDialog({Key? key}) : super(key: key);

  final controller = Get.put(TaxedItemDialogController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaxedItemDialogController>(
      builder: (ctrl) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    taxedItem
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
                ).paddingOnly(
                  top: 22.sh(),
                  right: 22.sw(),
                  left: 22.sw(),
                  bottom: 22.sw(),
                ).onTap(
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
                  child: Container(
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
                  ),
                  onDropDownTap: (item) {
                    controller.onTypeListDropDownTap(item);
                  },
                  items: controller.typeList,
                  context: context,
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
                          textInputType: TextInputType.number,
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
        );
      },
    );
  }
}

class TaxedItemDialogController extends GetxController {
  List<MenuItem> typeList = [
    MenuItem(text: "Mileage", isSelected: true),
    MenuItem(text: "Box Kit", isSelected: false),
    MenuItem(text: "Per Diem", isSelected: false),
    MenuItem(text: "Reimbursement", isSelected: false),
  ];
  List<MenuItem> perHourList = [
    MenuItem(text: "Day", isSelected: true),
    MenuItem(text: "Week", isSelected: false),
    MenuItem(text: "Month", isSelected: false),
    MenuItem(text: "Flat", isSelected: false),
  ];

  void onTypeListDropDownTap(MenuItem item) {
    for (int i = 0; i < typeList.length; i++) {
      if (typeList[i].text == item.text) {
        if (typeList[i].isSelected) {
          typeList[i].isSelected = false;
        } else {
          typeList[i].isSelected = true;
        }
      } else {
        typeList[i].isSelected = false;
      }
    }
    update();
  }

  void onPerHourListDropDownTap(MenuItem item) {
    for (int i = 0; i < perHourList.length; i++) {
      if (perHourList[i].text == item.text) {
        if (perHourList[i].isSelected) {
          perHourList[i].isSelected = false;
        } else {
          perHourList[i].isSelected = true;
        }
      } else {
        perHourList[i].isSelected = false;
      }
    }
    update();
  }
}
