import 'package:flutter/material.dart';

import '../../../../globle.dart';
import '../../../widgets/dropdown.dart';
import '../../../widgets/fm_appbar.dart';
import '../../../widgets/profile_image.dart';
import 'editprofile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  final controller = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: fMAppBar(
          editProfile,
          onBackClick: () {
            Navigator.of(context).pop();
          },
        ),
        body: GetBuilder<EditProfileController>(initState: (initState) async {
          await controller.getAllJobClassifications();
          await controller.getMyProfile();
        }, builder: (ctrl) {
          return SingleChildScrollView(
            child: Column(
              children: [
                _profileImage(),
                nameCard(),
                _addPhone(),
                _email(),
                _union(context, ctrl),
                _primaryPosition(ctrl, context),
                _addAddress(),
                _addWebsite(),//
                _socialMedia(),
                _addBirthDay(),
                aboutMeCard(ctrl),
                FmButton(
                  ontap: () {
                    ctrl.performSaveButton(context);
                  },
                  name: save,
                ).paddingOnly(
                  left: screenWPadding16.sw(),
                  right: screenWPadding16.sw(),
                  bottom: screenHPadding16.sw(),
                  top: screenHPadding32.sh(),
                )
              ],
            ),
          );
        }),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }

  Widget _primaryPosition(EditProfileController ctrl, BuildContext context) {
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
          ctrl.showPrimaryPositionSelected
              ? Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          FmImage.assetImage(
                            path: Assets.iconsMinusIcon,
                            height: 20.sh(),
                            width: 20.sw(),
                          ).onClick(() {
                            controller.removePrimaryPosition();
                          }),
                          "Department"
                              .text(
                                fontColor: greyTextColor,
                                fontSize: 16,
                              )
                              .paddingOnly(
                                left: 10.sw(),
                              )
                        ],
                      ),
                    ),
                    Expanded(
                      child: fmDropDown(
                        child: _departmentDropDownItem(ctrl),
                        onDropDownTap: (item) {
                          controller.onDepartmentTap(item);
                        },
                        items: controller.allJobClassificationList,
                        context: context,
                        width: 215,
                      ).paddingOnly(
                        left: screenWPadding8.sw(),
                      ),
                    )
                  ],
                ).paddingOnly(
                  left: screenWPadding16.sw(),
                  top: screenHPadding16,
                  bottom: screenHPadding16,
                )
              : Container(),
          ctrl.showPrimaryPositionSelected
              ? Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20.sw(),
                          ),
                          "Position"
                              .text(
                                fontColor: greyTextColor,
                                fontSize: 16,
                              )
                              .paddingOnly(
                                left: 10.sw(),
                              )
                        ],
                      ),
                    ),
                    Expanded(
                      child: fmDropDown(
                        child: _positionDropDownItem(ctrl),
                        onDropDownTap: (item) {
                          controller.onPositionTap(item);
                        },
                        items: controller.allSubJobList,
                        context: context,
                        width: 215,
                      ).paddingOnly(
                        left: screenWPadding8.sw(),
                      ),
                    )
                  ],
                ).paddingOnly(
                  left: screenWPadding16.sw(),
                  /*  top: screenHPadding16,*/
                  /*  bottom: screenHPadding16,*/
                )
              : Container(),
          Row(
            children: [
              FmImage.assetImage(
                path: Assets.iconsPlusicon,
                height: 20.sh(),
                width: 20.sw(),
              ),
              "Add Primary Position"
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
              .onTap(() {
            controller.addPrimaryPosition();
          })
        ],
      ),
    ).paddingOnly(
      left: 16.sw(),
      right: 16.sw(),
      top: 16.sw(),
    );
  }

  Widget _union(BuildContext context, EditProfileController ctrl) {
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
          ctrl.showUnionSelected
              ? Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          FmImage.assetImage(
                            path: Assets.iconsMinusIcon,
                            height: 20.sh(),
                            width: 20.sw(),
                          ).onClick(() {
                            controller.removeUnionSelection();
                          }),
                          "Union"
                              .text(
                                fontColor: greyTextColor,
                                fontSize: 16,
                              )
                              .paddingOnly(left: 10.sw())
                        ],
                      ),
                    ),
                    Expanded(
                      child: fmDropDown(
                        child: _unionDropDownItem(ctrl),
                        onDropDownTap: (item) {
                          ctrl.onUnionNonUnionDropDownTap(item);
                        },
                        items: ctrl.unionNonUnionList,
                        width: 150,
                        context: context,
                      ),
                    )
                  ],
                ).paddingOnly(
                  left: screenWPadding16.sw(),
                  top: screenHPadding16,
                  bottom: screenHPadding16,
                )
              : Container(),
          Row(
            children: [
              FmImage.assetImage(
                path: Assets.iconsPlusicon,
                height: 20.sh(),
                width: 20.sw(),
              ),
              "Add Union"
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
              .onTap(() {
            controller.addUnionSelection();
          })
        ],
      ),
    ).paddingOnly(
      left: 16.sw(),
      right: 16.sw(),
      top: 16.sw(),
    );
  }

  Widget _addAddress() {
    return multiTextFieldCard(
      onItemRemove: (index) {
        if(controller.addAddress[index].id!=-1){
          controller.addressRemoveList.add(controller.addAddress[index].id.toString());
        }
        controller.addAddress.removeAt(index);
        controller.update();
      },
      itemList: controller.addAddress,
      onAddItemTap: () {
        if (controller.addAddress.isEmpty) {
          controller.addAddress.add(EditProfileItem(-1,TextEditingController()));
        }
        if (controller.addAddress.last.controller.text.isNotEmpty) {
          controller.addAddress.add(EditProfileItem(-1,TextEditingController()));
        }
        controller.update();
      },
      hint: "Add Address",
      buttonName: "Add Address",
    ).paddingOnly(
      top: screenHPadding16.sh(),
    );
  }

  Widget _addWebsite() {
    return multiTextFieldCard(
      onItemRemove: (index) {
        if(controller.addWebsite[index].id!=-1){
          controller.websiteRemoveList.add(controller.addWebsite[index].id.toString());
        }
        controller.addWebsite.removeAt(index);
        controller.update();
      },
      itemList: controller.addWebsite,
      onAddItemTap: () {
        if (controller.addWebsite.isEmpty) {
          controller.addWebsite.add(EditProfileItem(-1,TextEditingController()));
        }
        if (controller.addWebsite.last.controller.text.isNotEmpty) {
          controller.addWebsite.add(EditProfileItem(-1,TextEditingController()));
        }
        controller.update();
      },
      hint: "Add Website",
      buttonName: "Add Website",
    ).paddingOnly(
      top: screenHPadding16.sh(),
    );
  }

  Widget _socialMedia() {
    return multiTextFieldCard(
      onItemRemove: (index) {
        if(controller.socialMediaList[index].id!=-1){
          controller.socialRemoveMediaList.add(controller.socialMediaList[index].id.toString());
        }
        controller.socialMediaList.removeAt(index);
        controller.update();
      },
      itemList: controller.socialMediaList,
      onAddItemTap: () {
        if (controller.socialMediaList.isEmpty) {
          controller.socialMediaList.add(EditProfileItem(-1,TextEditingController()));
        }
        if (controller.socialMediaList.last.controller.text.isNotEmpty) {
          controller.socialMediaList.add(EditProfileItem(-1,TextEditingController()));
        }
        controller.update();
      },
      hint: "Add Social Media",
      buttonName: "Add Social Media",
    ).paddingOnly(
      top: screenHPadding16.sh(),
    );
  }

  Widget _addBirthDay() {
    return multiTextFieldCard(
      onItemRemove: (index) {
        controller.birthDayList.removeAt(index);
        controller.update();
      },
      itemList: controller.birthDayList,
      onAddItemTap: () {
        if (controller.birthDayList.isEmpty &&
            controller.birthDayList.length <= 1) {
          controller.birthDayList.add(EditProfileItem(-1,TextEditingController()));
        }
        /*if (controller.birthDayList.last.text.isNotEmpty) {
          controller.birthDayList.add(TextEditingController());
        }*/
        controller.update();
      },
      hint: "Add BirthDay",
      buttonName: "Add BirthDay",
    ).paddingOnly(
      top: screenHPadding16.sh(),
    );
  }

  Widget _addPhone() {
    return multiTextFieldCard(
      onItemRemove: (index) {
        if(controller.phoneList[index].id!=-1){
          controller.phoneRemoveList.add(controller.phoneList[index].id.toString());
        }
        controller.phoneList.removeAt(index);
        controller.update();
      },
      itemList: controller.phoneList,
      onAddItemTap: () {
        if (controller.phoneList.isEmpty) {
          controller.phoneList.add(EditProfileItem(-1,TextEditingController()));
        }
        if (controller.phoneList.last.controller.text.isNotEmpty) {
          controller.phoneList.add(EditProfileItem(-1,TextEditingController()));
        }
        controller.update();
      },
      hint: "Add Phone",
      buttonName: "Add Phone",
    ).paddingOnly(
      top: screenHPadding16.sh(),
    );
  }

  Widget _email() {
    return multiTextFieldCard(
            onItemRemove: (index) {
              if(controller.emailList[index].id!=-1){
                controller.emailRemoveList.add(controller.emailList[index].id.toString());
              }
              controller.emailList.removeAt(index);
              controller.update();
            },
            itemList: controller.emailList,
            onAddItemTap: () {
              if (controller.emailList.isEmpty) {
                controller.emailList.add(EditProfileItem(-1,TextEditingController()));
              }
              if (controller.emailList.last.controller.text.isNotEmpty) {
                controller.emailList.add(EditProfileItem(-1,TextEditingController()));
              }
              controller.update();
            },
            hint: addEmail,
            buttonName: addEmail,
            inputType: TextInputType.emailAddress)
        .paddingOnly(
      top: screenHPadding16.sh(),
    );
  }
