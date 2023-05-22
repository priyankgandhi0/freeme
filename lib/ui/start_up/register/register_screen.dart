import 'package:flutter/material.dart';
import 'package:freeme/globle.dart';
import 'package:freeme/ui/start_up/register/register_controller.dart';

import '../../widgets/auth_background.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      body: AuthBackGround(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Row(),
              helloThere
                  .text(
                weight: FontWeight.normal,
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
                      right: 16.sw(),
                      top: 16.sh(),
                      bottom: 8.sh(),
                    ),
                  ),
                ],
              ),
              FmTextField(
                hint: enterEmail,
                header: email,
              ).paddingOnly(
                left: 16.sw(),
                right: 16.sw(),
                top: 8.sh(),
                bottom: 8.sh(),
              ),
              FmTextField(
                hint: enterPassword,
                header: password,
              ).paddingOnly(
                left: 16.sw(),
                right: 16.sw(),
                top: 8.sh(),
                bottom: 8.sh(),
              ),
              FmTextField(
                hint: enterConfirmPassword,
                header: confirmPassword,
              ).paddingOnly(
                left: 16.sw(),
                right: 16.sw(),
                top: 8.sh(),
                bottom: 8.sh(),
              ),
              FmButton(
                ontap: () {},
                name: signUp,
                fontSize: 18.sh(),
              ).paddingOnly(
                top: 48.sh(),
                left: 15.sw(),
                right: 15.sw(),
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
                  ).onClick(() {
                    Get.offAllNamed(Routes.login);
                  }),
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

