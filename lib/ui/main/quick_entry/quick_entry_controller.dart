import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:freeme/api/api_globle.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../api/repositories/quick_entry_repo.dart';
import '../../../api/response_item.dart';
import '../../../calender_demo/utils.dart';
import '../../../globle.dart';
import '../../../models/country.dart';
import '../../../models/guaranteed_hour_model.dart';
import '../../../models/paid_by_model.dart';
import '../../../models/per_hour_model.dart';
import '../../../models/term_model.dart';
import '../../../models/type_model.dart';
import '../../widgets/dropdown.dart';
import '../navigator/main_controller.dart';

class QuickEntryController extends GetxController {
  bool isExpanded = false;

  PageController pageController = PageController(initialPage: 0);
  int activatePage = 0;

  var focusedDay = DateTime.now();
  DateTime currentDay = DateTime.now();

  @override
  void onInit() {
    getAllPerHour();
    getAllGuaranteedHour();
    getAllPaidBy();
    getAllTerms();
    getAllTypes();
    super.onInit();
  }

  List<MenuItem> countryList = [];

  getAllCountryFromRaw(BuildContext context) async {
    countryList.clear();
    List<Country> list = await getCountries(context);
    countryList.addAll(list
        .map((e) => MenuItem(text: e.name.toString(), isSelected: false))
        .toList());
    update(["CompanyAdddressExpanded"]);
  }

  final Set<DateTime> selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  void onDaySelect(DateTime selectedDay, DateTime focusDay) {
    focusedDay = focusDay;
    if (selectedDays.contains(selectedDay)) {
      selectedDays.remove(selectedDay);
    } else {
      selectedDays.add(selectedDay);
    }
    currentDay = focusDay;
    update();
  }

  void onPageChange(int page) {
    activatePage = page;
    update();
  }

  onExpansionChange(bool value) {
    isExpanded = value;
    update(["CompanyAdddressExpanded"]);
  }

  MenuItem? selectedCountry;

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

  startLoading() {
    Get.find<HomeController>().startLoading();
  }

  stopLoading() {
    Get.find<HomeController>().stopLoading();
  }

  TextEditingController descriptionController = TextEditingController();
  TextEditingController productionTitleController = TextEditingController();
  TextEditingController producerController = TextEditingController();
  TextEditingController productionCompanyController = TextEditingController();
  TextEditingController addressLIne1Controller = TextEditingController();
  TextEditingController addressLIne2Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipController = TextEditingController();

  TextEditingController rateTextController = TextEditingController();
  TextEditingController recommendedByController = TextEditingController();
  TextEditingController hiredByController = TextEditingController();

  Future<void> finishButtonClick(BuildContext context) async {
    startLoading();
    ResponseItem response = await QuickEntryRepo.quickEntrySubmit(
        description: descriptionController.text.trim(),
        productionTitle: productionTitleController.text.trim(),
        producer: producerController.text.trim(),
        productionCompany: productionCompanyController.text.trim(),
        companyAddressLine1: addressLIne1Controller.text.trim(),
        companyAddressLine2: addressLIne2Controller.text.trim(),
        city: cityController.text.trim(),
        state: stateController.text.trim(),
        zip: zipController.text.trim(),
        rate: int.parse(rateTextController.text.trim().toString()),
        recommendedBy: recommendedByController.text.trim(),
        hiredBy: hiredByController.text.trim());
    if (response.status) {
      stopLoading();
    } else {
      response.message.errorSnack(context);
      stopLoading();
    }
  }

  void moveToThirdPage() {
    if (_isSecondPageValidate()) {
      pageController.jumpToPage(2);
    }
  }

  void moveToLastPage() {
    if (_isFifthPageValidate()) {
      pageController.jumpToPage(5);
    }
  }

  void moveToFourthPage() {
    if (_isThirdPageValidate()) {
      pageController.jumpToPage(3);
    }
  }

  String? rateError;

  bool _isThirdPageValidate() {
    if (rateTextController.text.trim().isEmpty) {
      rateError = "Enter Rate";
      update();
      return false;
    } else {
      rateError = null;
      update();
      return true;
    }
  }

  String? recommendedByError;
  String? hiredByError;

  bool _isFifthPageValidate() {
    if (recommendedByController.text.trim().isEmpty ||
        hiredByController.text.trim().isEmpty) {
      if (recommendedByController.text.trim().isEmpty) {
        recommendedByError = "Enter Recommended by";
      } else {
        recommendedByError = null;
      }
      if (hiredByController.text.trim().isEmpty) {
        hiredByError = "Enter Hired By";
      } else {
        hiredByError = null;
      }
      update();
      return false;
    }
    update();
    recommendedByError = null;
    hiredByError = null;
    return true;
  }

  String? descriptionError;
  String? productionTitleError;
  String? producerError;
  String? productionCompanyError;
  String? addressError;

  _isSecondPageValidate() {
    if (descriptionController.text.trim().isEmpty ||
        productionTitleController.text.trim().isEmpty ||
        producerController.text.trim().isEmpty ||
        productionCompanyController.text.trim().isEmpty ||
        addressLIne1Controller.text.trim().isEmpty ||
        addressLIne2Controller.text.trim().isEmpty ||
        cityController.text.trim().isEmpty ||
        stateController.text.trim().isEmpty ||
        zipController.text.trim().isEmpty) {
      if (descriptionController.text.trim().isEmpty) {
        descriptionError = "Add Description";
      } else {
        descriptionError = null;
      }
      if (productionTitleController.text.trim().isEmpty) {
        productionTitleError = "Add Production Title";
      } else {
        productionTitleError = null;
      }
      if (producerController.text.trim().isEmpty) {
        producerError = "Add Producer";
      } else {
        producerError = null;
      }
      if (productionCompanyController.text.trim().isEmpty) {
        productionCompanyError = "Add Production Company";
      } else {
        productionCompanyError = null;
      }

      if (addressLIne1Controller.text.trim().isEmpty ||
          addressLIne2Controller.text.trim().isEmpty ||
          cityController.text.trim().isEmpty ||
          stateController.text.trim().isEmpty ||
          zipController.text.trim().isEmpty) {
        addressError = "Add All Address Detail";
      } else {
        addressError = null;
      }
      update();
      return false;
    }
    descriptionError = null;
    productionTitleError = null;
    producerError = null;
    productionCompanyError = null;
    addressError = null;
    update();
    return true;
  }

