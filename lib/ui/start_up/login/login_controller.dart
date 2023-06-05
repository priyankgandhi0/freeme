import 'package:flutter/cupertino.dart';

import '../../../api/repositories/auth_repo.dart';
import '../../../api/response_item.dart';
import '../../../globle.dart';
import '../../../models/user_login_model.dart';

class LoginController extends GetxController {
  bool showPassword = false;

  void showHidePassword() {
    showPassword = !showPassword;
    update();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  startLoading(){
    isLoading = true;
    update();
  }

  stopLoading(){
    isLoading = false;
    update();
  }

  Future<void> performLogin() async {
    startLoading();
    ResponseItem response = await AuthRepo.userLogin(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    if (response.status) {
      UserLoginModel responseData = UserLoginModel.fromJson(response.data);
      stopLoading();
      Get.toNamed(Routes.mainScreen);
    } else {
      stopLoading();
    }
  }
}
