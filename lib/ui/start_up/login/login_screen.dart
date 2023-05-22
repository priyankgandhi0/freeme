import 'package:flutter/material.dart';
import 'package:freeme/globle.dart';

import '../../../constant/app_string.dart';
import '../../../theme/app_colors.dart';
import '../../widgets/auth_background.dart';
import '../../widgets/fm_text.dart';
import '../../widgets/fm_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      body: AuthBackGround(
        child:  Column(
          children: [
            const Row(),
            FmText(
              welcomeBack,
              weight: FontWeight.normal,
              fontSize: 30,
            ).paddingOnly(
              top: 40.sh(),
            ),
            FmText(
              loginToContinue,
              weight: FontWeight.normal,
              fontColor: greyTextColor,
              fontSize: 22,
            ).paddingOnly(
              top: 8.sh(),
            ),
            FmTextField()
          ],
        ),
      ),
    );
  }
}
