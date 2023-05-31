import 'package:flutter/material.dart';

import '../../../../../globle.dart';

class SummeryController extends GetxController {
  PageController pageController = PageController(initialPage: 0);
  int activatePage = 0;

  void onPageChange(int page) {
    activatePage = page;
    update();
  }
}
