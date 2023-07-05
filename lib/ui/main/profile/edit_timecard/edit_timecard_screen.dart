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
        body: GetBuilder<EditTimeCardController>(
          initState: (state) async {
            await controller.getAllCountryFromRaw(context);
            await controller.getTimeCardInfo();
          },
          builder: (ctrl) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  _userPersonalDetail(context),
                  _userAdressDetail(context),
                  _genderDetail(),
                  _saveButton(context)
                ],
              ),
            );
          },
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }

  Widget _saveButton(BuildContext context) {
    return FmButton(
      ontap: () {
        controller.saveTimeCard(context);
      },
      name: save,
    ).paddingOnly(
      top: screenHPadding32.sh(),
      bottom: screenHPadding32.sh(),
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
    );
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
          _detailItem("Middle", controller: controller.middleNameController),
          _detailItem("Last Name", controller: controller.lastNameController),
          _unionDropDown("Union", context),
          _detailItem("Social Security",
              controller: controller.socialSecurityController),
          _detailItem("Phone Number", controller: controller.mobileController),
          _detailItem("E-mail",
              showBorder: false,
              controller: controller.emailController,
              type: TextInputType.emailAddress),
        ],
      ),
    ).paddingOnly(
      top: 24.sh(),
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
    );
  }

  Widget _userAdressDetail(BuildContext context) {
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
          _detailItem("Address Line 1", controller: controller.addressLineOne),
          _detailItem("Address Line 2", controller: controller.addressLineTwo),
          _detailItem("City", controller: controller.cityController),
          _detailItem("State", controller: controller.stateController),
          _detailItem("Zip", controller: controller.zipController),
          fmDropDown(
            child: countryDropDownChild(controller.selectedCountry),
            width: 240,
            onDropDownTap: (item) {
              controller.onCountryDropDownTap(item);
            },
            items: controller.countryList,
            context: context,
          ),
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
          _detailItem("Gender", controller: controller.genderController),
          _detailItem("Loan Out",
              showBorder: false, controller: controller.loanOutController),
        ],
      ),
    ).paddingOnly(
      top: screenHPadding16.sh(),
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
    );
  }

  Widget _detailItem(String lable,
      {bool showBorder = true,
      TextEditingController? controller,
      TextInputType? type}) {
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
              textInputType: type,
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
      child: fmDropDown(
        showDash: true,
        child: unionDropDownItem(controller.selectedUnion),
        onDropDownTap: (item) {
          controller.onUnionNonUnionDropDownTap(item);
        },
        items: controller.unionNonUnionList,
        context: context,
      ),
    );
  }

  unionDropDownItem(MenuItem union) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              "Union"
                  .text(
                    fontColor: greyTextColor,
                    fontSize: 16,
                  )
                  .paddingOnly(left: 20.sw())
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              controller.selectedUnion.text.text(
                fontColor: Colors.black,
                fontSize: 16,
              ),
              Spacer(),
              FmImage.assetImage(
                path: Assets.iconsDownIcon,
                height: 15.sh(),
                width: 15.sw(),
              )
            ],
          ).paddingOnly(
            right: screenWPadding16.sw(),
          ),
        )
      ],
    ).paddingOnly(
      top: screenHPadding16.sh(),
      bottom: 16.sh(),
    );
  }

  countryDropDownChild(MenuItem selectedCountry) {
    return Row(
      children: [
        Row(
          children: [
            selectedCountry.text
                .text(
                  fontColor: Colors.black,
                  fontSize: 16,
                )
                .paddingOnly(left: 20.sw())
          ],
        ),
        const Spacer(),
        FmImage.assetImage(
          path: Assets.iconsDownIcon,
          height: 20.sh(),
          width: 15.sw(),
        ).paddingOnly(
          right: 16.sw(),
        )
      ],
    ).paddingOnly(
      top: screenHPadding16.sh(),
      bottom: 16.sh(),
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
