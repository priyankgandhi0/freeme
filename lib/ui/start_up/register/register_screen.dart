import 'package:flutter/material.dart';

import 'package:freeme/globle.dart';
import 'package:freeme/ui/start_up/register/register_controller.dart';

import '../../widgets/auth_background.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(builder: (ctrl) {
      return Scaffold(
        backgroundColor: backGroundGreenColor,
        body: AuthBackGround(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Row(),
                helloThere
                    .text(
                      weight: FontWeight.w500,
                      fontSize: 24,
                    )
                    .paddingOnly(
                      top: 40.sh(),
                    ),
                toAccessAllFeatures
                    .text(
                      weight: FontWeight.normal,
                      fontColor: greyTextColor,
                      fontSize: 16,
                    )
                    .paddingOnly(
                      top: 8.sh(),
                    ),
                industryDropDown(),
                Row(
                  children: [
                    Expanded(
                      child: FmTextField(
                        hint: firstName,
                        header: firstName,
                      ).paddingOnly(
                        left: 16.sw(),
                        right: 8.sw(),
                        top: 16.sh(),
                        bottom: 8.sh(),
                      ),
                    ),
                    Expanded(
                      child: FmTextField(
                        hint: lastName,
                        header: lastName,
                      ).paddingOnly(
                        left: 8.sw(),
                        right: screenHPadding16.sw(),
                        top: 16.sh(),
                        bottom: 8.sh(),
                      ),
                    ),
                  ],
                ),
                FmTextField(
                  hint: enterEmail,
                  header: email,
                  inputType: TextInputType.emailAddress,
                ).paddingOnly(
                  left: screenHPadding16.sw(),
                  right: screenHPadding16.sw(),
                  top: 8.sh(),
                  bottom: 8.sh(),
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
                  top: 8.sh(),
                  bottom: 8.sh(),
                ),
                FmTextField(
                        hint: enterConfirmPassword,
                        header: confirmPassword,
                        inputType: TextInputType.visiblePassword,
                        obSecureText: !ctrl.showConfirmPassword,
                        sufixIcon: FmImage.assetImage(
                          path: ctrl.showConfirmPassword
                              ? Assets.iconsEyeOpened
                              : Assets.iconsEyeClosed,
                          width: 22,
                          height: 19,
                        ).onClick(() {
                          ctrl.showHideConfirmPassword();
                        }).paddingOnly(right: 17.sw()))
                    .paddingOnly(
                  left: screenHPadding16.sw(),
                  right: screenHPadding16.sw(),
                  top: 8.sh(),
                  bottom: 8.sh(),
                ),
                FmButton(
                  ontap: () {},
                  name: signUp,
                ).paddingOnly(
                  top: 48.sh(),
                  left: screenHPadding16.sw(),
                  right: screenHPadding16.sw(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    haveAnAccount.text(
                      weight: FontWeight.normal,
                      fontColor: textBlackColor,
                      fontSize: 16,
                    ),
                    logIn
                        .text(
                      weight: FontWeight.normal,
                      fontColor: darkGreenColor,
                      underLine: true,
                      fontSize: 16,
                    )
                        .onClick(() {
                      Get.offAllNamed(Routes.login);
                    }),
                  ],
                ).paddingOnly(top: 24),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget industryDropDown() {
    return Column(
      children: [
        Row(
          children: [
            industry
                .text(
                  weight: FontWeight.normal,
                  fontColor: Colors.black,
                  fontSize: 16,
                )
                .paddingOnly(
                  top: 8.sh(),
                ),
          ],
        ).paddingOnly(bottom: 8.sh()),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
          height: 45.sh(),
          width: Get.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              "Film Industry"
                  .text(
                    weight: FontWeight.normal,
                    fontColor: Colors.black,
                    fontSize: 16,
                  )
                  .paddingOnly(
                    left: screenHPadding16.sw(),
                  ),
              const Icon(
                Icons.keyboard_arrow_down,
              ).paddingOnly(
                right: screenHPadding16.sw(),
              )
            ],
          ),
        )
      ],
    ).paddingOnly(
      left: screenHPadding16.sw(),
      right: screenHPadding16.sw(),
    );
  }
}