/*
  Widget contentCard(String title, List<String> valueList,
      {GestureTapCallback? onAddClick,
      GestureTapCallback? onRemoveClick,
      TextEditingController? textController}) {
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
            itemCount: valueList.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        FmImage.assetImage(
                          path: Assets.iconsMinusIcon,
                          height: 20.sh(),
                          width: 20.sw(),
                        ),
                        title
                            .text(
                              fontColor: greyTextColor,
                              fontSize: 16,
                            )
                            .paddingOnly(left: 10.sw())
                      ],
                    ),
                  ),
                  Expanded(
                    child: FmEmptyTextField(
                      focusNode: FocusNode(),
                    ),
                  )
                ],
              )
                  .paddingOnly(
                    left: screenWPadding16.sw(),
                    top: screenHPadding16,
                    bottom: screenHPadding16,
                  )
                  .onTap(
                    onRemoveClick ?? () {},
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
              title
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
              .onTap(
                onAddClick ?? () {},
              )
        ],
      ),
    ).paddingOnly(
      left: 16.sw(),
      right: 16.sw(),
    );
  }*/

  Widget nameCard() {
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
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    firstName.text(
                      fontSize: 16,
                      fontColor: greyTextColor,
                    )
                  ],
                ),
              ),
              Expanded(
                child: FmEmptyTextField(
                  focusNode: FocusNode(),
                  controller: controller.firstNameController,
                  hintText: enterFirstName,
                ),
              ),
            ],
          ).paddingOnly(
            top: screenHPadding16.sh(),
            left: screenWPadding16.sh(),
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    lastName.text(
                      fontSize: 16,
                      fontColor: greyTextColor,
                    )
                  ],
                ),
              ),
              Expanded(
                child: FmEmptyTextField(
                  hintText: enterLastName,
                  focusNode: FocusNode(),
                  controller: controller.lastNameController,
                ),
              ),
            ],
          ).paddingOnly(
            top: screenHPadding16.sh(),
            bottom: screenHPadding16.sh(),
            left: screenWPadding16.sh(),
          )
        ],
      ),
    ).paddingOnly(
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
      top: screenHPadding32.sh(),
    );
  }

  Widget aboutMeCard(EditProfileController ctrl) {
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
          Row(
            children: [
              "About Me"
                  .text(
                    weight: FontWeight.w500,
                    fontSize: 16,
                  )
                  .paddingOnly(
                    top: screenHPadding16.sw(),
                  ),
            ],
          ),
          FmEmptyTextField(
            focusNode: FocusNode(),
            hintText: enterAboutMe,
            maxLines: 3,
            controller: ctrl.aboutMeController,
          )
        ],
      ).paddingOnly(
        left: screenWPadding16.sw(),
      ),
    ).paddingOnly(
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
      top: screenHPadding16.sh(),
      bottom: screenHPadding16.sh(),
    );
  }

  Widget multiTextFieldCard(
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
              return childItem(
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

  childItem(
      {required int index,
      required TextEditingController textController,
      required GestureTapCallback onRemoveClick,
      String? hint,
      TextInputType? inputType}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FmImage.assetImage(
          path: Assets.iconsMinusIcon,
          height: 20.sh(),
          width: 20.sw(),
        ).onClick(onRemoveClick),
        Expanded(
          child: FmEmptyTextField(
            focusNode: FocusNode(),
            controller: textController,
            hintText: hint,
            textInputType: inputType,
          ).paddingOnly(left: 10.sw()),
        )
      ],
    ).paddingOnly(
      left: screenWPadding16.sw(),
      top: screenHPadding16,
      bottom: screenHPadding16,
    );
  }

  _unionDropDownItem(EditProfileController ctrl) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ctrl.selectedUnion.text.text(
          fontColor: Colors.black,
          fontSize: 16,
        ),
        FmImage.assetImage(
          path: Assets.iconsDownIcon,
          height: 20.sh(),
          width: 15.sw(),
        )
      ],
    ).paddingOnly(right: screenWPadding16.sw());
  }

  _departmentDropDownItem(EditProfileController ctrl) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: ctrl.selectedDepartment.text.text(
                fontColor: Colors.black,
                fontSize: 16,
                overFlow: TextOverflow.ellipsis)),
        FmImage.assetImage(
          path: Assets.iconsDownIcon,
          height: 20.sh(),
          width: 15.sw(),
        )
      ],
    ).paddingOnly(right: screenWPadding16.sw());
  }

  _positionDropDownItem(EditProfileController ctrl) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ctrl.selectedPosition.text.text(
              fontColor: Colors.black,
              fontSize: 16,
              overFlow: TextOverflow.ellipsis),
        ),
        FmImage.assetImage(
          path: Assets.iconsDownIcon,
          height: 20.sh(),
          width: 15.sw(),
        )
      ],
    ).paddingOnly(
      right: screenWPadding16.sw(),
    );
  }

  _profileImage(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ProfileImageWidget(
          150,
          150,
          horizontalPadding: 52,
          verticlePadding: 49,
          onCameraClick: () {
            controller.pickImage();
          },
          imageUrl: controller.selectedImage,
        ).paddingOnly(
          top: 24.sh(),
        ),
      ],
    );
  }
}
