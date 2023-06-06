import 'package:flutter/material.dart';
import 'package:freeme/ui/widgets/fm_dialog.dart';
import 'package:freeme/utils/extension.dart';
import 'package:get/get.dart';

import '../../../../constant/app_string.dart';
import '../../../../constant/space_constant.dart';
import '../../../../generated/assets.dart';
import '../../../../theme/app_colors.dart';
import '../../../../utils/route_manager.dart';
import '../../../widgets/fm_appbar.dart';
import '../../../widgets/fm_button.dart';
import '../../../widgets/fm_image.dart';
import 'account_setting_controller.dart';

class AccountSettingScreen extends StatelessWidget {
  AccountSettingScreen({Key? key}) : super(key: key);

  final controller = Get.put(AccountSettingController());

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
                    buttonName: changePassword,
                    path: Assets.iconsEyeClosedGreen)
                .onTap(
              () {
                Navigator.pushNamed(context, Routes.changePasswordScreen);
              },
            ),
            _iconButton(
                buttonName: privacyPolicy, path: Assets.iconsPrivacyPolicyIcon),
            _iconButton(
                buttonName: termsAndCondition,
                path: Assets.iconsTermsAndConditionIcon),
            _iconButton(buttonName: logout, path: Assets.iconsLogout).onTap(() {
              openLogoutDialog(context);
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

  void openLogoutDialog(BuildContext context) {
    fMDialog(
      context: context,
      horizontalPadding: screenWPadding32.sw(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  logout
                      .text(
                        fontSize: 18,
                        weight: FontWeight.w500,
                      )
                      .paddingOnly(
                        top: screenHPadding16.sh(),
                        bottom: screenHPadding8.sh(),
                      ),
                ],
              ),
              FmImage.assetImage(
                path: Assets.iconsCloseIcon,
                fit: BoxFit.fill,
                size: 12,
              )
                  .paddingOnly(
                top: 20.sh(),
                right: screenWPadding16.sw(),
                left: screenWPadding16.sw(),
                bottom: screenWPadding16.sw(),
              )
                  .onTap(
                () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ).positioned(right: 0)
            ],
          ),
          Container(
            color: bottomLineGreyColor,
            width: Get.width,
            height: 1,
          ),
          areYouSureYouWantLogout
              .text(fontSize: 18, weight: FontWeight.w500)
              .paddingOnly(
                left: 16,
                right: 16,
                top: 32,
                bottom: 32,
              ),
          Row(
            children: [
              Expanded(
                  child: FmButton(
                ontap: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                name: cancel,
              ).paddingAll(8)),
              Expanded(
                child: FmButton(
                  ontap: () {
                    Navigator.of(context, rootNavigator: true).pop();
                     controller.performLogout(context);
                  },
                  name: logout,
                ).paddingAll(8),
              )
            ],
          ).paddingOnly(
            bottom: 24.sw(),
          )
        ],
      ),
    );
  }
}
