import 'package:flutter/material.dart';
import 'package:freeme/ui/widgets/dropdown.dart';

import '../../../../../api/repositories/job_repo.dart';
import '../../../../../api/response_item.dart';
import '../../../../../globle.dart';
import '../../../../../models/get_job_info_model.dart';
import '../../../../../models/summery_model.dart';
import '../../../navigator/main_controller.dart';

class SummeryController extends GetxController {
  PageController pageController = PageController(initialPage: 0);
  int activatePage = 0;

  void onPageChange(int page) {
    activatePage = page;
    update();
  }

  startLoading() {
    Future.delayed(Duration.zero, () {
      Get.find<HomeController>().startLoading();
    });
  }

  stopLoading() {
    Future.delayed(Duration.zero, () {
      Get.find<HomeController>().stopLoading();
    });
    update();
  }

  SummeryModel? summery;

  Future<void> getSummery(num jobId, String startDate, String endDate) async {
    startLoading();
    ResponseItem response = await JobRepo.getSummary(
      jobId,
      startDate,
      endDate,
    );
    if (response.status) {
      if (response.data != null) {
        summery = SummeryModel.fromJson(
          response.data,
        );
      }
      stopLoading();
    } else {
      stopLoading();
    }
  }

  void clearController() {
    summery = null;
  }

  List<MenuItem> viewDropDownList = [
    MenuItem(text: "Quarters", isSelected: false),
    MenuItem(text: "Tenths", isSelected: true),
  ];

  MenuItem selectedViewDropDownItem =
      MenuItem(text: "Tenths", isSelected: true);

  void onViewDropDownItemTap(MenuItem item) {
    for (int i = 0; i < viewDropDownList.length; i++) {
      if (viewDropDownList[i].text == item.text) {
        if (viewDropDownList[i].isSelected) {
          viewDropDownList[i].isSelected = false;
        } else {
          viewDropDownList[i].isSelected = true;
          selectedViewDropDownItem = viewDropDownList[i];
        }
      } else {
        viewDropDownList[i].isSelected = false;
      }
    }
    update();
  }

  List<MenuItem> incrementDropDownList = [
    MenuItem(text: "Quarters", isSelected: true),
    MenuItem(text: "Tenths", isSelected: false),
    MenuItem(text: "Other", isSelected: false),
  ];


  MenuItem selectedIncrementType = MenuItem(text: "Quarters");

  void onIncrementDropDownTap(MenuItem item) {
    for (int i = 0; i < incrementDropDownList.length; i++) {
      if (incrementDropDownList[i].text == item.text) {
        if (incrementDropDownList[i].isSelected) {
          /* allTypes[i].isSelected = false;
          selectedType = MenuItem(text: "Not Sure");*/
        } else {
          incrementDropDownList[i].isSelected = true;
          selectedIncrementType = incrementDropDownList[i];
        }
      } else {
        incrementDropDownList[i].isSelected = false;
      }
    }
    update(["ExportTimeCardDialog"]);
  }


  List<MenuItem> exportIncrementDropDownList = [
    MenuItem(text: "Quarters", isSelected: true),
    MenuItem(text: "Tenths", isSelected: false),
    MenuItem(text: "Other", isSelected: false),
  ];


  MenuItem selectedExportIncrementDropdown = MenuItem(text: "Quarters");

  void onExportInvoiceIncreamentTap(MenuItem item) {
    for (int i = 0; i < exportIncrementDropDownList.length; i++) {
      if (exportIncrementDropDownList[i].text == item.text) {
        if (exportIncrementDropDownList[i].isSelected) {
          /* allTypes[i].isSelected = false;
          selectedType = MenuItem(text: "Not Sure");*/
        } else {
          exportIncrementDropDownList[i].isSelected = true;
          selectedIncrementType = exportIncrementDropDownList[i];
        }
      } else {
        exportIncrementDropDownList[i].isSelected = false;
      }
    }
    update(["ExportInvoiceDialog"]);
  }
}
