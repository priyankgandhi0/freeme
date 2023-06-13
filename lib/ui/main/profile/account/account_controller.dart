import 'package:flutter/material.dart';
import 'package:freeme/api/api_globle.dart';
import '../../../../globle.dart';
import '../../../../utils/app_constant.dart';
import '../../navigator/main_controller.dart';

class AccountController extends GetxController{
  UserModel? userModel;

  @override
  void onInit() {
    userModel = UserModel.fromJson(box.read(AppConstant.userProfile) ?? {});
    super.onInit();
  }


}