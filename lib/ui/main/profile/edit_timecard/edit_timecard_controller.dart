import 'package:flutter/material.dart';

import '../../../../api/repositories/time_card_info_repo.dart';
import '../../../../api/response_item.dart';
import '../../../../globle.dart';
import '../../../../models/country.dart';
import '../../../../models/time_card_info_model.dart';
import '../../../widgets/dropdown.dart';
import '../../navigator/main_controller.dart';
import '../account/account_controller.dart';
import '../timecardinfo/time_card_info_controller.dart';

class EditTimeCardController extends GetxController {
  TextEditingController firstNameController =
      TextEditingController(text: "Jane");
  TextEditingController lastNameController = TextEditingController(text: "Doe");
  TextEditingController middleNameController = TextEditingController();
  TextEditingController socialSecurityController =
      TextEditingController(text: "xxx-xx-");
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressLineOne = TextEditingController();
  TextEditingController addressLineTwo = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController loanOutController = TextEditingController();

  List<MenuItem> unionNonUnionList = [
    MenuItem(text: "Not Sure", isSelected: true),
    MenuItem(text: "Non-Union", isSelected: false),
    MenuItem(text: "Union", isSelected: false),
  ];

  MenuItem selectedUnion = MenuItem(text: "Not Sure", isSelected: true);

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

  startLoading() {
    Get.find<HomeController>().startLoading();
  }

  stopLoading() {
    Get.find<HomeController>().stopLoading();
  }

  TimeCardInfoModel? model;

  Future<void> getTimeCardInfo() async {
    startLoading();
    ResponseItem response = await TimeCardInfoRepo.getTimeCardInfo();
    if (response.status) {
      model = TimeCardInfoModel.fromJson(response.data);
      setUpTimeCardData(model);
      update();
      stopLoading();
    } else {
      stopLoading();
    }
  }

  Future<void> saveTimeCard(BuildContext context) async {
    startLoading();
    ResponseItem response = await TimeCardInfoRepo.editTimecardInfo(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        middleName: middleNameController.text,
        mobile: mobileController.text,
        email: emailController.text,
        state: stateController.text,
        addressLine1: addressLineOne.text,
        zip: zipController.text,
        addressLine2: addressLineTwo.text,
        city: cityController.text,
        gender: genderController.text,
        loanOut: loanOutController.text,
        socialSecurity: socialSecurityController.text,
        country: selectedCountry.text,
        unionName: selectedUnion.text);
    if (response.status) {
      update();
      clearAllData();
      Navigator.of(context).pop();
      Get.find<TimeCardInfoController>().getTimeCardInfo();
      Get.find<AccountController>().onInit();
      stopLoading();
    } else {
      stopLoading();
    }
  }

  void setUpTimeCardData(TimeCardInfoModel? model) {
    firstNameController.text = model?.firstName ?? "";
    lastNameController.text = model?.lastName ?? "";
    socialSecurityController.text = model?.socialSecurity ?? "";
    mobileController.text = model?.mobileNo?.toString() ?? "";
    emailController.text = model?.email ?? "";
    addressLineOne.text = model?.addressLine1 ?? "";
    addressLineTwo.text = model?.addressLine2 ?? "";
    cityController.text = model?.city ?? "";
    stateController.text = model?.state ?? "";
    zipController.text = model?.zip?.toString() ?? "";
    genderController.text = model?.gender ?? "";
    loanOutController.text = model?.loanOut ?? "";

    onCountryDropDownTap(countryList
            .firstWhereOrNull((element) => model?.country == element.text) ??
        MenuItem(text: "United States", countryCode: "US"));
  }

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
    update();
  }

  MenuItem selectedCountry = MenuItem(text: "United States", countryCode: "US");

  void onCountryDropDownTap(MenuItem item) {
    for (int i = 0; i < countryList.length; i++) {
      if (countryList[i].text == item.text) {
        if (countryList[i].isSelected) {
          countryList[i].isSelected = false;
        } else {
          countryList[i].isSelected = true;
          selectedCountry = countryList[i];
        }
      } else {
        countryList[i].isSelected = false;
      }
    }
    update();
  }

  clearAllData(){
    firstNameController.clear();
    lastNameController.clear();
    socialSecurityController.clear();
    mobileController.clear();
    emailController.clear();
    addressLineOne.clear();
    addressLineTwo.clear();
    cityController.clear();
    stateController.clear();
    zipController.clear();
    genderController.clear();
    loanOutController.clear();
    onCountryDropDownTap(MenuItem(text: "United States", countryCode: "US"));
    onUnionNonUnionDropDownTap(MenuItem(text: "Not Sure", isSelected: true));
  }
}
