import 'package:flutter/material.dart';
import 'package:freeme/globle.dart';
import 'package:freeme/ui/widgets/fm_snack.dart';

import '../../../api/repositories/auth_repo.dart';
import '../../../api/response_item.dart';
import '../../../models/industry_model.dart';
import '../../../models/user_login_model.dart';
import '../../../utils/app_constant.dart';
import '../../widgets/dropdown.dart';

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
  TextEditingController industryController = TextEditingController();
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

  //List<IndustryModel> industryList = [];
  List<MenuItem> industryList = [];

  Future<void> getAllIndustry(BuildContext context) async {
    startLoading();
    ResponseItem response = await AuthRepo.getAllIndustry();
    if (response.status) {
      industryList.clear();
      industryList.addAll(allIndustryList(response.data)
          .map(
            (e) => MenuItem(
                text: e.industryName, id: e.industryId, isSelected: false),
          )
          .toList());
      stopLoading();
    } else {
      response.message.errorSnack(context);
      stopLoading();
    }
  }

  MenuItem selectedIndustry =
      MenuItem(text: "Film Industry", id: 1, isSelected: true);

  void onSelectIndustry(MenuItem item) {
    for (int i = 0; i < industryList.length; i++) {
      if (industryList[i].text == item.text) {
        if (industryList[i].isSelected) {
          /*allGuaranteedHour[i].isSelected = false;
          selectedGuaranteedHour = MenuItem(text: "Not Sure");*/
        } else {
          industryList[i].isSelected = true;
          selectedIndustry = industryList[i];
        }
      } else {
        industryList[i].isSelected = false;
      }
    }
    update();
  }

  Future<void> performRegister(BuildContext context) async {
    if (_isValidate()) {
      startLoading();
      ResponseItem response = await AuthRepo.userRegister(
        firstName: firstNameController.text.trim(),
        industryName: industryController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        industryId: selectedIndustry.id.toString(),
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
  String? industryTextFieldError;

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

      if (industryController.text.isEmpty) {
        industryTextFieldError = "Please Enter Industry";
      } else {
        industryTextFieldError = null;
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
    if (selectedIndustry.text == "other industry") {
      if (industryController.text.isEmpty) {
        industryTextFieldError = "Please Enter Industry";
        update();
        return false;
      }
      industryTextFieldError = null;
      update();
      return true;
    }
    emailError = null;
    passwordError = null;
    confirmPasswordError = null;
    firstNameError = null;
    lastNameError = null;
    industryError = null;
    industryTextFieldError = null;
    update();
    return true;
  }

  clearAllData() {
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
