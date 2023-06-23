import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:freeme/api/repositories/quick_entry_repo.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../api/api_globle.dart';
import '../../../api/repositories/job_repo.dart';
import '../../../calender_demo/utils.dart';
import '../../../globle.dart';
import '../../../models/country.dart';
import '../../../models/get_job_info_model.dart';
import '../../../models/guaranteed_hour_model.dart';
import '../../../models/job_classification_model.dart';
import '../../../models/paid_by_model.dart';
import '../../../models/per_hour_model.dart';
import '../../../models/sub_job_classification_model.dart';
import '../../../models/taxed_nontaxed_item.dart';
import '../../../models/term_model.dart';
import '../../../models/type_model.dart';
import '../../widgets/dropdown.dart';
import '../../widgets/non_tax_item_dialog.dart';
import '../../widgets/tax_item_dialog.dart';
import '../navigator/main_controller.dart';
import '../work_history/history/work_history_controller.dart';
import '../work_history/work_history_detail/job_info/job_info_controller.dart';

class AddJobController extends GetxController {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController productionTitleController = TextEditingController();
  TextEditingController producerController = TextEditingController();
  TextEditingController productionCompanyController = TextEditingController();
  TextEditingController addressLIne1Controller = TextEditingController();
  TextEditingController addressLIne2Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipController = TextEditingController();

  TextEditingController paidByManualController = TextEditingController();
  TextEditingController termsManualController = TextEditingController();
  TextEditingController typeManualController = TextEditingController();

  TextEditingController rateTextController = TextEditingController();
  TextEditingController recommendedByController = TextEditingController();
  TextEditingController hiredByController = TextEditingController();

  Future loadAllDropDown() async {
    await getAllPerHour();
    await getAllGuaranteedHour();
    await getAllPaidBy();
    await getAllTerms();
    await getAllTypes();
    await getAllJobClassifications();
    update();
  }

  bool isExpanded = false;

  onExpansionChange(bool value) {
    isExpanded = value;
    update(["CompanyAdddressExpanded"]);
  }

  bool isJobClassificationExpanded = false;

  onJobClassificationExpansionChange(bool value) {
    isJobClassificationExpanded = value;
    update(["jobClassificationExpanded"]);
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
    update(["CompanyAdddressExpanded"]);
  }

  List<TaxedNonTaxedModel> nonTaxedItems = [];

  List<TaxedNonTaxedModel> taxedItems = [];

