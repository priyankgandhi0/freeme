import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:freeme/api/api_globle.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../api/repositories/profile_repo.dart';
import '../../../../api/repositories/quick_entry_repo.dart';
import '../../../../globle.dart';
import '../../../../models/job_classification_model.dart';
import '../../../../models/sub_job_classification_model.dart';
import '../../../../utils/app_constant.dart';
import '../../../widgets/dropdown.dart';
import '../../navigator/main_controller.dart';
import '../account/account_controller.dart';
import '../myprofile/myprofile_controller.dart';

class EditProfileController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  late TextEditingController lastNameController = TextEditingController();
  late TextEditingController aboutMeController = TextEditingController();
  late TextEditingController addPhoneController = TextEditingController();
  late TextEditingController addEmailController = TextEditingController();
  late TextEditingController addUnionController = TextEditingController();
  late TextEditingController addPrimaryPositionController =
      TextEditingController();
  late TextEditingController addAddressController = TextEditingController();
  late TextEditingController addWebsiteController = TextEditingController();
  late TextEditingController addSocialMediaController = TextEditingController();
  late TextEditingController addBirthDayController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  startLoading() {
    Get.find<HomeController>().startLoading();
  }

  stopLoading() {
    Get.find<HomeController>().stopLoading();
  }

  Future<void> getMyProfile() async {
    startLoading();
    ResponseItem response = await QuickEntryRepo.myProfile();
    if (response.status) {
      UserModel responseData = UserModel.fromJson(response.data);
      stopLoading();
      fillEditProfileData(responseData);
    } else {}
  }

  fillEditProfileData(UserModel user) async {
    selectedImage = user.userProfilePhoto;
    firstNameController.text = user.firstName ?? "";
    lastNameController.text = user.lastName ?? "";
    aboutMeController.text = user.about ?? "";
    emailList.clear();
    emailList.addAll(user.email
            ?.map((e) => EditProfileItem(
                e.emailId ?? -1, TextEditingController(text: e.email ?? "")))
            .toList() ??
        []);
    addAddress.clear();
    addAddress.addAll(user.address
            ?.map((e) => EditProfileItem(e.addressId ?? -1,
                TextEditingController(text: e.address ?? "")))
            .toList() ??
        []);
    phoneList.clear();
    phoneList.addAll(user.mobile
            ?.map((e) => EditProfileItem(e.numberId ?? -1,
                TextEditingController(text: (e.mobileNo?.toString() ?? ""))))
            .toList() ??
        []);
    addWebsite.clear();
    addWebsite.addAll(user.website
            ?.map((e) => EditProfileItem(e.websiteId ?? -1,
                TextEditingController(text: (e.website?.toString() ?? ""))))
            .toList() ??
        []);
    birthDayList.clear();
    if(user.birthDate!=null){
      birthDayList.add(
          EditProfileItem(0, TextEditingController(text: user.birthDate ?? "")));
    }

    socialMediaList.clear();
    socialMediaList.addAll(user.socialMedia
        ?.map((e) =>
        EditProfileItem(e.socialMediaId ?? -1, TextEditingController(text: (e.socialMedia?.toString() ?? ""))))
        .toList() ??
        []);
    MenuItem? union = unionNonUnionList
        .firstWhereOrNull((element) => element.text == user.union);
    if (union != null) {
      showUnionSelected = true;
      onUnionNonUnionDropDownTap(union);
    }

    MenuItem? department = allJobClassificationList
        .firstWhereOrNull((element) => element.id == user.jobClassificationId);
    if (department != null) {
      showPrimaryPositionSelected = true;
      await onDepartmentTap(department);
      MenuItem? position = allSubJobList.firstWhereOrNull(
          (element) => element.id == user.subJobClassificationsId);
      if (position != null) {
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
      email: json.encode(
        emailList.map((e) => e.controller.text).toList().toJson("email"),
      ),
      address: json.encode(
        addAddress.map((e) => e.controller.text).toList().toJson("address"),
      ),
      mobile: json.encode(
        phoneList.map((e) => e.controller.text).toList().toJson("mobile"),
      ),
      website: json.encode(
        addWebsite.map((e) => e.controller.text).toList().toJson("website"),
      ),
      socialMedia: json.encode(
        socialMediaList
            .map((e) => e.controller.text)
            .toList()
            .toJson("social_media"),
      ),
      birthDate:
          birthDayList.isNotEmpty ? birthDayList[0].controller.text : null,
      department: selectedDepartment.id,
      position: selectedPosition.id,
      union: selectedUnion.text,
      removeAddress: addressRemoveList.join(","),
      removeEmail: emailRemoveList.join(","),
      removeMobileNumber: phoneRemoveList.join(","),
      removeSocialMedia: socialRemoveMediaList.join(","),
      removeWebsite: websiteRemoveList.join(","),
    );
    if (response.status) {
      UserModel responseData = UserModel.fromJson(response.data);
      await setupLoginData(responseData);
      //await fillEditProfileData(responseData);
      stopLoading();
      clearAllData();
      Navigator.of(context).pop();
    } else {
      response.message.errorSnack(context);
      stopLoading();
    }
  }

  setupLoginData(UserModel userModel) async {
    await box.write(AppConstant.authToken, userModel.authToken);
    await box.write(AppConstant.userProfile, userModel.toJson());
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
      update();
    }
  }

  List<EditProfileItem> phoneList = [];
  List<EditProfileItem> emailList = [];
  List<EditProfileItem> socialMediaList = [];
  List<EditProfileItem> addWebsite = [];
  List<EditProfileItem> addAddress = [];
  List<EditProfileItem> birthDayList = [];

  List<String> phoneRemoveList = [];
  List<String> emailRemoveList = [];
  List<String> socialRemoveMediaList = [];
  List<String> websiteRemoveList = [];
  List<String> addressRemoveList = [];

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
    selectedDepartment =  MenuItem(text: "Select Department",id: 0);
    selectedPosition = MenuItem(text: "Select Position",id: 0);
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

  Future onDepartmentTap(MenuItem item) async {
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
          await getAllSubJobList(selectedDepartment.id ?? -1);
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

  void clearAllData() {
    firstNameController.clear();
    lastNameController.clear();
    aboutMeController.clear();
    emailList.clear();
    addAddress.clear();
    phoneList.clear();
    addWebsite.clear();
    birthDayList.clear();
    socialMediaList.clear();
  }
}

class EditProfileItem {
  num id;
  TextEditingController controller;

  EditProfileItem(this.id, this.controller);
}
