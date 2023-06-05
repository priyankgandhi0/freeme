import 'package:flutter/material.dart';

import '../../../../globle.dart';
import '../../../widgets/dropdown.dart';
import '../../../widgets/fm_appbar.dart';
import 'edit_timecard_controller.dart';

class EditTimeCardScreen extends StatelessWidget {
  EditTimeCardScreen({Key? key}) : super(key: key);

  final controller = Get.put(EditTimeCardController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: backGroundWhiteColor,
        appBar: fMAppBar(
          editTimeCardInfo,
          onBackClick: () {
            Navigator.of(context).pop();
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _userPersonalDetail(context),
              _userAdressDetail(),
              _genderDetail(),
              _saveButton()
            ],
          ),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }

  Widget _saveButton() {
    return FmButton(
      ontap: () {},
      name: save,
    ).paddingOnly(
        top: screenHPadding32.sh(),
        bottom: screenHPadding32.sh(),
        left: screenWPadding16.sw(),
        right: screenWPadding16.sw());
  }

  Widget _userPersonalDetail(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
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
          _detailItem("First Name", controller: controller.firstNameController),
          _detailItem("Middle"),
          _detailItem("Last Name", controller: controller.lastNameController),
          _unionDropDown("Union", context),
          _detailItem("Social Security",
              controller: controller.socialSecurityController),
          _detailItem("Phone Number"),
          _detailItem("E-mail",showBorder: false),
        ],
      ),
    ).paddingOnly(
      top: 24.sh(),
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
    );
  }

  Widget _userAdressDetail() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
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
          _detailItem("Address Line 1"),
          _detailItem("Address Line 2"),
          _detailItem("City"),
          _detailItem("State"),
          _detailItem("Zip"),
          _detailItem("Country",showBorder: false),
        ],
      ),
    ).paddingOnly(
      top: screenHPadding16.sh(),
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
    );
  }

  Widget _genderDetail() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
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
          _detailItem("Gender"),
          _detailItem("Loan Out",showBorder: false),
        ],
      ),
    ).paddingOnly(
      top: screenHPadding16.sh(),
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
    );
  }

  Widget _detailItem(String lable,
      {bool showBorder = true, TextEditingController? controller}) {
    return Container(
      decoration: BoxDecoration(
        border: showBorder
            ? const Border(
                bottom: BorderSide(
                  color: borderGreyColor,
                  width: 1,
                ),
              )
            : null,
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                lable
                    .text(
                      fontColor: greyTextColor,
                      fontSize: 16,
                    )
                    .paddingOnly(left: 20.sw())
              ],
            ),
          ),
          Expanded(
            child: FmEmptyTextField(
              controller: controller,
            ),
          )
        ],
      ).paddingOnly(
        top: screenHPadding16.sh(),
        bottom: 16.sh(),
      ),
    );
  }

  Widget _unionDropDown(
    String lable,
    BuildContext context, {
    bool showBorder = true,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: showBorder
            ? const Border(
                bottom: BorderSide(
                  color: borderGreyColor,
                  width: 1,
                ),
              )
            : null,
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                lable
                    .text(
                      fontColor: greyTextColor,
                      fontSize: 16,
                    )
                    .paddingOnly(left: 20.sw())
              ],
            ),
          ),
          Expanded(
            child: fmDropDown(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FmImage.assetImage(
                    path: Assets.iconsDownIcon,
                    height: 15.sh(),
                    width: 15.sw(),
                  )
                ],
              ).paddingOnly(
                right: screenWPadding16.sw(),
              ),
              onDropDownTap: (item) {
                // _onUnionNonUnionDropDownTap(item);
              },
              items: controller.unionNonUnionList,
              context: context,
            ),
          )
        ],
      ).paddingOnly(
        top: screenHPadding16.sh(),
        bottom: 16.sh(),
      ),
    );
  }

/* _unionDropDown(BuildContext context) {
    return fmDropDown(
      child: Container(),
      onDropDownTap: (item) {
        // _onUnionNonUnionDropDownTap(item);
      },
      items: controller.unionNonUnionList,
      context: context,
    );
  }*/
}
