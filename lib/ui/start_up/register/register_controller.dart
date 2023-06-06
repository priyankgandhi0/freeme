import 'package:flutter/material.dart';
import 'package:freeme/globle.dart';
import 'package:freeme/ui/widgets/fm_snack.dart';

import '../../../api/repositories/auth_repo.dart';
import '../../../api/response_item.dart';
import '../../../models/industry_model.dart';
import '../../../models/user_login_model.dart';
import '../../../utils/app_constant.dart';

class RegisterController extends GetxController {
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

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isLoading = false;

  startLoading() {
    isLoading = true;
    update();
  }

  stopLoading() {
    isLoading = false;
    update();
  }

  List<IndustryModel> industryList = [];

  Future<void> getAllIndustry(BuildContext context) async {
    startLoading();
    ResponseItem response = await AuthRepo.getAllIndustry();
    if (response.status) {
      industryList.clear();
      industryList.addAll(
        allIndustryList(response.data),
      );
      stopLoading();
    } else {
      response.message.errorSnack(context);
      stopLoading();
    }
  }

  Future<void> performRegister(BuildContext context) async {
    if (_isValidate()) {
      startLoading();
      ResponseItem response = await AuthRepo.userRegister(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        industryId: selectedIndustry?.industryId.toString(),
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
  String? confirmPasswordError;
  String? firstNameError;
  String? lastNameError;
  String? industryError;

  bool _isValidate() {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty ||
        confirmPasswordController.text.trim().isEmpty ||
        firstNameController.text.trim().isEmpty ||
        lastNameController.text.trim().isEmpty ||
        selectedIndustry == null ||
        (confirmPasswordController.text.trim() !=
            passwordController.text.trim()) ||
        (!emailController.text.trim().isEmail)) {
      if (emailController.text.trim().isEmpty) {
        emailError = "Please Enter Email";
      } else {
        if (!emailController.text.trim().isEmail) {
          emailError = "Please Enter Valid Email";
        } else {
          emailError = null;
        }
      }
      if (passwordController.text.trim().isEmpty) {
        passwordError = "Please Enter Password";
      } else {
        passwordError = null;
      }

      if (confirmPasswordController.text.trim().isEmpty) {
        confirmPasswordError = "Please Enter Confirm Password";
      } else {
        if (confirmPasswordController.text.trim() !=
            passwordController.text.trim()) {
          confirmPasswordError = "Enter confirm password same as password";
        } else {
          confirmPasswordError = null;
        }
      }

      if (selectedIndustry == null) {
        industryError = "Please Select Industry";
      } else {
        industryError = null;
      }
      if (firstNameController.text.trim().isEmpty) {
        firstNameError = "Please Enter Firstname";
      } else {
        firstNameError = null;
      }
      if (lastNameController.text.trim().isEmpty) {
        lastNameError = "Please Enter Lastname";
      } else {
        lastNameError = null;
      }
      update();
      return false;
    }
    emailError = null;
    passwordError = null;
    confirmPasswordError = null;
    firstNameError = null;
    lastNameError = null;
    industryError = null;
    update();
    return true;
  }

  IndustryModel? selectedIndustry;

  void onSelectIndustry(IndustryModel e) {
    selectedIndustry = e;
    update();
  }

  clearAllData() {
    selectedIndustry = null;
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    emailError = null;
    passwordError = null;
    confirmPasswordError = null;
    firstNameError = null;
    lastNameError = null;
    industryError = null;
  }

  setupLoginData(UserModel responseData) async {
    await box.write(AppConstant.authToken, responseData.authToken);
    await box.write(AppConstant.isLogin, true);
    await box.write(AppConstant.userProfile, responseData.toJson());
  }
}
