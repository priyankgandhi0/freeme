import 'package:flutter/cupertino.dart';
import 'package:freeme/ui/widgets/fm_snack.dart';

import '../../../api/repositories/auth_repo.dart';
import '../../../api/response_item.dart';
import '../../../globle.dart';
import '../../../models/user_login_model.dart';
import '../../../utils/app_constant.dart';

class LoginController extends GetxController {
  bool showPassword = false;

  void showHidePassword() {
    showPassword = !showPassword;
    update();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  startLoading() {
    isLoading = true;
    update();
  }

  stopLoading() {
    isLoading = false;
    update();
  }

  Future<void> performLogin(BuildContext context) async {
    if (_isValidate()) {
      startLoading();
      ResponseItem response = await AuthRepo.userLogin(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (response.status) {
        UserModel responseData = UserModel.fromJson(response.data);
        await setupLoginData(responseData);
        stopLoading();
        Get.toNamed(Routes.mainScreen);
      } else {
        response.message.errorSnack(context);
        stopLoading();
      }
    }
  }

  String? emailError;
  String? passwordError;

  bool _isValidate() {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        (!emailController.text.trim().isEmail)) {
      if (emailController.text.trim().isEmpty) {
        emailError = "Please e-mail";
      } else {
        if (!emailController.text.trim().isEmail) {
          emailError = "Enter Valid e-mail";
        } else {
          emailError = null;
        }
      }
      if (passwordController.text.trim().isEmpty) {
        passwordError = "Enter password";
      } else {
        passwordError = null;
      }
      update();
      return false;
    }
    emailError = null;
    passwordError = null;
    update();
    return true;
  }

  Future<void> setupLoginData(UserModel responseData) async {
    await box.write(AppConstant.authToken, responseData.authToken);
    await box.write(AppConstant.isLogin, true);
    await box.write(AppConstant.userProfile, responseData.toJson());
  }
}
