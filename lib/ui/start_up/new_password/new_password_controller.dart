import 'package:flutter/material.dart';
import 'package:freeme/api/api_globle.dart';

import '../../../globle.dart';

class NewPasswordController extends GetxController {
  TextEditingController verificationCodeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String? emailAddress;

  @override
  void onInit() {
    emailAddress = Get.arguments["emailAddress"];
    super.onInit();
  }

  bool isLoading = false;

  startLoading() {
    isLoading = true;
    update();
  }

  stopLoading() {
    isLoading = false;
    update();
  }

  bool showPassword = false;
  bool showConfirmPassword = false;

  void showHidePassword() {
    showPassword = !showPassword;
    update();
  }

  void showHideConfirmPassword() {
    showConfirmPassword = !showConfirmPassword;
    update();
  }

  String? passwordError;
  String? confirmPasswordError;
  String? verificationError;

  Future<void> changePassword(BuildContext context) async {
    if (_isValidate()) {
      startLoading();
      ResponseItem response = await AuthRepo.changePassword(
        email: emailAddress,
        verifyCode: verificationCodeController.text.trim(),
        password: confirmPasswordController.text.trim()
      );
      if (response.status) {
        stopLoading();
        clearChangePassword();
        response.message.successSnack(context);
        Get.offAllNamed(Routes.login);
      } else {
        response.message.errorSnack(context);
        stopLoading();
      }
    }
  }
  
  clearChangePassword(){
    verificationCodeController.clear();
    passwordController.clear();
    confirmPasswordController.clear();

  }

  bool _isValidate() {
    if (verificationCodeController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        passwordController.text.trim() !=
            confirmPasswordController.text.trim()) {
      if (verificationCodeController.text.trim().isEmpty) {
        verificationError = "Please Verification code";
      } else {
        verificationError = null;
      }
      if (passwordController.text.trim().isEmpty) {
        passwordError = "Please Enter Password";
      } else {
        passwordError = null;
      }
      if (confirmPasswordController.text.trim().isEmpty) {
        confirmPasswordError = "Please Enter Confirm Password";
      } else {
        if (passwordController.text.trim() !=
            confirmPasswordController.text.trim()) {
          confirmPasswordError = "confirm password should same as password";
        } else {
          confirmPasswordError = null;
        }
      }
      update();
      return false;
    }
    verificationError = null;
    passwordError = null;
    confirmPasswordError = null;
    update();
    return true;
  }
}
