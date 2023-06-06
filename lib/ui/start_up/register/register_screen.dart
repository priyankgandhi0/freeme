import 'package:flutter/material.dart';

import 'package:freeme/globle.dart';
import 'package:freeme/ui/start_up/register/register_controller.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(initState: (initState) {
      controller.getAllIndustry(context);
    }, builder: (ctrl) {
      return Stack(
        children: [
          Scaffold(
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
                          top: 10.sh(),

                          ///I have given 10 here and add 30 to singlechild scrollview so 30+10=40
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
                    industryDropDown(context, ctrl),
                    _firstNameLastName(ctrl),
                    _emailAddress(ctrl),
                    passwordField(ctrl),
                    _confirmPassword(ctrl),
                    _signUpButton(context),
                    _dontHaveAccountButton(),
                  ],
                ),
              ).paddingOnly(top: 30.sh()),
            ),
          ),
          ctrl.isLoading ? LoadingStack(() {}) : Container()
        ],
      );
    });
  }

  Widget industryDropDown(BuildContext context, RegisterController ctrl) {
    return Column(
      children: [
        Row(
          children: [
            "Industry".text(fontSize: 16).paddingOnly(
                  left: screenWPadding16.sw(),
                ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          child: GetBuilder<RegisterController>(
            builder: (ctrl) {
              return ListTileTheme(
                dense: true,
                key: UniqueKey(),
                horizontalTitleGap: 0.0,
                minLeadingWidth: 0,
                child: ExpansionTile(
                  childrenPadding: EdgeInsets.zero,
                  title: ctrl.selectedIndustry?.industryName.text(
                        fontSize: 16,
                      ) ??
                      selectIndustry.text(
                        fontSize: 16,
                      ),
                  initiallyExpanded: ctrl.isShowExpanded,
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      controller.isExpanded
                          ? FmImage.assetImage(
                              path: Assets.iconsDownIcon,
                              height: 20.sh(),
                              width: 15.sw(),
                            )
                          : FmImage.assetImage(
                              path: Assets.iconsForwardIcon,
                              height: 15.sh(),
                              width: 8.sw(),
                            )
                    ],
                  ),
                  onExpansionChanged: (value) {
                    value.debugPrint;
                    // controller.expansionChange(value);
                  },
                  children: [
                    Container(
                      width: Get.width,
                      height: 1,
                      color: Colors.black,
                    ),
                    ...ctrl.industryList.map(
                      (e) => expandedChildItem(e.industryName ?? "", context)
                          .onClick(
                        () {
                          ctrl.isShowExpanded = false;
                          ctrl.update();
                          ctrl.onSelectIndustry(e);
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ).paddingOnly(
            left: screenHPadding16.sw(),
            right: screenHPadding16.sw(),
            top: screenHPadding8.sh()),
        ctrl.industryError != null
            ? Row(
                children: [
                  ctrl.industryError
                      .text(
                        fontColor: redColor,
                      )
                      .paddingOnly(
                        left: screenWPadding16.sw(),
                      ),
                ],
              )
            : Container()
      ],
    );
  }

  Widget expandedChildItem(String name, BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: borderGreyColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          name
              .text(
                fontSize: 16,
              )
              .paddingOnly(
                left: screenWPadding16.sw(),
                top: screenHPadding16.sw(),
                bottom: screenHPadding16.sw(),
              ),
        ],
      ),
    );
  }

  _firstNameLastName(RegisterController ctrl) {
    return Row(
      children: [
        Expanded(
          child: FmTextField(
            hint: firstName,
            header: firstName,
            controller: ctrl.firstNameController,
            error: ctrl.firstNameError,
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
            controller: ctrl.lastNameController,
            error: ctrl.lastNameError,
          ).paddingOnly(
            left: 8.sw(),
            right: screenHPadding16.sw(),
            top: 16.sh(),
            bottom: 8.sh(),
          ),
        ),
      ],
    );
  }

  _emailAddress(RegisterController ctrl) {
    return FmTextField(
      hint: enterEmail,
      header: email,
      controller: ctrl.emailController,
      inputType: TextInputType.emailAddress,
      error: ctrl.emailError,
    ).paddingOnly(
      left: screenHPadding16.sw(),
      right: screenHPadding16.sw(),
      top: 8.sh(),
      bottom: 8.sh(),
    );
  }

  passwordField(RegisterController ctrl) {
    return FmTextField(
      hint: enterPassword,
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

  _confirmPassword(RegisterController ctrl) {
    return FmTextField(
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

  _signUpButton(BuildContext context) {
    return FmButton(
      ontap: () {
        controller.performRegister(context);
      },
      name: signUp,
    ).paddingOnly(
      top: 48.sh(),
      left: screenHPadding16.sw(),
      right: screenHPadding16.sw(),
    );
  }

  _dontHaveAccountButton() {
    return Row(
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
            .onTap(() {
          Get.offAllNamed(Routes.login);
        }),
      ],
    ).paddingOnly(top: 24.sh(), bottom: 35.sh());
  }
}
