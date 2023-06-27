import 'package:flutter/cupertino.dart';
import 'package:freeme/api/api_globle.dart';
import 'package:freeme/globle.dart';
import 'package:freeme/ui/widgets/dropdown.dart';
import 'package:get/get.dart';
import '../../../api/repositories/job_repo.dart';
import '../../../api/response_item.dart';
import '../../../models/country.dart';
import '../../../models/day_type.dart';
import '../../../models/edit_timecard_request.dart';
import '../../../models/work_history_model.dart';
import '../navigator/main_controller.dart';


class TimeCardEditController extends GetxController {
  TextEditingController l1addressl1Controller = TextEditingController();
  TextEditingController l1addressl2Controller = TextEditingController();
  TextEditingController l1CityController = TextEditingController();
  TextEditingController l1StateController = TextEditingController();
  TextEditingController l1ZipController = TextEditingController();

  TextEditingController l2addressl1Controller = TextEditingController();
  TextEditingController l2addressl2Controller = TextEditingController();
  TextEditingController l2CityController = TextEditingController();
  TextEditingController l2StateController = TextEditingController();
  TextEditingController l2ZipController = TextEditingController();

  startLoading() {
    Future.delayed(Duration.zero, () {
      Get.find<HomeController>().startLoading();
    });
  }

  stopLoading() {
    Future.delayed(Duration.zero, () {
      Get.find<HomeController>().stopLoading();
    });
    update();
  }

  WorkHistoryModel? historyModel;

  Future<void> getWorkHistory(num? jobId, String date) async {
    startLoading();
    try {
      ResponseItem response = await JobRepo.getWorkHistory(jobId ?? -1, date);
      if (response.status) {
        historyModel = WorkHistoryModel.fromJson(response.data);
        if (historyModel != null) {
          setUpData(historyModel!);
        }
        update();
        stopLoading();
      } else {
        stopLoading();
      }
    } catch (e) {
      stopLoading();
    }
  }

  void setUpData(WorkHistoryModel model) {
    l1addressl1Controller.text = model.locations?[0].addressLine1 ?? "";
    l1addressl2Controller.text = model.locations?[0].addressLine2 ?? "";
    l1CityController.text = model.locations?[0].state ?? "";
    l1StateController.text = model.locations?[0].city ?? "";
    l1ZipController.text = (model.locations?[0].zip ?? 0).toString();
    if (model.locations?[0].country != null &&
        model.locations![0].country!.isNotEmpty) {
      locationOneCountry = locationOneCountryList
          .firstWhere((element) => element.text == model.locations?[0].country);
    }
    l2addressl1Controller.text = model.locations?[1].addressLine1 ?? "";
    l2addressl2Controller.text = model.locations?[1].addressLine2 ?? "";
    l2CityController.text = model.locations?[1].state ?? "";
    l2StateController.text = model.locations?[1].city ?? "";
    l2ZipController.text = (model.locations?[1].zip ?? 0).toString();
    if (model.locations?[1].country != null &&
        model.locations![1].country!.isNotEmpty) {
      locationTwoCountry = locationTwoCountryList
          .firstWhere((element) => element.text == model.locations?[1].country);
    }
    if (model.dayType != null &&
        model.dayType!.isNotEmpty &&
        dayTypeList.isNotEmpty) {
      selectedDayType =
          dayTypeList.firstWhere((element) => element.text == model.dayType);
    }
  }

  List<MenuItem> locationOneCountryList = [];
  List<MenuItem> locationTwoCountryList = [];

  getAllCountryFromRaw(BuildContext context) async {
    locationOneCountryList.clear();
    locationTwoCountryList.clear();
    List<Country> list = await getCountries(context);
    locationOneCountryList.addAll(list
        .map(
          (e) => MenuItem(
              text: e.name.toString(),
              isSelected: false,
              countryCode: e.countryCode),
        )
        .toList());
    locationTwoCountryList.addAll(list
        .map(
          (e) => MenuItem(
              text: e.name.toString(),
              isSelected: false,
              countryCode: e.countryCode),
        )
        .toList());
    update();
  }

  MenuItem locationOneCountry =
      MenuItem(text: "United States", countryCode: "US");

  void onLocationOneCountrySelect(MenuItem item) {
    for (int i = 0; i < locationOneCountryList.length; i++) {
      if (locationOneCountryList[i].text == item.text) {
        if (locationOneCountryList[i].isSelected) {
          // locationOneCountryList[i].isSelected = false;
        } else {
          locationOneCountryList[i].isSelected = true;
          locationOneCountry = locationOneCountryList[i];
        }
      } else {
        locationOneCountryList[i].isSelected = false;
      }
    }
    update();
  }

  MenuItem locationTwoCountry =
      MenuItem(text: "United States", countryCode: "US");

  void onLocationTwoCountrySelect(MenuItem item) {
    for (int i = 0; i < locationTwoCountryList.length; i++) {
      if (locationTwoCountryList[i].text == item.text) {
        if (locationTwoCountryList[i].isSelected) {
          // locationTwoCountryList[i].isSelected = false;
        } else {
          locationTwoCountryList[i].isSelected = true;
          locationTwoCountry = locationTwoCountryList[i];
        }
      } else {
        locationTwoCountryList[i].isSelected = false;
      }
    }
    update();
  }