  var focusedDay = DateTime.now();
  DateTime currentDay = DateTime.now();

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
    update(["DaysDialogController"]);
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
          .map(
            (e) => MenuItem(
                text: e.hours,
                id: e.hoursId,
                isSelected: e.hours == "10 Hours" ? true : false),
          )
          .toList());
    } else {}
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

  ///
  ///
  ///

  List<MenuItem> unionNonUnionList = [
    MenuItem(text: "Not Sure", isSelected: true),
    MenuItem(text: "Non Union", isSelected: false),
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

  ///
  ///
  ///
  MenuItem selectedPerHour =
      MenuItem(text: "10 hours", isSelected: true, id: 3);

  void onPerHourDropDownTap(MenuItem item) {
    for (int i = 0; i < allPerHour.length; i++) {
      if (allPerHour[i].text == item.text) {
        if (allPerHour[i].isSelected) {
          // allPerHour[i].isSelected = false;
          // selectedPerHour = MenuItem(text: "10 hours");
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

  MenuItem selectedGuaranteedHour = MenuItem(text: "Not Sure");

  void onPerGuaranteedHourDropDownTap(MenuItem item) {
    for (int i = 0; i < allGuaranteedHour.length; i++) {
      if (allGuaranteedHour[i].text == item.text) {
        if (allGuaranteedHour[i].isSelected) {
          /*allGuaranteedHour[i].isSelected = false;
          selectedGuaranteedHour = MenuItem(text: "Not Sure");*/
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

  MenuItem selectedPaidBy = MenuItem(text: "Not Sure");

  void onPaidByDropDownTap(MenuItem item) {
    for (int i = 0; i < allPaidBy.length; i++) {
      if (allPaidBy[i].text == item.text) {
        if (allPaidBy[i].isSelected) {
          /* allPaidBy[i].isSelected = false;
          selectedPaidBy = MenuItem(text: "Not Sure");*/
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

  void onTermDropDownTap(MenuItem item) {
    for (int i = 0; i < allTerms.length; i++) {
      if (allTerms[i].text == item.text) {
        if (allTerms[i].isSelected) {
          /* allTerms[i].isSelected = false;
          selectedTerm = MenuItem(text: "Not Sure");*/
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
          /* allTypes[i].isSelected = false;
          selectedType = MenuItem(text: "Not Sure");*/
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

  MenuItem selectedDepartment = MenuItem(text: "Select Department");

  void onDepartmentTap(MenuItem item) {
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

  List<MenuItem> w21099List = [
    MenuItem(text: "Not Sure", isSelected: true),
    MenuItem(text: "W2", isSelected: false),
    MenuItem(text: "1099", isSelected: false),
  ];

  MenuItem selectedW2Or1099 = MenuItem(text: "Not Sure");

  void onw21099DropDownTap(MenuItem item) {
    for (int i = 0; i < w21099List.length; i++) {
      if (w21099List[i].text == item.text) {
        if (w21099List[i].isSelected) {
          w21099List[i].isSelected = false;
          selectedW2Or1099 = MenuItem(text: "Not Sure");
        } else {
          w21099List[i].isSelected = true;
          selectedW2Or1099 = w21099List[i];
        }
      } else {
        w21099List[i].isSelected = false;
      }
    }
    update();
  }

  ///
  ///
  ///
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

  ///
  ///
  ///
  String? calenderError;

  void onSelectDaysClick(BuildContext context) {
    if (selectedDays.isEmpty) {
      calenderError = "Please Select Atleast One Date";
      update(["DaysDialogController"]);
      return;
    }
    calenderError = null;
    update(["DaysDialogController"]);
    update();
    Navigator.of(context, rootNavigator: true).pop();
  }

  startLoading() {
    Future.delayed(Duration.zero, () {
      Get.find<HomeController>().startLoading();
      update();
    });
  }

  stopLoading() {
    Future.delayed(Duration.zero, () {
      Get.find<HomeController>().stopLoading();
      update();
    });
  }

  Future<void> addJobButtonClick(BuildContext context, {int? jobId}) async {
    if (_isValidate(context)) {
      startLoading();
      /* try {*/
      ResponseItem response = await QuickEntryRepo.addJobSubmit(
        jobId: jobId,
        selectedDays: selectedDays.map((e) => convertToMyFormat(e)).toList(),
        description: descriptionController.text.trim(),
        productionTitle: productionTitleController.text.trim(),
        producer: producerController.text.trim(),
        productionCompany: productionCompanyController.text.trim(),
        companyAddressLine1: addressLIne1Controller.text.trim(),
        companyAddressLine2: addressLIne2Controller.text.trim(),
        city: cityController.text.trim(),
        state: stateController.text.trim(),
        zip: zipController.text.trim(),
        rate: rateTextController.text.isNotEmpty
            ? int.parse(rateTextController.text.trim().toString())
            : null,
        recommendedBy: recommendedByController.text.trim(),
        hiredBy: hiredByController.text.trim(),
        unionNonunion: selectedUnion.text,
        department: selectedDepartment.id,
        w2_1099: selectedW2Or1099.text,
        guaranteedHours: selectedGuaranteedHour.id,
        paidBy: selectedPaidBy.idForAPI,
        terms: selectedTerm.idForAPI,
        perHowManyHours: selectedPerHour.id,
        countryCode: selectedCountry.text,
        type: selectedType.idForAPI,
        position: selectedPosition.id,
        nonTaxedItems: nonTaxedItems,
        taxedItems: taxedItems,
        removeNonTaxedItems: nonTaxedItemRemoveList,
        removeTaxedItems: taxedItemRemoveList,
        paidByManual: paidByManualController.text.trim(),
        termsManual: termsManualController.text.trim(),
        typeManual: typeManualController.text.trim(),
      );
      if (response.status) {
        if (jobId != null) {
          await Get.find<JobInfoController>().getJobInfo(jobId: jobId);
          Get.find<JobInfoController>().update();
        }
        stopLoading();
        await Get.find<WorkHistoryController>().getAllJob();

        clearAllData();
        Navigator.of(context).pop();
      } else {
        stopLoading();
        response.message.errorSnack(context);
      }
      /* } catch (e) {
        stopLoading();
      }*/
    }
  }

  String convertToMyFormat(DateTime e) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(e);
    return formattedDate;
    //2023-06-06
  }

  String? descriptionError;
  String? rateError;
  String? departmentError;
  String? positionError;
  String? daysError;

  bool _isValidate(BuildContext context) {
    if (descriptionController.text.isEmpty ||
        rateTextController.text.isEmpty ||
        selectedDepartment.id == null ||
        selectedPosition.id == null ||
        selectedDays.isEmpty) {
      if (descriptionController.text.isEmpty) {
        descriptionError = "";
      } else {
        descriptionError = null;
      }
      if (rateTextController.text.isEmpty) {
        rateError = "";
      } else {
        rateError = null;
      }

      if (selectedDepartment.id == null) {
        departmentError = "";
      } else {
        departmentError = null;
      }
      if (selectedPosition.id == null) {
        positionError = "";
      } else {
        positionError = null;
      }
      if (selectedDays.isEmpty) {
        daysError = "";
      } else {
        daysError = null;
      }
      update();
      return false;
    }
    descriptionError = null;
    rateError = null;
    departmentError = null;
    positionError = null;
    daysError = null;
    update();
    return true;
  }

  GetJobInfoModel? jobInfo;

  Future<void> getJobInfo({required int jobId}) async {
    startLoading();
    ResponseItem response = await JobRepo.getJobInfo(jobId);
    if (response.status) {
      jobInfo = GetJobInfoModel.fromJson(response.data);
      if (jobInfo != null) {
        setJobData(jobInfo!);
      }
      stopLoading();
    } else {
      stopLoading();
    }
  }

  void setJobData(GetJobInfoModel jobInfo) {
    descriptionController.text = jobInfo.description ?? "";
    productionTitleController.text = jobInfo.productionTitle ?? "";
    producerController.text = jobInfo.producer ?? "";
    productionCompanyController.text = jobInfo.productionCompany ?? "";
    addressLIne1Controller.text = jobInfo.companyAddressLine1 ?? "";
    addressLIne2Controller.text = jobInfo.companyAddressLine2 ?? "";
    cityController.text = jobInfo.city ?? "";
    stateController.text = jobInfo.state ?? "";
    zipController.text = (jobInfo.zip ?? "").toString();
    rateTextController.text = (jobInfo.rate ?? "").toString();
    recommendedByController.text = jobInfo.recommendedBy ?? "";
    hiredByController.text = jobInfo.hiredBy ?? "";

    selectedPerHour = allPerHour.firstWhereOrNull((element) =>
            element.text?.toLowerCase() ==
            jobInfo.hours?.toLowerCase()) ??
        MenuItem(text: "10 hours", isSelected: true, id: 3);
    onPerHourDropDownTap(selectedPerHour);

    selectedGuaranteedHour = allGuaranteedHour.firstWhereOrNull((element) =>
            element.text?.toLowerCase() ==
            jobInfo.guaranteedHour?.toLowerCase()) ??
        MenuItem(text: "Not Sure");
    selectedW2Or1099 = w21099List.firstWhere((element) =>
        element.text?.toLowerCase() == jobInfo.w21099?.toLowerCase());
    selectedPaidBy = allPaidBy.firstWhereOrNull((element) =>
            element.text?.toLowerCase() == jobInfo.paidByName?.toLowerCase()) ??
        MenuItem(text: "Not Sure");
    selectedTerm = allTerms.firstWhereOrNull((element) =>
            element.text?.toLowerCase() == jobInfo.term?.toLowerCase()) ??
        MenuItem(text: "Not Sure");
    selectedDepartment = allJobClassificationList.firstWhere((element) =>
        element.text?.toLowerCase() == jobInfo.jobClassificationCategory?.toLowerCase());
    selectedType = allTypes.firstWhereOrNull((element) =>
            element.text?.toLowerCase() == jobInfo.type?.toLowerCase()) ??
        MenuItem(text: "Not Sure");

    selectedUnion = unionNonUnionList.firstWhereOrNull((element) =>
            element.text?.toLowerCase() ==
            jobInfo.unionNonunion?.toLowerCase()) ??
        MenuItem(text: "Not Sure", isSelected: true);

    selectedDays.clear();
    jobInfo.days?.forEach((element) {
      DateTime tempDate =
          DateFormat("yyyy-MM-dd").parse(element.date.toString());
      onDaySelect(tempDate, tempDate);
    });

    selectedCountry = countryList
            .firstWhereOrNull((element) => element.text == jobInfo.country) ??
        MenuItem(text: "United States", countryCode: "US");

    taxedItems.clear();
    taxedItems.addAll(
      jobInfo.taxes?.map(
            (e) => TaxedNonTaxedModel(
                type: e.taxedItem,
                amount: e.taxtAmount.toString(),
                timeId: e.taxPerTimeId?.toInt(),
                id: e.taxesId,
                taxedItemId: e.taxtTypeId,
                timeDesc: e.taxPerTimeCategory),
          ) ??
          [],
    );

    nonTaxedItems.clear();
    nonTaxedItems.addAll(
      jobInfo.nonTaxes?.map(
            (e) => TaxedNonTaxedModel(
              type: e.taxedItem,
              amount: e.nonTaxtAmount.toString(),
              timeId: e.taxPerTimeId?.toInt(),
              id: e.nonTaxesId,
              taxedItemId: e.taxtTypeId,
              timeDesc: e.taxPerTimeCategory,
            ),
          ) ??
          [],
    );

    getAllSubJobList(selectedDepartment.id ?? -1).then(
      (value) {
        selectedPosition = allSubJobList
            .firstWhere((element) => element.text == makeStringDoubleLine(jobInfo.subJobClassificationsCategory ?? ""));
        update();
      },
    );
  }

  clearAllData() {
    taxedItemRemoveList.clear();
    nonTaxedItemRemoveList.clear();
    selectedDays.clear();
    descriptionController.clear();
    productionTitleController.clear();
    producerController.clear();
    productionCompanyController.clear();
    addressLIne1Controller.clear();
    addressLIne2Controller.clear();
    cityController.clear();
    zipController.clear();
    rateTextController.clear();
    recommendedByController.clear();
    hiredByController.clear();
    selectedDays.clear();
    taxedItemRemoveList.clear();
    nonTaxedItemRemoveList.clear();
    taxedItems.clear();
    nonTaxedItems.clear();

    selectedCountry = MenuItem(text: "United States", countryCode: "US");
    selectedPerHour = MenuItem(text: "10 hours", isSelected: true, id: 3);
    selectedGuaranteedHour = MenuItem(text: "Not Sure");
    selectedW2Or1099 = MenuItem(text: "Not Sure");
    selectedPaidBy = MenuItem(text: "Not Sure");
    selectedTerm = MenuItem(text: "Not Sure");
    selectedDepartment = MenuItem(text: "Select Department");
    selectedPosition = MenuItem(text: "Select Position");
    selectedType = MenuItem(text: "Not Sure");
    selectedUnion = MenuItem(text: "Not Sure", isSelected: true);
  }

  List<String> taxedItemRemoveList = [];
  List<String> nonTaxedItemRemoveList = [];

  void removeTaxedItem(TaxedNonTaxedModel item) {
    if (item.id != null) {
      taxedItemRemoveList.add(item.id.toString());
      taxedItems.remove(item);
    } else {
      taxedItems.remove(item);
    }
    update();
  }

  void removeNonTaxedItem(TaxedNonTaxedModel item) {
    if (item.id != null) {
      nonTaxedItemRemoveList.add(item.id.toString());
      nonTaxedItems.remove(item);
    } else {
      nonTaxedItems.remove(item);
    }
    update();
  }

  Future<void> autoPopulatelastEntry() async {
    startLoading();
    ResponseItem response = await JobRepo.getJobLastEntry();
    if (response.status) {
      setUpData(GetJobInfoModel.fromJson(response.data));
      stopLoading();
    } else {
      stopLoading();
    }
  }

  setUpData(GetJobInfoModel model) {
    setJobData(model);
  }
}

class NonTaxedItem {
  String name;
  String value;

  NonTaxedItem(this.name, this.value);
}
