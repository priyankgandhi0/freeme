import 'package:freeme/globle.dart';

class RegisterController extends GetxController{
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
}