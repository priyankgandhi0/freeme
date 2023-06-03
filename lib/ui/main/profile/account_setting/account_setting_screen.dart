import 'package:flutter/material.dart';
import 'package:freeme/utils/extension.dart';
import 'package:get/get.dart';

import '../../../../constant/app_string.dart';
import '../../../../constant/space_constant.dart';
import '../../../../generated/assets.dart';
import '../../../../theme/app_colors.dart';
import '../../../../utils/route_manager.dart';
import '../../../widgets/fm_appbar.dart';
import '../../../widgets/fm_image.dart';

class AccountSettingScreen extends StatelessWidget {
  const AccountSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: backGroundWhiteColor,
        appBar: fMAppBar(accountSetting, onBackClick: () {
          Navigator.of(context).pop();
        }),
        body: Column(
          children: [
            _iconButton(
                    buttonName: "Change Password",
                    path: Assets.iconsEyeClosedGreen)
                .onTap(
              () {
                Navigator.pushNamed(context, Routes.changePasswordScreen);
              },
            ),
            _iconButton(
                buttonName: "Privacy Policy",
                path: Assets.iconsPrivacyPolicyIcon),
            _iconButton(
                buttonName: "Terms and Condition",
                path: Assets.iconsTermsAndConditionIcon),
            _iconButton(
                buttonName: "Log Out",
                path: Assets.iconsLogout).onTap(() {
              Get.offAllNamed(Routes.login);
            }),
          ],
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }

  Widget _iconButton({
    String? buttonName,
    required String path,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Row(
            children: [
              FmImage.assetImage(
                path: path,
                height: 20.sh(),
                width: 20.sw(),
              ),
              buttonName
                  .text(
                    fontSize: 16,
                  )
                  .paddingOnly(
                    left: screenWPadding16.sw(),
                  ),
            ],
          ).paddingOnly(
            left: screenWPadding16.sw(),
            top: 12.sh(),
            bottom: 12.sh(),
          ),
          Expanded(
            child: Container(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FmImage.assetImage(
                path: Assets.iconsForwardIcon,
                height: 17.sh(),
                width: 17.sw(),
              )
            ],
          ).paddingOnly(
            right: screenWPadding16.sw(),
            top: screenWPadding16.sw(),
            bottom: screenWPadding16.sw(),
          )
        ],
      ),
    ).paddingOnly(
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
      top: screenHPadding16.sh(),
    );
  }
}
