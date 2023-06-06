import 'package:flutter/material.dart';
import '../../../globle.dart';
import 'forgot_password_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  final controller = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordController>(
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
                      forgotPassword
                          .text(
                            weight: FontWeight.w500,
                            fontSize: 24,
                          )
                          .paddingOnly(
                            top: 40.sh(),
                          ),
                      provideYourEmail
                          .text(
                            weight: FontWeight.normal,
                            fontColor: greyTextColor,
                            fontSize: 16,
                          )
                          .paddingOnly(
                            top: 8.sh(),
                          ),
                      FmTextField(
                        hint: enterEmail,
                        header: email,
                        inputType: TextInputType.emailAddress,
                        controller: ctrl.emailController,
                        error: ctrl.emailError,
                      ).paddingOnly(
                        left: screenHPadding16.sw(),
                        right: screenHPadding16.sw(),
                        top: 16.sh(),
                        bottom: 16.sh(),
                      ),
                      FmButton(
                        ontap: () {
                          ctrl.performForgotPassword(context);
                        },
                        name: request,
                      ).paddingOnly(
                        top: 48.sh(),
                        left: screenHPadding16.sw(),
                        right: screenHPadding16.sw(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          rememberPassword.text(
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
                          })
                        ],
                      ).paddingOnly(top: 24),
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
}
