import 'package:flutter/material.dart';
import 'package:freeme/globle.dart';

import '../../../widgets/fm_appbar.dart';
import '../../../widgets/profile_image.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: fMAppBar(account),
        backgroundColor: backGroundWhiteColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                profileImage(
                  140,
                  140,
                  verticlePadding: 41,horizontalPadding: 46
                ).paddingOnly(
                  top: 24.sh(),
                )
              ],
            ),
            "Erica Chan"
                .text(weight: FontWeight.w500, fontSize: 20)
                .paddingOnly(
                  top: screenHPadding16.sh(),
                ),
            "IATSE Local 600".text(fontSize: 16).paddingOnly(
                  top: screenHPadding8.sh(),
                ),
            "1st Assistant Camera, Director"
                .text(fontColor: greyTextColor, fontSize: 16)
                .paddingOnly(
                  top: screenHPadding8.sh(),
                ),
            accountOptionItem(
              timeInfoCard,
              () {
                Get.toNamed(Routes.timeCardScreen);
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
                //Get.toNamed(Routes.betaScreen);
              },
            ).paddingOnly(top: 16)
          ],
        ).safeArea,
      ),
      onWillPop: () async {
        Get.back();
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
      ).onClick(onclick).paddingOnly(
            top: screenHPadding16.sh(),
            bottom: screenHPadding16.sh(),
          ),
    ).paddingOnly(
      left: screenWPadding16.sw(),
      right: screenWPadding16.sw(),
    );
  }
}
