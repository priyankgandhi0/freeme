import 'package:flutter/material.dart';

import '../../../../api/repositories/time_card_info_repo.dart';
import '../../../../api/response_item.dart';
import '../../../../globle.dart';
import '../../../../models/time_card_info_model.dart';
import '../../../widgets/dropdown.dart';
import '../../navigator/main_controller.dart';

class EditTimeCardController extends GetxController {
  TextEditingController firstNameController = TextEditingController(text: "Jane");
  TextEditingController lastNameController = TextEditingController(text: "Doe");
  TextEditingController socialSecurityController = TextEditingController(text: "xxx-xx-");

  List<MenuItem> unionNonUnionList = [
    MenuItem(text: "Not Sure", isSelected: true),
    MenuItem(text: "Yes", isSelected: false),
    MenuItem(text: "No", isSelected: false),
  ];

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

  void saveTimeCard() {

  }

  void setUpTimeCardData(TimeCardInfoModel model) {

  }
}
