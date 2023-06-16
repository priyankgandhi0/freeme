import 'package:flutter/cupertino.dart';
import 'package:freeme/api/api_globle.dart';
import 'package:get/get.dart';

import '../../../../api/repositories/profile_repo.dart';
import '../../../../api/response_item.dart';
import '../../../../models/user_login_model.dart';
import '../../../../utils/route_manager.dart';
import '../../navigator/main_controller.dart';

class ChangePasswordController extends GetxController {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String? oldPasswordError;
  String? newPasswordError;
  String? confirmPasswordError;

  startLoading() {
    Get.find<HomeController>().startLoading();
  }

  stopLoading() {
    Get.find<HomeController>().stopLoading();
  }

  Future<void> changeButton(BuildContext context) async {
    if (isValidate()) {
      startLoading();
      ResponseItem response = await ProfileRepo.changePassword(
        oldPassword: oldPasswordController.text.trim(),
        newPassword: newPasswordController.text.trim(),
      );
      if (response.status) {
        stopLoading();
        clearTextField();
        Navigator.of(context).pop();
      } else {
        response.message.errorSnack(context);
        stopLoading();
      }
    }
  }

  bool isValidate() {
    if (oldPasswordController.text.isEmpty ||
        newPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty ||
        newPasswordController.text != confirmPasswordController.text) {
      if (oldPasswordController.text.isEmpty) {
        oldPasswordError = "Please Enter Old Password";
      } else {
        oldPasswordError = null;
      }
      if (newPasswordController.text.isEmpty) {
        newPasswordError = "Please Enter New Password";
      } else {
        newPasswordError = null;
      }
      if (confirmPasswordController.text.isEmpty) {
        confirmPasswordError = "Please Enter Confirm Password";
      } else {
        if (newPasswordController.text != confirmPasswordController.text) {
          confirmPasswordError = "Add Confirm Password Same As New Password";
        } else {
          confirmPasswordError = null;
        }
      }
      update();
      return false;
    }
    confirmPasswordError = null;
    newPasswordError = null;
    oldPasswordError = null;
    update();
    return true;
  }

  void clearTextField() {
    oldPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }
}
