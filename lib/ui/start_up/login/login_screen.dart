import 'package:flutter/material.dart';
import 'package:freeme/globle.dart';

import 'login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (ctrl) {
        return Scaffold(
          backgroundColor: backGroundGreenColor,
          body: AuthBackGround(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Row(),
                  welcomeBack
                      .text(
                        weight: FontWeight.w500,
                        fontSize: 24,
                      )
                      .paddingOnly(
                        top: 40.sh(),
                      ),
                  loginToContinue
                      .text(
                          weight: FontWeight.normal,
                          fontColor: greyTextColor,
                          fontSize: 18)
                      .paddingOnly(
                        top: 8.sh(),
                      ),
                  FmTextField(
                    hint: enterEmail,
                    header: email,
                    inputType: TextInputType.emailAddress,
                  ).paddingOnly(
                    left: screenHPadding16.sw(),
                    right: screenHPadding16.sw(),
                    top: 16.sh(),
                    bottom: 16.sh(),
                  ),
                  FmTextField(
                    hint: enterPassword,
                    header: password,
                    inputType: TextInputType.visiblePassword,
                    obSecureText: !ctrl.showPassword,
                    sufixIcon: FmImage.assetImage(
                      path: ctrl.showPassword
                          ? Assets.iconsEyeOpened
                          : Assets.iconsEyeClosed,
                      width: 22,
                      height: 19,
                    ).onClick(() {
                      ctrl.showHidePassword();
                    }).paddingOnly(
                      right: 17.sw(),
                    ),
                  ).paddingOnly(
                    left: screenHPadding16.sw(),
                    right: screenHPadding16.sw(),
                    top: 16.sh(),
                    bottom: 16.sh(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      forgotPassword
                          .text(
                        weight: FontWeight.normal,
                        fontColor: Colors.black,
                        fontSize: 16,
                      )
                          .onTap(() {
                        Get.toNamed(Routes.forgotPassword);
                      }).paddingOnly(top: 8.sh(), right: 16.sh()),
                    ],
                  ),
                  FmButton(
                    ontap: () {
                      Get.toNamed(Routes.demoScreen);
                    },
                    name: logIn,
                  ).paddingOnly(
                    top: 48.sh(),
                    left: screenHPadding16.sw(),
                    right: screenHPadding16.sw(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      dontHaveAccount.text(
                        weight: FontWeight.normal,
                        fontColor: textBlackColor,
                        fontSize: 16,
                      ),
                      signUp
                          .text(
                        weight: FontWeight.normal,
                        fontColor: darkGreenColor,
                        fontSize: 16,
                        underLine: true,
                      )
                          .onClick(() {
                        Get.toNamed(Routes.register);
                      }),
                    ],
                  ).paddingOnly(top: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
