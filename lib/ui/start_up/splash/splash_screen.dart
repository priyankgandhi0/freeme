import 'dart:async';

import 'package:flutter/material.dart';
import 'package:freeme/utils/extension.dart';
import 'package:get/get.dart';

import '../../../generated/assets.dart';
import '../../../theme/app_colors.dart';
import '../../../utils/app_constant.dart';
import '../../../utils/route_manager.dart';
import '../../widgets/fm_image.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setUpTimer();
    return Scaffold(
      backgroundColor: backGroundGreenColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FmImage.assetImage(
            path: Assets.iconsAppLogo,
            fit: BoxFit.contain,
          ).paddingOnly(
            left: 72.sw(),
            right: 72.sw(),
          )
        ],
      ),
    );
  }
  Future<void> setUpTimer() async {
    Timer(const Duration(seconds: 2), () async {
      if (box.read(AppConstant.isLogin) ?? false) {
        Get.offAllNamed(Routes.mainScreen);
      } else {
         Get.offAllNamed(Routes.login);
        //Get.toNamed(Routes.mainScreen);
      }
    });
  }
}
