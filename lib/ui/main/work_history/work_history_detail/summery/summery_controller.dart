import 'package:flutter/material.dart';

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
}
