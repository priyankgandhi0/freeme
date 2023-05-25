import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../../globle.dart';
import '../../../widgets/fm_appbar.dart';
import '../../../widgets/fm_expanded_view.dart';
import 'work_history_controller.dart';

class WorkHistoryScreen extends StatelessWidget {
  WorkHistoryScreen({Key? key}) : super(key: key);

  final controller = Get.put(WorkHistoryController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: backGroundWhiteColor,
        appBar: fMAppBar(
          workHistory,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              addNewJob(),
              fMExpandedView(
                title: "Commercial With Adam",
                description: "07/23/22",
              ).onClick(() {}).paddingOnly(
                    top: 24.sh(),
                  ),
              fMExpandedView(
                title: "Soulmates",
                description: "7/12/22 - 7/23/22",
                childList: const [
                  "07/23/22 - Soulmates",
                  "07/16/22 - Soulmates",
                  "07/12/22 - Soulmates",
                ],
              ).paddingOnly(
                top: screenHPadding16.sh(),
              ),
              fMExpandedView(
                title: "John Clay JLO",
                description: "07/02/22",
              ).paddingOnly(
                top: screenHPadding16.sh(),
              ),

              fMExpandedView(
                title: "FB Girlswirl",
                description: "06/11/22",
              ).paddingOnly(
                top: screenHPadding16.sh(),
              ),
              fMExpandedView(
                title: "Culprit",
                description: "05/21/22",
              ).paddingOnly(
                top: screenHPadding16.sh(),
              ),
              //expandableItem(),
            ],
          ),
        ).safeArea,
      ),
      onWillPop: () async {
        return false;
      },
    );
  }

  Widget addNewJob() {
    return DottedBorder(
      color: darkGreenColor,
      strokeWidth: 1,
      dashPattern: const [
        6,
        3,
      ],
      borderType: BorderType.RRect,
      radius: Radius.circular(10),
      child: SizedBox(
        width: Get.width,
        child: "Add New Job"
            .text(
                fontSize: 18,
                fontColor: darkGreenColor,
                weight: FontWeight.w500)
            .center
            .paddingOnly(
              top: 16.sh(),
              bottom: 16.sh(),
            ),
      ),
    ).onClick(() {
      Get.toNamed(Routes.workHistoryDetail);
    }).paddingOnly(left: 16.sw(), right: 16.sw(), top: 24.sh());
  }

  Widget expandableItem() {
    return GetBuilder<WorkHistoryController>(
        id: "ExpandedItem",
        builder: (ctrl) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ExpansionTile(
              title: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "Commercial With Adam"
                          .text(
                            fontSize: 16,
                            weight: FontWeight.w600,
                          )
                          .paddingOnly(top: 16),
                      "07/23/22"
                          .text(
                            fontSize: 14,
                            fontColor: greyTextColor,
                          )
                          .paddingOnly(
                            top: 8,
                            bottom: 16,
                          ),
                    ],
                  )
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  /*FmImage.assetImage(
                    path: ctrl.isExpanded
                        ? Assets.iconsDownIcon
                        : Assets.iconsForwardIcon,
                    height: ctrl.isExpanded ? 14 : 14,
                    width: ctrl.isExpanded ? 14 : 7,
                  )*/
                  Icon(
                    ctrl.isExpanded
                        ? Icons.arrow_back_ios
                        : Icons.arrow_forward_ios_rounded,
                    color: Colors.black,
                    size: 20,
                  )
                ],
              ),
              onExpansionChanged: (value) {
                value.debugPrint;
                ctrl.expansionChange(value);
              },
              children: [
                Container(
                  width: Get.width,
                  height: 1,
                  color: Colors.black,
                ),
                expandedChildItem("07/23/22 - Soulmates"),
                expandedChildItem("07/16/22 - Soulmates"),
                expandedChildItem("07/12/22 - Soulmates"),
              ],
            ),
          ).paddingOnly(
            left: screenHPadding16.sw(),
            right: screenHPadding16.sw(),
            top: 20,
            bottom: 20,
          );
        });
  }

  Widget expandedChildItem(String name) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: borderGreyColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          name.text(fontSize: 16, weight: FontWeight.w500).paddingOnly(
                left: screenWPadding16.sw(),
                top: screenHPadding16.sw(),
                bottom: screenHPadding16.sw(),
              ),
        ],
      ),
    );
  }
}