  Future<void> saveEditTimeCard(
    num jobId,
    String date,
    BuildContext context,
  ) async {
    startLoading();
    /*   try {*/
    List<Locations> locationList = [
      Locations(
        locationId: (historyModel?.locations ?? []).isEmpty
            ? null
            : historyModel?.locations?[0].locationId,
        addressLine1: l1addressl1Controller.text,
        addressLine2: l1addressl2Controller.text,
        city: l1CityController.text,
        state: l1StateController.text,
        country: locationOneCountry.text,
        zip: l1ZipController.text.isEmpty
            ? null
            : int.parse(
                l1ZipController.text.toString(),
              ),
      ),
      Locations(
        locationId: (historyModel?.locations ?? []).length <= 1
            ? null
            : historyModel?.locations?[1].locationId,
        addressLine1: l2addressl1Controller.text,
        addressLine2: l2addressl2Controller.text,
        city: l2CityController.text,
        state: l2StateController.text,
        country: locationTwoCountry.text,
        zip: l2ZipController.text.isEmpty
            ? null
            : int.parse(
                l2ZipController.text.toString(),
              ),
      ),
    ];
    var request = EditTimecardRequest(
      jobId: jobId,
      locations: locationList,
      date: date,
      dayType: selectedDayType.text,
    );
    ResponseItem response = await JobRepo.editWorkHistoryTimecard(
      request.toJson(),
    );
    if (response.status) {
      update();
      clearAllFields();
      Navigator.of(context).pop();
      stopLoading();
    } else {
      stopLoading();
    }
    /*} catch (e) {
      stopLoading();
    }*/
  }

  Future<void> clearAllFields() async {}

  List<MenuItem> dayTypeList = [];

  Future<void> getAllDayTypeList() async {
    startLoading();
    ResponseItem response = await JobRepo.getAllDayTypes();
    if (response.status) {
      dayTypeList.clear();
      dayTypeList.addAll(
        dayTypeListFromJson(response.data).map(
          (e) => MenuItem(id: e.dayTypeId, text: e.dayType),
        ),
      );
      update();
      stopLoading();
    } else {
      stopLoading();
    }
  }

  MenuItem selectedDayType = MenuItem(text: "Shoot Day", id: 1);

  void onDayTypeSelect(MenuItem item) {
    for (int i = 0; i < dayTypeList.length; i++) {
      if (dayTypeList[i].text == item.text) {
        if (dayTypeList[i].isSelected) {
        } else {
          dayTypeList[i].isSelected = true;
          selectedDayType = dayTypeList[i];
        }
      } else {
        dayTypeList[i].isSelected = false;
      }
    }
    update();
  }

  ///dialog

  DateTime clockInTime = DateTime.now();
  late String selectedDate;

  Future<void> clockIn({
    required ClockedTimes clockInTime,
    required num jobId,
    required String date,
  }) async {
    startLoading();
    try {
      var request = EditTimecardRequest(
        jobId: jobId,
        date: date,
        clockedTimes: clockInTime,
      );
      ResponseItem response = await JobRepo.editWorkHistoryTimecard(
        request.toJson(),
      );
      if (response.status) {
        await getWorkHistory(jobId, date);
        update();
        stopLoading();
      } else {
        stopLoading();
      }
    } catch (e) {
      stopLoading();
    }
  }

  bool isLunchStartValidate(String time, BuildContext context) {
    if (historyModel?.callTime != null && historyModel?.date != null) {
      var time1 = convertToMyTimeFormat(
        historyModel?.callTime ?? "",
        historyModel?.date ?? "",
      );
      var time2 = convertToMyTimeFormat(
        time,
        historyModel?.date ?? "",
      );
      if (time2.isAfter(time1)) {
        return true;
      } else {
        lunchMustBeginAfterCallTime.errorSnack(context);
        return false;
      }
    }
    if (historyModel?.callTime != null) {
      pleaseAddCallTimeFirst.errorSnack(context);
    }
    return false;
  }

  bool isLunchEndValidate(String time, BuildContext context) {
    if (historyModel?.firstMealStart != null && historyModel?.date != null) {
      var time1 = convertToMyTimeFormat(
        historyModel?.firstMealStart ?? "",
        historyModel?.date ?? "",
      );
      var time2 = convertToMyTimeFormat(
        time,
        historyModel?.date ?? "",
      );
      if (time2.isAfter(time1)) {
        return true;
      } else {
        lunchEndMustBeginAfterLunchStart.errorSnack(context);
        return false;
      }
    }
    return false;
  }

  bool isSecondMealStartValidate(String time, BuildContext context) {
    if (historyModel?.firstMealEnd != null && historyModel?.date != null) {
      var time1 = convertToMyTimeFormat(
        historyModel?.firstMealEnd ?? "",
        historyModel?.date ?? "",
      );
      var time2 = convertToMyTimeFormat(
        time,
        historyModel?.date ?? "",
      );
      if (time2.isAfter(time1)) {
        return true;
      } else {
        secondMealStartMustBeginAfterFirstMealEnd.errorSnack(context);
        return false;
      }
    }
    return false;
  }

  bool isSecondMealEndValidate(String time, BuildContext context) {
    if (historyModel?.secondMealStart != null && historyModel?.date != null) {
      var time1 = convertToMyTimeFormat(
        historyModel?.secondMealStart ?? "",
        historyModel?.date ?? "",
      );
      var time2 = convertToMyTimeFormat(
        time,
        historyModel?.date ?? "",
      );
      if (time2.isAfter(time1)) {
        return true;
      } else {
        secondMealEndMustBeginAfterSecondMealStart.errorSnack(context);
        return false;
      }
    }
    return false;
  }

  convertToMyTimeFormat(String time, String date) {
    var now = date.split("-");
    int hour = int.parse(time.split(":").first.toString());
    int minute = int.parse(time.split(":").last.substring(0, 2));
    bool isPm = time.contains("PM") ? true : false;
    return DateTime.utc(
        int.parse(now[0]),
        int.parse(now[1]),
        int.parse(now[2]),
        isPm
            ? hour != 12
                ? hour + 12
                : hour
            : hour,
        minute,
        0);
  }
}
