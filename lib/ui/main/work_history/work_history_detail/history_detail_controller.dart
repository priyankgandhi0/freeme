import 'package:flutter/material.dart';

import '../../../../globle.dart';

class HistoryDetailController extends GetxController  with GetSingleTickerProviderStateMixin {

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