import 'package:flutter/material.dart';

import '../../../../globle.dart';

class HistoryDetailController extends GetxController  with GetSingleTickerProviderStateMixin {

  late TabController tabController;
  var tabIndex = 0.obs;
  @override
  void onInit() {
    tabController = TabController(vsync: this, length: 4);
    tabController.addListener(() {
      tabIndex.value = tabController.index;
    });
    super.onInit();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}