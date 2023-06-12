import 'package:flutter/cupertino.dart';
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
import '../profile/timecard/timecard_controller.dart';

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
  }

  List<ClockTime> clockTimeList = [];

  void setUpData(WorkHistoryModel model) {
    clockTimeList.clear();
    clockTimeList.addAll([
      ClockTime(
        "Call Time:",
        model.callTime.isNullOrEmpty ? "--:-- AM/PM" : model.callTime,
      ),
      ClockTime(
        "1st Meal Start:",
        model.firstMealStart.isNullOrEmpty
            ? "--:-- AM/PM"
            : model.firstMealStart,
      ),
      ClockTime(
        "1st Meal End:",
        model.firstMealEnd.isNullOrEmpty ? "--:-- AM/PM" : model.firstMealEnd,
      ),
      ClockTime(
        "2nd Meal Start:",
        model.secondMealStart.isNullOrEmpty
            ? "--:-- AM/PM"
            : model.secondMealStart,
      ),
      ClockTime(
        "2nd Meal End:",
        model.secondMealEnd.isNullOrEmpty ? "--:-- AM/PM" : model.secondMealEnd,
      ),
      ClockTime(
        "Wrap:",
        model.wrap.isNullOrEmpty ? "--:-- AM/PM" : model.wrap,
      ),
    ]);

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
      num jobId, String date, BuildContext context) async {
    startLoading();
    List<Locations> locationList = [
      Locations(
          addressLine1: l1addressl1Controller.text,
          addressLine2: l1addressl2Controller.text,
          city: l1CityController.text,
          state: l1StateController.text,
          country: locationOneCountry.text,
          zip: int.parse(l1ZipController.text)),
      Locations(
        addressLine1: l2addressl1Controller.text,
        addressLine2: l2addressl2Controller.text,
        city: l2CityController.text,
        state: l2StateController.text,
        country: locationTwoCountry.text,
        zip: int.parse(l2ZipController.text.toString())
      ),
    ];
    var request = EditTimecardRequest(
        jobId: jobId,
        locations: locationList,
        date: date,
        dayType: selectedDayType.text);
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
  }

  Future<void> clearAllFields() async {}

  List<MenuItem> dayTypeList = [];

  Future<void> getAllDayTypeList() async {
    startLoading();
    ResponseItem response = await JobRepo.getAllDayTypes();
    if (response.status) {
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
}
