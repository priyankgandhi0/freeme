import 'package:flutter/material.dart';
import 'package:freeme/ui/main/quick_entry/pages/additional_info_page.dart';
import 'package:freeme/ui/main/quick_entry/pages/calender_page.dart';
import 'package:freeme/ui/main/quick_entry/pages/job_classification_page.dart';
import 'package:freeme/ui/main/quick_entry/pages/job_detail_page.dart';
import 'package:freeme/ui/main/quick_entry/pages/payment_detail_page.dart';
import 'package:freeme/ui/main/quick_entry/pages/taxed_item_page.dart';
import 'package:freeme/ui/main/quick_entry/quick_entry_controller.dart';

import '../../../globle.dart';
import '../../widgets/fm_appbar.dart';

class QuickEntryScreen extends StatelessWidget {
  QuickEntryScreen({Key? key}) : super(key: key);

  final controller = Get.put(QuickEntryController());

  var pages = [
    CalenderPage(),
    JobDetailPage(),
    PaymentDetailPage(),
    JobClassificationPage(),
    AdditionalInfoPage(),
    TaxedItemPage()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: GetBuilder<QuickEntryController>(
        builder: (ctrl) {
          return Scaffold(
            appBar: fMAppBar(
              quickEntry,
              onBackClick: () {
                Navigator.of(context).pop();
              },
            ),
            body: Column(
              children: [
                indicator(),
                Expanded(
                  child: PageView.builder(
                    controller: controller.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (int page) {
                      controller.onPageChange(page);
                    },
                    itemCount: 6,
                    itemBuilder: (BuildContext context, int index) {
                      return pages[index];
                    },
                  ),
                )
              ],
            ).safeArea,
          );
        },
      ),
      onWillPop: () async {
        return false;
      },
    );
  }

  Widget indicator() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List<Widget>.generate(
          pages.length,
          (index) => InkWell(
            onTap: () {
              controller.pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: controller.activatePage == index
                    ? darkGreenColor
                    : borderGreyColor,
              ),
              width: 22,
              height: 5,
            ).paddingAll(1),
          ),
        ).toList()
      ],
    ).paddingOnly(
      top: 24.sh(),
      bottom: screenHPadding16.sh(),
    );
  }
}
