import 'package:flutter/material.dart';
import '../../../globle.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              ).paddingOnly(
                left: screenHPadding16.sw(),
                right: screenHPadding16.sw(),
                top: 16.sh(),
                bottom: 16.sh(),
              ),
              FmButton(
                ontap: () {},
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
                  logIn.text(
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
    );
  }
}
