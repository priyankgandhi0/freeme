import 'package:flutter/material.dart';
import 'package:freeme/utils/extension.dart';
import 'package:get/get.dart';

import '../../../../constant/app_string.dart';
import '../../../../constant/space_constant.dart';
import '../../../../theme/app_colors.dart';
import '../../../widgets/fm_appbar.dart';
import '../../../widgets/fm_button.dart';
import '../../../widgets/fm_textfield.dart';
import 'change_password_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);

  final controller = Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: backGroundWhiteColor,
        appBar: fMAppBar(changePassword, onBackClick: () {
          Navigator.of(context).pop();
        }),
        body: GetBuilder<ChangePasswordController>(
          builder: (ctrl) {
            return Column(
              children: [
                _oldPassword(ctrl),
                _newPassword(ctrl),
                _confirmPassword(ctrl),
                _changeButton(ctrl, context)
              ],
            ).paddingOnly(
              left: screenWPadding16.sw(),
              right: screenWPadding16.sw(),
            );
          },
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }

  Widget _oldPassword(ChangePasswordController ctrl) {
    return FmTextField(
      focusNode: FocusNode(),
      hint: oldPassword,
      inputType: TextInputType.emailAddress,
      controller: ctrl.oldPasswordController,
      radius: 10,
      error: ctrl.oldPasswordError,
    ).paddingOnly(
      top: 24.sh(),
    );
  }

  Widget _newPassword(ChangePasswordController ctrl) {
    return FmTextField(
      focusNode: FocusNode(),
      hint: newPassword,
      inputType: TextInputType.emailAddress,
      radius: 10,
      controller: ctrl.newPasswordController,
      error: ctrl.newPasswordError,
    ).paddingOnly(
      top: screenHPadding16.sh(),
    );
  }

  Widget _confirmPassword(ChangePasswordController ctrl) {
    return FmTextField(
      focusNode: FocusNode(),
      hint: confirmPassword,
      inputType: TextInputType.emailAddress,
      controller: ctrl.confirmPasswordController,
      radius: 10,
      error: ctrl.confirmPasswordError,
    ).paddingOnly(
      top: screenHPadding16.sh(),
    );
  }

  Widget _changeButton(ChangePasswordController ctrl, BuildContext context) {
    return FmButton(
      ontap: () {
        ctrl.changeButton(context);
      },
      name: change,
    ).paddingOnly(top: 56);
  }
}
