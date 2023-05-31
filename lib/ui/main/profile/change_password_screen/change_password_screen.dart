import 'package:flutter/material.dart';
import 'package:freeme/utils/extension.dart';
import 'package:get/get.dart';

import '../../../../constant/app_string.dart';
import '../../../../constant/space_constant.dart';
import '../../../../theme/app_colors.dart';
import '../../../widgets/fm_appbar.dart';
import '../../../widgets/fm_button.dart';
import '../../../widgets/fm_textfield.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: backGroundWhiteColor,
        appBar: fMAppBar(changePassword, onBackClick: () {
          Navigator.of(context).pop();
        }),
        body: Column(
          children: [
            FmTextField(
              hint: oldPassword,
              inputType: TextInputType.emailAddress,
              radius: 10,
            ).paddingOnly(
              top: 24.sh(),
            ),
            FmTextField(
              hint: newPassword,
              inputType: TextInputType.emailAddress,
              radius: 10,
            ).paddingOnly(
              top: screenHPadding16.sh(),
            ),
            FmTextField(
              hint: confirmPassword,
              inputType: TextInputType.emailAddress,
              radius: 10,
            ).paddingOnly(
              top: screenHPadding16.sh(),
            ),
            FmButton(
              ontap: () {

              },
              name: change,
            ).paddingOnly(top: 56)
          ],
        ).paddingOnly(
          left: screenWPadding16.sw(),
          right: screenWPadding16.sw(),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
