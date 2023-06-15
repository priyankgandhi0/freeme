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
  late TextEditingController aboutMeController;

  late TextEditingController addPhoneController;
  late TextEditingController addEmailController;
  late TextEditingController addUnionController;
  late TextEditingController addPrimaryPositionController;
  late TextEditingController addAddressController;
  late TextEditingController addWebsiteController;
  late TextEditingController addSocialMediaController;
  late TextEditingController addBirthDayController;

  UserModel? userModel;

  @override
  void onInit() {
    setDefaultData();
    super.onInit();
  }

  void setDefaultData() {
    userModel = UserModel.fromJson(box.read(AppConstant.userProfile) ?? "");
    firstNameController = TextEditingController(text: userModel?.firstName ?? "");
    lastNameController = TextEditingController(text: userModel?.lastName ?? "");
    aboutMeController = TextEditingController();
    addPhoneController = TextEditingController();
    addEmailController = TextEditingController();
    addUnionController = TextEditingController();
    addPrimaryPositionController = TextEditingController();
    addAddressController = TextEditingController();
    addWebsiteController = TextEditingController();
    addSocialMediaController = TextEditingController();
    addBirthDayController = TextEditingController();
  }

  startLoading() {
    Get.find<HomeController>().startLoading();
  }

  stopLoading() {
    Get.find<HomeController>().stopLoading();
  }

  Future<void> performSaveButton(BuildContext context) async {
    startLoading();
    ResponseItem response = await ProfileRepo.editProfile(
      profile: selectedImage,
      firstName: firstNameController.text.toString(),
      lastName: lastNameController.text.toString(),
      about: aboutMeController.text.toString(),
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
    if(image?.path!=null){
      selectedImage = image?.path;
    }
  }


  List<TextEditingController> phoneList = [];
  List<TextEditingController> emailList = [];
  List<TextEditingController> birthDayList = [];
  List<TextEditingController> socialMediaList = [];
  List<TextEditingController> addWebsite = [];
  List<TextEditingController> addAddress = [];

}
