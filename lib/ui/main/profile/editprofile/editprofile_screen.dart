import 'package:flutter/material.dart';

import '../../../../globle.dart';
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
        body: GetBuilder<EditProfileController>(builder: (ctrl) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    profileImage(
                      150,
                      150,
                      horizontalPadding: 52,
                      verticlePadding: 49,
                      onCameraClick: () {
                          controller.pickImage();
                      },
                    ).paddingOnly(
                      top: 24.sh(),
                    ),
                  ],
                ),
                nameCard().paddingOnly(top: screenHPadding32.sh()),
                contentCard("Add Phone", ["1-000-000-0000"], onAddClick: () {})
                    .paddingOnly(top: screenHPadding16.sh()),
                contentCard(addEmail, ["Work_email@gmail.com"],
                        onAddClick: () {})
                    .paddingOnly(top: screenHPadding16.sh()),
                contentCard(union, ["lATSE Local 600"], onAddClick: () {})
                    .paddingOnly(top: screenHPadding16.sh()),
                contentCard(primaryPosition, ["Camera / 1st Assist..."],
                        onAddClick: () {})
                    .paddingOnly(top: screenHPadding16.sh()),
                contentCard(addAddress, [], onAddClick: () {})
                    .paddingOnly(top: screenHPadding16.sh()),
                contentCard(addWebsite, [], onAddClick: () {})
                    .paddingOnly(top: screenHPadding16.sh()),
                contentCard(addSocialMedia, [], onAddClick: () {})
                    .paddingOnly(top: screenHPadding16.sh()),
                contentCard(addBirthday, [], onAddClick: () {})
                    .paddingOnly(top: screenHPadding16.sh()),
                aboutMeCard("Likes to play golf, pool, games"),
                FmButton(
                  ontap: () {
                    ctrl.performSaveButton(context);
                  },
                  name: save,
                ).paddingOnly(
                    left: screenWPadding16.sw(),
                    right: screenWPadding16.sw(),
                    bottom: screenHPadding16.sw(),
                    top: screenHPadding32.sh())
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

  Widget contentCard(
    String title,
    List<String> valueList, {
    GestureTapCallback? onAddClick,
    GestureTapCallback? onRemoveClick,
  }) {
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
                  /*Expanded(
                    child: Row(
                      children: [
                        valueList[index].text(
                          fontColor: Colors.black,
                          fontSize: 16,
                        )
                      ],
                    ),
                  )*/
                  Expanded(
                    child: FmEmptyTextField(),
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
  }

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
    );
  }

  Widget aboutMeCard(String value) {
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
            hintText: enterAboutMe,
            maxLines: 3,
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
}
