import 'package:flutter/material.dart';
import 'package:freeme/globle.dart';
import 'package:freeme/models/user_login_model.dart';

import '../../../widgets/fm_appbar.dart';
import '../../../widgets/profile_image.dart';
import 'account_controller.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({Key? key}) : super(key: key);

  final controller = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: GetBuilder<AccountController>(builder: (ctrl) {
        return Scaffold(
          appBar: fMAppBar(account),
          backgroundColor: backGroundWhiteColor,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ProfileImageWidget(
                      140,
                      140,
                      verticlePadding: 41,
                      horizontalPadding: 46,
                      imageUrl: ctrl.userModel?.userProfilePhoto,
                    ).paddingOnly(
                      top: 24.sh(),
                    )
                  ],
                ),
                "${ctrl.userModel?.firstName ?? ""} ${ctrl.userModel?.lastName ?? ""}"
                    .text(weight: FontWeight.w500, fontSize: 20)
                    .paddingOnly(
                      top: screenHPadding16.sh(),
                    ),
                (ctrl.userModel?.union?[0])
                        ?.unionTradeTitle
                        .text(fontSize: 16)
                        .paddingOnly(
                          top: screenHPadding8.sh(),
                        ) ??
                    Container(),
                getPosition(ctrl.userModel)
                    .text(fontColor: greyTextColor, fontSize: 16)
                    .paddingOnly(
                      top: screenHPadding8.sh(),
                    ),
                accountOptionItem(
                  timeInfoCard,
                  () {
                    Navigator.pushNamed(context, Routes.timeCardInfoScreen);
                  },
                ).paddingOnly(top: 32),
                accountOptionItem(
                  myProfile,
                  () {
                    Navigator.pushNamed(context, Routes.myProfileScreen);
                  },
                ).paddingOnly(top: 16),
                accountOptionItem(
                  accountSettings,
                  () {
                    Navigator.pushNamed(context, Routes.accountSettingScreen);
                  },
                ).paddingOnly(top: 16),
              ],
            ).safeArea,
          ),
        );
      }),
      onWillPop: () async {
        return false;
      },
    );
  }

  Widget accountOptionItem(String title, GestureTapCallback onclick) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          title
              .text(
                fontSize: 16,
              )
              .paddingOnly(
                left: screenWPadding16.sw(),
              ),
          FmImage.assetImage(
            path: Assets.iconsForwardIcon,
            height: 14,
            width: 7,
          ).paddingOnly(
            right: screenWPadding16.sw(),
          )
        ],
      ).onTap(onclick).paddingOnly(
            top: screenHPadding16.sh(),
            bottom: screenHPadding16.sh(),
          ),
    ).paddingOnly(
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
    );
  }

  String getPosition(UserModel? userModel) {
    if (userModel != null) {
      String s = "";
      if (!userModel.subJobClassificationsCategory.isNullOrEmpty) {
        s = s + (userModel.subJobClassificationsCategory ?? "");
      }
      if (!userModel.jobClassificationCategory.isNullOrEmpty) {
        s = "$s, ${userModel.jobClassificationCategory ?? ""}";
      }
      return s;
    }
    return "";
  }
}
