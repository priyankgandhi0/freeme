import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:freeme/api/api_globle.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../api/repositories/profile_repo.dart';
import '../../../../api/repositories/quick_entry_repo.dart';
import '../../../../globle.dart';
import '../../../../models/job_classification_model.dart';
import '../../../../models/sub_job_classification_model.dart';
import '../../../../models/user_login_model.dart';
import '../../../../utils/app_constant.dart';
import '../../../widgets/dropdown.dart';
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
    firstNameController =
        TextEditingController(text: userModel?.firstName ?? "");
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

  Future<void> getMyProfile() async {
    ResponseItem response = await QuickEntryRepo.myProfile();
    if (response.status) {
      UserModel responseData = UserModel.fromJson(response.data);
      fillEditProfileData(responseData);
    } else {}
  }

  fillEditProfileData(UserModel user) async {
    firstNameController.text = user.firstName ?? "";
    lastNameController.text = user.lastName ?? "";
    aboutMeController.text = user.about ?? "";
    emailList.clear();
    emailList.addAll(user.email
            ?.map((e) => TextEditingController(text: e.email ?? ""))
            .toList() ??
        []);

    addAddress.clear();
    addAddress.addAll(user.address
            ?.map((e) => TextEditingController(text: e.address ?? ""))
            .toList() ??
        []);

    phoneList.clear();
    phoneList.addAll(user.mobile
            ?.map((e) =>
                TextEditingController(text: (e.mobileNo?.toString() ?? "")))
            .toList() ??
        []);
    addWebsite.clear();
    addWebsite.addAll(user.website
            ?.map((e) =>
                TextEditingController(text: (e.website?.toString() ?? "")))
            .toList() ??
        []);

    birthDayList.clear();
    birthDayList.add(TextEditingController(text: user.birthDate ?? ""));

    /*socialMediaList.clear();
    socialMediaList.addAll(user.socialMedia
        ?.map((e) =>
        TextEditingController(text: (e.website?.toString() ?? "")))
        .toList() ??
        []);*/


    MenuItem? union = unionNonUnionList.firstWhereOrNull((element) => element.text==user.union);
    if(union!=null){
      onUnionNonUnionDropDownTap(union);
    }

    MenuItem? department = allJobClassificationList.firstWhereOrNull((element) => element.id==user.jobClassificationId);
    if(department!=null){
      await onDepartmentTap(department);
      MenuItem? position = allSubJobList.firstWhereOrNull((element) => element.id==user.subJobClassificationsId);
      if(position!=null){
        onPositionTap(position);
      }
    }


  }

  Future<void> performSaveButton(BuildContext context) async {
    startLoading();
    ResponseItem response = await ProfileRepo.editProfile(
      profile: selectedImage,
      firstName: firstNameController.text.toString(),
      lastName: lastNameController.text.toString(),
      about: aboutMeController.text.toString(),
      email: emailList.map((e) => e.text).toList(),
      address: addAddress.map((e) => e.text).toList(),
      mobile: phoneList.map((e) => e.text).toList(),
      website: addWebsite.map((e) => e.text).toList(),
      birthDate: birthDayList.isNotEmpty ? birthDayList[0].text : null,
      department: selectedDepartment.id,
      position: selectedPosition.id,
      union: selectedUnion.text,
      socialMedia: socialMediaList.map((e) => e.text).toList(),
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
    if (image?.path != null) {
      selectedImage = image?.path;
    }
  }

  List<TextEditingController> phoneList = [];
  List<TextEditingController> emailList = [];
  List<TextEditingController> socialMediaList = [];
  List<TextEditingController> addWebsite = [];
  List<TextEditingController> addAddress = [];

  List<TextEditingController> birthDayList = [];

  List<TextEditingController> primaryPosition = [];

  MenuItem selectedUnion = MenuItem(text: "Not Sure", isSelected: true);

  List<MenuItem> unionNonUnionList = [
    MenuItem(text: "Not Sure", isSelected: true),
    MenuItem(text: "Non-Union", isSelected: false),
    MenuItem(text: "Union", isSelected: false),
  ];

  void onUnionNonUnionDropDownTap(MenuItem item) {
    for (int i = 0; i < unionNonUnionList.length; i++) {
      if (unionNonUnionList[i].text == item.text) {
        if (unionNonUnionList[i].isSelected) {
          unionNonUnionList[i].isSelected = false;
        } else {
          unionNonUnionList[i].isSelected = true;
          selectedUnion = unionNonUnionList[i];
        }
      } else {
        unionNonUnionList[i].isSelected = false;
      }
    }
    update();
  }

  bool showUnionSelected = false;
  bool showPrimaryPositionSelected = false;

  void removePrimaryPosition() {
    showPrimaryPositionSelected = false;
    update();
  }

  void addPrimaryPosition() {
    showPrimaryPositionSelected = true;
    update();
  }

  void removeUnionSelection() {
    showUnionSelected = false;
    update();
  }

  void addUnionSelection() {
    showUnionSelected = true;
    update();
  }

  List<MenuItem> allJobClassificationList = [];

  Future<void> getAllJobClassifications() async {
    ResponseItem response = await QuickEntryRepo.allJobClassificationsList();
    if (response.status) {
      allJobClassificationList.clear();
      allJobClassificationList
          .addAll(jobClassificationModelFromJson(response.data)
              .map(
                (e) => MenuItem(
                  text: e.jobClassificationCategory,
                  id: e.jobClassificationId,
                  isSelected: false,
                ),
              )
              .toList());
    } else {}
  }

  MenuItem selectedDepartment = MenuItem(text: "Select Department");

  Future onDepartmentTap(MenuItem item) async{
    for (int i = 0; i < allJobClassificationList.length; i++) {
      if (allJobClassificationList[i].text == item.text) {
        if (allJobClassificationList[i].isSelected) {
          //allJobClassificationList[i].isSelected = false;
          // selectedDepartment = MenuItem(text: "Select Department");
          // allSubJobList.clear();
          // selectedPosition = MenuItem(text: "Select Position");
        } else {
          allJobClassificationList[i].isSelected = true;
          selectedDepartment = allJobClassificationList[i];
          getAllSubJobList(selectedDepartment.id ?? -1);
          selectedPosition = MenuItem(text: "Select Position");
        }
      } else {
        allJobClassificationList[i].isSelected = false;
      }
    }
    update();
  }

  List<MenuItem> allSubJobList = [];

  Future<void> getAllSubJobList(num id) async {
    ResponseItem response =
        await QuickEntryRepo.allSubJobClassificationList(id);
    if (response.status) {
      allSubJobList.clear();
      allSubJobList.addAll(subJobClassificationModelFromJson(response.data)
          .map(
            (e) => MenuItem(
              text: makeStringDoubleLine(e.subJobClassificationsCategory ?? ""),
              id: e.subJobClassificationsId,
              isSelected: false,
            ),
          )
          .toList());
      update();
    } else {}
  }

  MenuItem selectedPosition = MenuItem(text: "Select Position");

  void onPositionTap(MenuItem item) {
    for (int i = 0; i < allSubJobList.length; i++) {
      if (allSubJobList[i].text == item.text) {
        if (allSubJobList[i].isSelected) {
          // allSubJobList[i].isSelected = false;
          // selectedPosition = MenuItem(text: "Select Position");
        } else {
          allSubJobList[i].isSelected = true;
          selectedPosition = allSubJobList[i];
        }
      } else {
        allSubJobList[i].isSelected = false;
      }
    }
    update();
  }
}
