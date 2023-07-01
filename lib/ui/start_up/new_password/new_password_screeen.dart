import 'package:flutter/material.dart';
import '../../../globle.dart';
import 'new_password_controller.dart';

class NewPasswordScreen extends StatelessWidget {
  NewPasswordScreen({Key? key}) : super(key: key);

  final controller = Get.put(NewPasswordController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewPasswordController>(
      builder: (ctrl) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: backGroundGreenColor,
              body: AuthBackGround(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Row(),
                      enterNewPasswordTitle
                          .text(
                        weight: FontWeight.w500,
                        fontSize: 24,
                      )
                          .paddingOnly(
                        top: 40.sh(),
                      ),
                      addNewPasswordAndVerifyCode
                          .text(
                        weight: FontWeight.normal,
                        fontColor: greyTextColor,
                        fontSize: 16,
                      )
                          .paddingOnly(
                        top: 8.sh(),
                      ),
                      _verificationCode(ctrl),
                      _passwordField(ctrl),
                      _confirmPassword(ctrl),
                      _signUpButton(context)
                    ],
                  ),
                ),
              ),
            ),
            ctrl.isLoading ? LoadingStack(() {}) : Container()
          ],
        );
      },
    );
  }
  _signUpButton(BuildContext context) {
    return FmButton(
      ontap: () {
        controller.changePassword(context);
      },
      name: changePassword,
    ).paddingOnly(
      top: 48.sh(),
      left: screenHPadding16.sw(),
      right: screenHPadding16.sw(),
    );
  }

  _passwordField(NewPasswordController ctrl) {
    return FmTextField(
      focusNode: FocusNode(),
      hint: enterNewPasswordTitle,
      header: password,
      inputType: TextInputType.visiblePassword,
      controller: ctrl.passwordController,
      error: ctrl.passwordError,
      obSecureText: !ctrl.showPassword,
      sufixIcon: FmImage.assetImage(
        path: ctrl.showPassword ? Assets.iconsEyeOpened : Assets.iconsEyeClosed,
        width: 22,
        height: 19,
      ).onTap(() {
        ctrl.showHidePassword();
      }).paddingOnly(
        right: 17.sw(),
      ),
    ).paddingOnly(
      left: screenHPadding16.sw(),
      right: screenHPadding16.sw(),
      top: 8.sh(),
      bottom: 8.sh(),
    );
  }

  _confirmPassword(NewPasswordController ctrl) {
    return FmTextField(
        focusNode: FocusNode(),
        hint: enterConfirmPassword,
        header: confirmPassword,
        controller: ctrl.confirmPasswordController,
        inputType: TextInputType.visiblePassword,
        error: ctrl.confirmPasswordError,
        obSecureText: !ctrl.showConfirmPassword,
        sufixIcon: FmImage.assetImage(
          path: ctrl.showConfirmPassword
              ? Assets.iconsEyeOpened
              : Assets.iconsEyeClosed,
          width: 22,
          height: 19,
        ).onTap(() {
          ctrl.showHideConfirmPassword();
        }).paddingOnly(right: 17.sw()))
        .paddingOnly(
      left: screenHPadding16.sw(),
      right: screenHPadding16.sw(),
      top: 8.sh(),
      bottom: 8.sh(),
    );
  }

  _verificationCode(NewPasswordController ctrl) {
    return FmTextField(
      focusNode: FocusNode(),
      hint: enterVerificationCode,
      header: verificationCode,
      controller: ctrl.verificationCodeController,
      error: ctrl.verificationError,
    ).paddingOnly(
      left: screenHPadding16.sw(),
      right: screenHPadding16.sw(),
      top: 8.sh(),
      bottom: 8.sh(),
    );
  }
}
