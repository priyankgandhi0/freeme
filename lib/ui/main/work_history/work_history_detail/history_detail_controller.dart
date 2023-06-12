import 'package:flutter/material.dart';

import '../../../../api/repositories/job_repo.dart';
import '../../../../api/response_item.dart';
import '../../../../globle.dart';
import '../../../../models/work_history_model.dart';
import '../../navigator/main_controller.dart';

class HistoryDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  int tabIndex = 0;

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: 4);
    tabController.addListener(() {
      tabIndex = tabController.index;
      update();
    });
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }


}