  List<MenuItem> allTypes = [];

  Future getAllTypes() async {
    ResponseItem response = await QuickEntryRepo.getAllTypesList();
    if (response.status) {
      allTypes.clear();
      allTypes.addAll(typeModelFromJson(response.data)
          .map((e) => MenuItem(text: e.type, id: e.typeId, isSelected: false))
          .toList());
    } else {}
  }

  List<MenuItem> allTerms = [];

  Future getAllTerms() async {
    ResponseItem response = await QuickEntryRepo.getAllTermsList();
    if (response.status) {
      allTerms.clear();
      allTerms.addAll(termModelFromJson(response.data)
          .map((e) => MenuItem(text: e.term, id: e.termsId, isSelected: false))
          .toList());
    } else {}
  }

  List<MenuItem> allPaidBy = [];

  Future getAllPaidBy() async {
    ResponseItem response = await QuickEntryRepo.getAllPaidByList();
    if (response.status) {
      allPaidBy.clear();
      allPaidBy.addAll(paidByFromJson(response.data)
          .map((e) =>
              MenuItem(text: e.paidByName, id: e.paidById, isSelected: false))
          .toList());
    } else {}
  }

  List<MenuItem> allGuaranteedHour = [];

  Future getAllGuaranteedHour() async {
    ResponseItem response = await QuickEntryRepo.getAllGuaranteedHourList();
    if (response.status) {
      allGuaranteedHour.clear();
      allGuaranteedHour.addAll(guaranteedHourModelFromJson(response.data)
          .map((e) => MenuItem(
              text: e.guaranteedHour,
              id: e.guaranteedHourId,
              isSelected: false))
          .toList());
    } else {}
  }

  List<MenuItem> allPerHour = [];

  Future getAllPerHour() async {
    ResponseItem response = await QuickEntryRepo.allPerHourList();
    if (response.status) {
      allPerHour.clear();
      allPerHour.addAll(perHourModelFromJson(response.data)
          .map((e) => MenuItem(text: e.hours, id: e.hoursId, isSelected: false))
          .toList());
    } else {}
  }

  ///
  ///
  ///
  ///
  MenuItem selectedGuaranteedHour = MenuItem(text: "Not Sure");

  void guaranteedHourClick(MenuItem item) {
    for (int i = 0; i < allGuaranteedHour.length; i++) {
      if (allGuaranteedHour[i].text == item.text) {
        if (allGuaranteedHour[i].isSelected) {
          allGuaranteedHour[i].isSelected = false;
          selectedGuaranteedHour = MenuItem(text: "Not Sure");
        } else {
          allGuaranteedHour[i].isSelected = true;
          selectedGuaranteedHour = allGuaranteedHour[i];
        }
      } else {
        allGuaranteedHour[i].isSelected = false;
      }
    }
    update();
  }

  MenuItem selectedPerHour = MenuItem(text: "10 hours");

  void onPerHourDropDownTap(MenuItem item) {
    for (int i = 0; i < allPerHour.length; i++) {
      if (allPerHour[i].text == item.text) {
        if (allPerHour[i].isSelected) {
          allPerHour[i].isSelected = false;
          selectedPerHour = MenuItem(text: "10 hours");
        } else {
          allPerHour[i].isSelected = true;
          selectedPerHour = allPerHour[i];
        }
      } else {
        allPerHour[i].isSelected = false;
      }
    }
    update();
  }

  MenuItem selectedPaidBy = MenuItem(text: "Not Sure");

  void onPaidByDropDownTap(MenuItem item) {
    for (int i = 0; i < allPaidBy.length; i++) {
      if (allPaidBy[i].text == item.text) {
        if (allPaidBy[i].isSelected) {
          allPaidBy[i].isSelected = false;
          selectedPaidBy = MenuItem(text: "Not Sure");
        } else {
          allPaidBy[i].isSelected = true;
          selectedPaidBy = allPaidBy[i];
        }
      } else {
        allPaidBy[i].isSelected = false;
      }
    }
    update();
  }

  MenuItem selectedTerm = MenuItem(text: "Not Sure");

  void onTermsDropDownTap(MenuItem item) {
    for (int i = 0; i < allTerms.length; i++) {
      if (allTerms[i].text == item.text) {
        if (allTerms[i].isSelected) {
          allTerms[i].isSelected = false;
          selectedTerm = MenuItem(text: "Not Sure");
        } else {
          allTerms[i].isSelected = true;
          selectedTerm = allTerms[i];
        }
      } else {
        allTerms[i].isSelected = false;
      }
    }
    update();
  }

  MenuItem selectedType = MenuItem(text: "Not Sure");

  void onTypeDropDownTap(MenuItem item) {
    for (int i = 0; i < allTypes.length; i++) {
      if (allTypes[i].text == item.text) {
        if (allTypes[i].isSelected) {
          allTypes[i].isSelected = false;
          selectedType = MenuItem(text: "Not Sure");
        } else {
          allTypes[i].isSelected = true;
          selectedType = allTypes[i];
        }
      } else {
        allTypes[i].isSelected = false;
      }
    }
    update();
  }
}
