import 'package:flutter/material.dart';
import 'package:freeme/api/api_globle.dart';

import '../../../globle.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();

  bool isLoading = false;

  startLoading() {
    isLoading = true;
    update();
  }

  stopLoading() {
    isLoading = false;
    update();
  }

  Future<void> performForgotPassword(BuildContext context) async {
    if (_isValidate()) {
      startLoading();
      ResponseItem response = await AuthRepo.forgotPassword(
        email: emailController.text.trim(),
      );
      if (response.status && response.isEmailSent) {
        stopLoading();
        Get.toNamed(
          Routes.newPassword,
          arguments: {
            "emailAddress": emailController.text.trim().toString(),
          },
        );
      } else {
        response.message.errorSnack(context);
        stopLoading();
      }
    }
  }

  String? emailError;

  bool _isValidate() {
    if (emailController.text.trim().isEmpty ||
        (!emailController.text.trim().isEmail)) {
      if (emailController.text.trim().isEmpty) {
        emailError = "Enter e-mail";
      } else {
        if (!emailController.text.trim().isEmail) {
          emailError = "Enter Valid e-mail";
        } else {
          emailError = null;
        }
      }
      update();
      return false;
    }
    emailError = null;
    update();
    return true;
  }
}
