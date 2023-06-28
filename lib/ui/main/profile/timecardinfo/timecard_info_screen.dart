import 'package:flutter/material.dart';
import 'package:freeme/globle.dart';
import 'package:freeme/models/time_card_info_model.dart';
import 'package:freeme/ui/main/profile/timecardinfo/time_card_info_controller.dart';

import '../../../widgets/fm_appbar.dart';

class TimeCardInfoScreen extends StatelessWidget {
  TimeCardInfoScreen({Key? key}) : super(key: key);

  final controller = Get.put(TimeCardInfoController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: fMAppBar(
          timeCardInfo,
          onBackClick: () {
            Navigator.of(context).pop();
          },
          onTrailingClick: () {
            Navigator.pushNamed(context, Routes.editTimeCardScreen);
          },
        ),
        body: GetBuilder<TimeCardInfoController>(
          initState: (state) {
            controller.getTimeCardInfo();
          },
          builder: (ctrl) {
            return Column(
              children: [
                timeCard(ctrl),
              ],
            );
          },
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }

  Widget timeCard(TimeCardInfoController ctrl) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            offset: Offset(2, 3),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Column(
        children: [
          timeCardItem("First Name", ctrl.model?.firstName ?? "").paddingOnly(
            top: screenHPadding16.sh(),
            bottom: screenHPadding16.sh(),
          ),
          timeCardItem("Middle", ctrl.model?.middleName ?? "").paddingOnly(
            bottom: screenHPadding16.sh(),
          ),
          timeCardItem("Last Name", ctrl.model?.lastName ?? "").paddingOnly(
            bottom: screenHPadding16.sh(),
          ),
          timeCardItem("Union", ctrl.model?.union ?? "").paddingOnly(
            bottom: screenHPadding16.sh(),
          ),
          timeCardItem("Social Security", ctrl.model?.socialSecurity ?? "")
              .paddingOnly(
            bottom: screenHPadding16.sh(),
          ),
          timeCardItem("Phone Number", ctrl.model?.mobileNo?.toString() ?? "")
              .paddingOnly(
            bottom: screenHPadding16.sh(),
          ),
          timeCardItem("E-mail", ctrl.model?.email ?? "").paddingOnly(
            bottom: screenHPadding16.sh(),
          ),
          timeCardItem("Address", _getAddress(ctrl.model)).paddingOnly(
            bottom: screenHPadding16.sh(),
          ),
          timeCardItem("Gender", ctrl.model?.gender ?? "").paddingOnly(
            bottom: screenHPadding16.sh(),
          ),
          timeCardItem("Loan Out", ctrl.model?.loanOut ?? "").paddingOnly(
            bottom: screenHPadding16.sh(),
          ),
        ],
      ),
    ).paddingOnly(
      top: 24.sh(),
      left: 16.sh(),
      right: 16.sh(),
    );
  }

  String _getAddress(TimeCardInfoModel? model) {
    return "${model?.addressLine1 ?? ""}"
        "\n${model?.addressLine2 ?? ""}"
        "\n${model?.city ?? ""}"
        "\n${model?.state ?? ""}"
        "\n${model?.zip ?? ""}"
        "\n${model?.country ?? ""}";
  }

  Widget timeCardItem(String lable, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            children: [
              lable.text(fontSize: 16),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: value.text(fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    ).paddingOnly(
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
    );
  }
}
