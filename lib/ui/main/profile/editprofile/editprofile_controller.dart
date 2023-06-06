import 'package:flutter/cupertino.dart';
import 'package:freeme/api/api_globle.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../api/repositories/profile_repo.dart';
import '../../../../globle.dart';
import '../../../../models/user_login_model.dart';
import '../../../../utils/app_constant.dart';
import '../../navigator/main_controller.dart';
import '../account/account_controller.dart';
import '../myprofile/myprofile_controller.dart';

class EditProfileController extends GetxController {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;

  UserModel? userModel;

  @override
  void onInit() {
    setDefaultData();
    super.onInit();
  }

  void setDefaultData() {
    userModel = UserModel.fromJson(box.read(AppConstant.userProfile) ?? "");
    firstNameController =
        TextEditingController(text: userModel?.firstName ?? "");
    lastNameController = TextEditingController(text: userModel?.lastName ?? "");
  }

  startLoading() {
    Get.find<HomeController>().startLoading();
  }

  stopLoading() {
    Get.find<HomeController>().stopLoading();
  }

  Future<void> performSaveButton(BuildContext context) async {
    ResponseItem response = await ProfileRepo.editProfile(
      profile: selectedImage,
    );
    if (response.status) {
      UserModel responseData = UserModel.fromJson(response.data);
      await setupLoginData(responseData);
      stopLoading();
      Get.toNamed(Routes.mainScreen);
    } else {
      response.message.errorSnack(context);
      stopLoading();
    }
  }

  setupLoginData(UserModel userModel) async {
    await box.write(AppConstant.authToken, userModel.authToken);
    await box.write(AppConstant.userProfile, userModel.toJson());
    setDefaultData();
    try {
      Get.find<MyProfileController>().onInit();
      Get.find<MyProfileController>().update();
      Get.find<AccountController>().onInit();
      Get.find<AccountController>().update();
    } catch (e) {
      e.debugPrint;
    }
    update();
  }

  String? selectedImage;

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    selectedImage = image?.path;
  }
}
