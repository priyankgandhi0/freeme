import 'package:flutter/material.dart';
import 'package:freeme/api/api_globle.dart';

import '../../../../globle.dart';
import '../../../../utils/app_constant.dart';
import '../../../../utils/app_utils.dart';
import '../../navigator/main_controller.dart';

class AccountSettingController extends GetxController {


  startLoading() {
    Get.find<HomeController>().startLoading();
  }

  stopLoading() {
    Get.find<HomeController>().stopLoading();
  }

  Future<void> performLogout(BuildContext context) async {
    startLoading();
    ResponseItem response = await AuthRepo.userLogOut();
    if (response.status) {
      await box.erase();
      await AppUtils.putAppDeviceInfo();
      Get.offAllNamed(Routes.login);
    } else {
      response.message.errorSnack(context);
      stopLoading();
    }
  }
}
