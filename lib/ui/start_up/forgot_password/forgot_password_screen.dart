import 'package:flutter/material.dart';

import '../../../globle.dart';
import '../../widgets/auth_background.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      body: AuthBackGround(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Row(),
              forgotPassword
                  .text(
                    weight: FontWeight.normal,
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
              ).paddingOnly(
                left: 16.sw(),
                right: 16.sw(),
                top: 16.sh(),
                bottom: 16.sh(),
              ),
              FmButton(
                ontap: () {},
                name: request,
                fontSize: 18.sh(),
              ).paddingOnly(
                top: 48.sh(),
                left: 15.sw(),
                right: 15.sw(),
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
                      .onClick(() {
                    Get.offAllNamed(Routes.login);
                  })
                ],
              ).paddingOnly(top: 24),
              const SizedBox(
                height: 120,
              )
            ],
          ),
        ),
      ),
    );
  }
}
