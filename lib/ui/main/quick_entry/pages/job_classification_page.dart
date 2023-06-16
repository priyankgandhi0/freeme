import 'package:flutter/material.dart';

import '../../../../globle.dart';
import '../../../widgets/dropdown.dart';
import '../quick_entry_controller.dart';

class JobClassificationPage extends StatelessWidget {
  JobClassificationPage({Key? key}) : super(key: key);

  final controller = Get.put(QuickEntryController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GetBuilder<QuickEntryController>(
        builder: (ctrl) {
          return Column(
            children: [
              Row(
                children: [
                  "Job Classification"
                      .text(fontSize: 18, weight: FontWeight.w500)
                      .paddingOnly(
                        left: screenWPadding16.sw(),
                      ),
                ],
              ),
              _department(context, ctrl),
              _position(context, ctrl),
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
            controller.pageController.jumpToPage(2);
          },
          width: 120,
          name: back,
        ),
        FmButton(
          ontap: () {
            controller.moveToFifthPage();
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

  Widget _position(BuildContext context, QuickEntryController ctrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        positionStar.text(fontSize: 16, fontColor: redColor),
        fmDropDown(
          width: 300,
          child: _positionDropDownItem(ctrl.selectedPosition),
          onDropDownTap: (item) {
            controller.onPositionTap(item);
          },
          items: controller.allSubJobList,
          context: context,
        ),
        ctrl.positionError != null
            ? ctrl.positionError.text(fontColor: redColor).paddingOnly(top: 8)
            : Container()
      ],
    ).paddingOnly(
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
      top: screenHPadding16.sw(),
    );
  }

  Widget _department(BuildContext context, QuickEntryController ctrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        departmentStar.text(fontSize: 16, fontColor: redColor),
        fmDropDown(
          width: 300,
          child: _departmentDropDownItem(ctrl.selectedDepartment),
          onDropDownTap: (item) {
            controller.onDepartmentTap(item);
          },
          items: controller.allJobClassificationList,
          context: context,
        ),
        ctrl.departmentError != null
            ? ctrl.departmentError.text(fontColor: redColor).paddingOnly(top: 8)
            : Container()
      ],
    ).paddingOnly(
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
      top: screenHPadding16.sw(),
    );
  }

  Widget _departmentDropDownItem(MenuItem selectedDepartment) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          selectedDepartment.text.text(
            fontSize: 16,
            fontColor:
                selectedDepartment.id != null ? Colors.black : greyTextColor,
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
    );
  }

  _positionDropDownItem(MenuItem selectedPosition) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          selectedPosition.text.text(
            fontSize: 16,
            fontColor:
                selectedPosition.id != null ? Colors.black : greyTextColor,
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
    );
  }
}
