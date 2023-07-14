import 'package:flutter/material.dart';
import 'package:freeme/globle.dart';
import 'package:get/get.dart';

import '../../../../constant/space_constant.dart';
import '../../../../theme/app_colors.dart';
import '../../../widgets/dropdown.dart';
import '../../../widgets/fm_image.dart';
import 'editprofile_controller.dart';

class AddAdress extends StatelessWidget {
  AddAdress({Key? key}) : super(key: key);

  final controller = Get.find<EditProfileController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      id: "AddAddressBuilder",
      initState: (state) {
        controller.getAllCountryFromRaw(context);
      },
      builder: (ctrl) {
        return addressMultiFieldCard(
          onItemRemove: (index) {
            if (controller.addressControllerList[index].id != -1) {
              controller.addressRemoveList
                  .add(controller.addressControllerList[index].id.toString());
            }
            controller.addressControllerList.removeAt(index);
            controller.update();
          },
          itemList: controller.addressControllerList,
          onAddItemTap: () {

            if (controller.addressControllerList.isEmpty) {
              controller.addressControllerList
                  .add(AddressUiModel());
              controller.update();
              return;
            }
            if (controller.addressControllerList.last.addressLineOneController.text.isNotEmpty) {
              controller.addressControllerList
                  .add(AddressUiModel());
            }
            controller.update();
          },
          hint: "Address",
          buttonName: "Add Address",
        ).paddingOnly(
          top: screenHPadding16.sh(),
        );
      },
    );
  }

  Widget addressMultiFieldCard(
      {required Function(int index) onItemRemove,
      required List<AddressUiModel> itemList,
      required GestureTapCallback onAddItemTap,
      String? hint,
      required String buttonName,
      TextInputType? inputType}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            offset: const Offset(2, 3),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: itemList.length,
            itemBuilder: (context, index) {
              return addressChildItem(
                index: index,
                hint: hint,
                inputType: inputType,
                context: context,
                addressItem: itemList[index],
                onRemoveClick: () {
                  onItemRemove(index);
                },
              );
            },
          ),
          Row(
            children: [
              FmImage.assetImage(
                path: Assets.iconsPlusicon,
                height: 20.sh(),
                width: 20.sw(),
              ),
              buttonName
                  .text(
                    fontColor: greyTextColor,
                    fontSize: 16,
                  )
                  .paddingOnly(left: 10.sw())
            ],
          )
              .paddingOnly(
                left: screenWPadding16.sw(),
                top: screenHPadding16,
                bottom: screenHPadding16,
              )
              .onTap(onAddItemTap)
        ],
      ),
    ).paddingOnly(
      left: 16.sw(),
      right: 16.sw(),
    );
  }

  addressChildItem(
      {required int index,
      required AddressUiModel addressItem,
      required GestureTapCallback onRemoveClick,
      String? hint,
      TextInputType? inputType,
      required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FmImage.assetImage(
                path: Assets.iconsMinusIcon,
                height: 20.sh(),
                width: 20.sw(),
              ).onClick(onRemoveClick),
              hint.text(fontColor: greyTextColor, fontSize: 16).paddingOnly(
                    left: screenWPadding8.sw(),
                  ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              FmEmptyTextField(
                focusNode: FocusNode(),
                controller: addressItem.addressLineOneController,
                hintText: addressLineOne,
                textInputType: inputType,
              ).paddingOnly(
                left: 10.sw(),
                bottom: 6,
              ),
              FmEmptyTextField(
                focusNode: FocusNode(),
                controller: addressItem.addressLineTwoController,
                hintText: addressLineTwo,
                textInputType: inputType,
              ).paddingOnly(
                left: 10.sw(),
                top: 6,
                bottom: 6,
              ),
              FmEmptyTextField(
                focusNode: FocusNode(),
                controller: addressItem.cityController,
                hintText: city,
                textInputType: inputType,
              ).paddingOnly(
                left: 10.sw(),
                top: 6,
                bottom: 6,
              ),
              FmEmptyTextField(
                focusNode: FocusNode(),
                controller: addressItem.stateController,
                hintText: state,
                textInputType: inputType,
              ).paddingOnly(
                left: 10.sw(),
                top: 6,
                bottom: 6,
              ),
              FmEmptyTextField(
                focusNode: FocusNode(),
                controller: addressItem.zipCodeController,
                hintText: zip,
                textInputType: inputType,
              ).paddingOnly(
                left: 10.sw(),
                top: 6,
                bottom: 6,
              ),
              fmDropDown(
                child: countryItemWithDropDown(
                    addressItem.selectedCountry.text ?? ""),
                width: 240,
                onDropDownTap: (item) {
                  for (int i = 0; i < controller.countryList.length; i++) {
                    if (controller.countryList[i].text == item.text) {
                      if (controller.countryList[i].isSelected) {
                        controller.countryList[i].isSelected = false;
                      } else {
                        controller.countryList[i].isSelected = true;
                        addressItem.selectedCountry = controller.countryList[i];
                      }
                    } else {
                      controller.countryList[i].isSelected = false;
                    }
                  }
                  controller.update(["AddAddressBuilder"]);
                },
                items: controller.countryList,
                context: context,
              )
            ],
          ),
        )
      ],
    ).paddingOnly(
      left: screenWPadding16.sw(),
      top: screenHPadding16,
      bottom: screenHPadding16,
    );
  }

  Widget countryItemWithDropDown(String selectedCountry) {
    return Row(
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (selectedCountry).text(fontSize: 16, fontColor: greyTextColor),
              FmImage.assetImage(
                path: Assets.iconsDownIcon,
                height: 15.sh(),
                width: 15.sw(),
              ).paddingOnly(
                right: screenWPadding16.sw(),
              )
            ],
          ),
        ),
      ],
    ).paddingAll(8);
  }
}
