import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:freeme/api/api_globle.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../api/repositories/profile_repo.dart';
import '../../../../api/repositories/quick_entry_repo.dart';
import '../../../../globle.dart';
import '../../../../models/address_request_model.dart';
import '../../../../models/country.dart';
import '../../../../models/job_classification_model.dart';
import '../../../../models/sub_job_classification_model.dart';
import '../../../../models/union_trade_model.dart';
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

    addressControllerList.clear();
    setAddress(user.address ?? []);

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
    if (user.birthDate != null) {
      birthDayList.add(EditProfileItem(
          0, TextEditingController(text: user.birthDate ?? "")));
    }

    socialMediaList.clear();
    socialMediaList.addAll(user.socialMedia
            ?.map((e) => EditProfileItem(e.socialMediaId ?? -1,
                TextEditingController(text: (e.socialMedia?.toString() ?? ""))))
            .toList() ??
        []);

    unionList.addAll((user.union ?? []).map(
      (e) {
        var model = UnionUiModel();
        model.id = e.unionId;
        for (int i = 0; i < allUnionTradeList.length; i++) {
          if (allUnionTradeList[i].text == e.unionTradeTitle) {
            if (allUnionTradeList[i].isSelected) {
              allUnionTradeList[i].isSelected = false;
            } else {
              allUnionTradeList[i].isSelected = true;
              model.selectedUnion = allUnionTradeList[i];
            }
          } else {
            allUnionTradeList[i].isSelected = false;
          }
        }
        return model;
      },
    ));

    /*MenuItem? union = allUnionTradeList
        .firstWhereOrNull((element) => element.text == user.union);
    if (union != null) {
      onUnionTradeDropDownTap(union);
    }*/

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

    update();
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
      address: json.encode(getAddressJson(addressControllerList)),
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
      union: json.encode(
        unionList
            .map((e) => e.selectedUnion.id.toString() ?? "")
            .toList()
            .toJson("union"),
      ),
      removeAddress: addressRemoveList.join(","),
      removeEmail: emailRemoveList.join(","),
      removeMobileNumber: phoneRemoveList.join(","),
      removeSocialMedia: socialRemoveMediaList.join(","),
      removeWebsite: websiteRemoveList.join(","),
      removeUnion: unionRemoveList.join(","),
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
  List<UnionUiModel> unionList = [];
  List<EditProfileItem> socialMediaList = [];
  List<EditProfileItem> addWebsite = [];

  List<EditProfileItem> birthDayList = [];

  List<String> phoneRemoveList = [];
  List<String> emailRemoveList = [];
  List<String> socialRemoveMediaList = [];
  List<String> websiteRemoveList = [];
  List<String> addressRemoveList = [];
  List<String> unionRemoveList = [];

/*  void onUnionTradeDropDownTap(MenuItem item) {
    for (int i = 0; i < allUnionTradeList.length; i++) {
      if (allUnionTradeList[i].text == item.text) {
        if (allUnionTradeList[i].isSelected) {
          allUnionTradeList[i].isSelected = false;
        } else {
          allUnionTradeList[i].isSelected = true;
          selectedUnion = allUnionTradeList[i];
        }
      } else {
        allUnionTradeList[i].isSelected = false;
      }
    }
    update();
  }*/

  bool showPrimaryPositionSelected = false;

  void removePrimaryPosition() {
    selectedDepartment = MenuItem(text: "Select Department", id: 0);
    selectedPosition = MenuItem(text: "Select Position", id: 0);
    showPrimaryPositionSelected = false;
    update();
  }

  void addPrimaryPosition() {
    showPrimaryPositionSelected = true;
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

  List<MenuItem> allUnionTradeList = [];

  Future<void> getAllUnionTrade() async {
    ResponseItem response = await QuickEntryRepo.getAllUnionTradeOrg();
    if (response.status) {
      allUnionTradeList.clear();
      allUnionTradeList.addAll(unionTradeModelFromJson(response.data)
          .map(
            (e) => MenuItem(
              text: e.unionTradeTitle,
              id: e.unionTradeId?.toInt() ?? -1,
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
    addressControllerList.clear();
    phoneList.clear();
    addWebsite.clear();
    birthDayList.clear();
    socialMediaList.clear();
    unionList.clear();
  }

  ///
  ///
  ///
  ///

  List<MenuItem> countryList = [];

  getAllCountryFromRaw(BuildContext context) async {
    countryList.clear();
    List<Country> list = await getCountries(context);
    countryList.addAll(list
        .map(
          (e) => MenuItem(
              text: e.name.toString(),
              isSelected: false,
              countryCode: e.countryCode),
        )
        .toList());
    update(["AddAddressBuilder"]);
  }

  List<AddressUiModel> addressControllerList = [];

  Map<String, dynamic> getAddressJson(List<AddressUiModel> addressList) {
    var address = AddressRequestModel(
      address: addressList
          .map(
            (e) => AddressData(
              addressId: e.id,
              addressLine1: e.addressLineOneController.text,
              addressLine2: e.addressLineTwoController.text,
              city: e.cityController.text,
              state: e.stateController.text,
              zip: e.zipCodeController.text,
              country: e.selectedCountry.text,
            ),
          )
          .toList(),
    ).toJson();
    return address;
  }

  void setAddress(List<Address> address) {
    addressControllerList.addAll(address.map(
          (e) {
            var model = AddressUiModel();
            model.id = e.addressId ?? -1;
            model.addressLineOneController.text = e.addressLine1 ?? "";
            model.addressLineTwoController.text = e.addressLine2 ?? "";
            model.cityController.text = e.city ?? "";
            model.stateController.text = e.state ?? "";
            model.zipCodeController.text = e.zip.toString();

            for (int i = 0; i < countryList.length; i++) {
              if (countryList[i].text == e.country) {
                if (countryList[i].isSelected) {
                  countryList[i].isSelected = false;
                } else {
                  countryList[i].isSelected = true;
                  model.selectedCountry = countryList[i];
                }
              } else {
                countryList[i].isSelected = false;
              }
            }

            return model;
          },
        ).toList() ??
        []);
  }
}

class AddressUiModel {
  num id = -1;
  late TextEditingController addressLineOneController = TextEditingController();
  late TextEditingController addressLineTwoController = TextEditingController();
  late TextEditingController cityController = TextEditingController();
  late TextEditingController stateController = TextEditingController();
  late TextEditingController zipCodeController = TextEditingController();
  MenuItem selectedCountry =
      MenuItem(text: "United States", countryCode: "US", isSelected: true);
}

class UnionUiModel {
  num? id;

  MenuItem selectedUnion = MenuItem(text: "Not Sure", isSelected: true);
}

class EditProfileItem {
  num id;
  String? text;
  TextEditingController controller;

  EditProfileItem(this.id, this.controller, {this.text});
}
