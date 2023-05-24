import '../../../globle.dart';

class LoginController extends GetxController{

  bool showPassword = false;

  void showHidePassword() {
    showPassword = !showPassword;
    update();
  }
}