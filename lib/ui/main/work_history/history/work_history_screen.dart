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
              addNewJob(context),
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

  Widget addNewJob(BuildContext context) {
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
      Navigator.pushNamed(context, Routes.addJobScreen);
    }).paddingOnly(left: 16.sw(), right: 16.sw(), top: 24.sh());
  }

}
