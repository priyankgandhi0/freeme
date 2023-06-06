

import 'package:flutter/src/widgets/framework.dart';
import 'package:freeme/api/api_globle.dart';
import 'package:freeme/utils/app_utils.dart';
import 'package:get/get.dart';

import '../../../../utils/app_constant.dart';
import '../../../../utils/route_manager.dart';
import '../../navigator/main_controller.dart';

class MyProfileController extends GetxController {


  UserModel? userModel;

  @override
  void onInit() {
    userModel = UserModel.fromJson(box.read(AppConstant.userProfile) ?? "");
    super.onInit();
  }


}
