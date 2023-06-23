import 'package:flutter/material.dart';

import 'package:freeme/globle.dart';
import 'package:freeme/ui/start_up/register/register_controller.dart';

import '../../widgets/dropdown.dart';

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
            industry.text(fontSize: 16).paddingOnly(
                  left: screenWPadding16.sw(),
                ),
          ],
        ),
        fmDropDown(
          child: _industryDropDownItem(
            guarHours,
            hint: controller.selectedIndustry.text,
            error: ctrl.industryError
          ),
          onDropDownTap: (item) {
            controller.onSelectIndustry(item); //other industry
          },
          items: controller.industryList,
          context: context,
          width: 200
        ),
       /* if (controller.selectedIndustry.text == "other industry") ...[
          FmTextField(
            hint: "Please Enter Industry",
            header: "Industry (Add Manually)",
            controller: ctrl.industryController,
            inputType: TextInputType.text,
            error: ctrl.industryTextFieldError,
          ).paddingOnly(
            left: screenHPadding16.sw(),
            right: screenHPadding16.sw(),
            top: 8.sh(),
          )
        ]*/
      ],
    );
  }

  Widget _industryDropDownItem(String lable,
      {bool showBorder = true,
      String? hint,
      bool showDownIcon = true,
      Color labelColor = Colors.black,
      Widget? customSuffix,
      String? error}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: error != null ? redColor : Colors.black,
        ),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              hint
                  .text(
                    fontColor: Colors.black,
                    fontSize: 16,
                    overFlow: TextOverflow.ellipsis,
                  )
                  .paddingOnly(left: 16),
              showDownIcon
                  ? customSuffix ??
                      FmImage.assetImage(
                        path: Assets.iconsDownIcon,
                        height: 15.sh(),
                        width: 15.sw(),
                        color: Colors.black,
                      ).paddingOnly(
                        right: screenWPadding16.sw(),
                      )
                  : Container()
            ],
          ).paddingOnly(
            top: screenHPadding16.sh(),
            bottom: 16.sh(),
          ),
          if (controller.selectedIndustry.text == "Other") ...[
            Container(
              width: Get.width,
              color: greyTextColor,
              height: 1,
            ),
            FmEmptyTextField(
              hintText: "Enter Your Industry",
              controller: controller.industryController,
              textInputType: TextInputType.text,
            ).paddingOnly(
              left: screenWPadding16.sw(),
              right: screenWPadding16.sw(),
              top: screenHPadding16.sh(),
              bottom: screenHPadding16.sh(),
            )
          ]
        ],
      ),
    ).paddingOnly(
        left: screenHPadding16.sw(),
        right: screenHPadding16.sw(),
        top: screenHPadding8.sh());
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
