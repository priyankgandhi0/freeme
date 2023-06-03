import 'package:flutter/material.dart';
import 'package:freeme/globle.dart';

class RegisterController extends GetxController{
  bool showPassword = false;
  bool showConfirmPassword = false;
  bool isShowExpanded = false;

  void showHidePassword() {
    showPassword = !showPassword;
    update();
  }
  void showHideConfirmPassword() {
    showConfirmPassword = !showConfirmPassword;
    update();
  }

  bool isExpanded = false;

  ExpansionTileController expansionController = ExpansionTileController();

  void expansionChange(bool value) {
    isExpanded = value;
    update();
  }


}