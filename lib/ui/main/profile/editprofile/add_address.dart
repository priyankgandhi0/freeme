import 'package:flutter/material.dart';
import 'package:freeme/globle.dart';
import 'package:get/get.dart';

import '../../../../constant/space_constant.dart';
import '../../../../theme/app_colors.dart';
import '../../../widgets/fm_image.dart';
import 'editprofile_controller.dart';

class AddAdress extends StatelessWidget {
    AddAdress({Key? key}) : super(key: key);

  final controller = Get.find<EditProfileController>();
  @override
  Widget build(BuildContext context) {
    return addressMultiFieldCard(
      onItemRemove: (index) {
        if (controller.addAddress[index].id != -1) {
          controller.addressRemoveList
              .add(controller.addAddress[index].id.toString());
        }
        controller.addAddress.removeAt(index);
        controller.update();
      },
      itemList: controller.addAddress,
      onAddItemTap: () {
        if (controller.addAddress.isEmpty) {
          controller.addAddress
              .add(EditProfileItem(-1, TextEditingController()));
        }
        if (controller.addAddress.last.controller.text.isNotEmpty) {
          controller.addAddress
              .add(EditProfileItem(-1, TextEditingController()));
        }
        controller.update();
      },
      hint: "Address",
      buttonName: "Add Address",
    ).paddingOnly(
      top: screenHPadding16.sh(),
    );
  }

  Widget addressMultiFieldCard(
      {required Function(int index) onItemRemove,
        required List<EditProfileItem> itemList,
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
            offset: Offset(2, 3),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: itemList.length,
            itemBuilder: (context, index) {
              return addressChildItem(
                index: index,
                hint: hint,
                inputType: inputType,
                textController: itemList[index].controller,
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
        required TextEditingController textController,
        required GestureTapCallback onRemoveClick,
        String? hint,
        TextInputType? inputType}) {
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
                controller: textController,
                hintText: addressLineOne,
                textInputType: inputType,
              ).paddingOnly(
                left: 10.sw(),
                bottom: 6,
              ),
              FmEmptyTextField(
                focusNode: FocusNode(),
                controller: textController,
                hintText: addressLineTwo,
                textInputType: inputType,
              ).paddingOnly(
                left: 10.sw(),
                top: 6,
                bottom: 6,
              ),
              FmEmptyTextField(
                focusNode: FocusNode(),
                controller: textController,
                hintText: city,
                textInputType: inputType,
              ).paddingOnly(
                left: 10.sw(),
                top: 6,
                bottom: 6,
              ),
              FmEmptyTextField(
                focusNode: FocusNode(),
                controller: textController,
                hintText: state,
                textInputType: inputType,
              ).paddingOnly(
                left: 10.sw(),
                top: 6,
                bottom: 6,
              ),
              FmEmptyTextField(
                focusNode: FocusNode(),
                controller: textController,
                hintText: country,
                textInputType: inputType,
              ).paddingOnly(
                left: 10.sw(),
                top: 6,
                bottom: 6,
              ),
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
}
