import 'package:flutter/material.dart';
import 'package:freeme/globle.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      body: AuthBackGround(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Row(),
              welcomeBack
                  .text(
                    weight: FontWeight.normal,
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
              ).paddingOnly(
                left: 16.sw(),
                right: 16.sw(),
                top: 16.sh(),
                bottom: 16.sh(),
              ),
              FmTextField(
                hint: enterPassword,
                header: password,
              ).paddingOnly(
                left: 16.sw(),
                right: 16.sw(),
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
                ontap: () {},
                name: logIn,
                fontSize: 18.sh(),
              ).paddingOnly(
                top: 48.sh(),
                left: 15.sw(),
                right: 15.sw(),
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

class DemoScreeen extends StatelessWidget {
  const DemoScreeen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: Column(
          children: [],
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
