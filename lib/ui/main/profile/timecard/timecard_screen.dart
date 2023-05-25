import 'package:flutter/material.dart';
import 'package:freeme/globle.dart';

import '../../../widgets/fm_appbar.dart';

class TimeCardInfoScreen extends StatelessWidget {
  const TimeCardInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: fMAppBar(
          timeCardInfo,
          onBackClick: () {
            Get.back();
          },
          onTrailingClick: () {
            Get.toNamed(Routes.editTimeCardScreen);
          },
        ),
        body: Column(
          children: [
            timeCard(),
          ],
        ),
      ),
      onWillPop: () async {
        Get.back();
        return false;
      },
    );
  }

  Widget timeCard() {
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
          timeCardItem("First Name", "Jane").paddingOnly(
            top: screenHPadding16.sh(),
            bottom: screenHPadding16.sh(),
          ),
          timeCardItem("Middle", "D").paddingOnly(
            bottom: screenHPadding16.sh(),
          ),
          timeCardItem("Last Name", "Doe").paddingOnly(
            bottom: screenHPadding16.sh(),
          ),
          timeCardItem("Union", "IATSE Local 600").paddingOnly(
            bottom: screenHPadding16.sh(),
          ),
          timeCardItem("Social Security", "xxx-xx-1234").paddingOnly(
            bottom: screenHPadding16.sh(),
          ),
          timeCardItem("Phone Number", "1-000-000-0000").paddingOnly(
            bottom: screenHPadding16.sh(),
          ),
          timeCardItem("E-mail", "work_email@gmail.com").paddingOnly(
            bottom: screenHPadding16.sh(),
          ),
          timeCardItem("Address", "1234 Street Dr.Apt 111 City, State Zip")
              .paddingOnly(
            bottom: screenHPadding16.sh(),
          ),
          timeCardItem("Gender", "Prefer Not To Say").paddingOnly(
            bottom: screenHPadding16.sh(),
          ),
          timeCardItem("Loan Out", "Company, LLC").paddingOnly(
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

  Widget timeCardItem(String lable, String value) {
    return Row(
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
