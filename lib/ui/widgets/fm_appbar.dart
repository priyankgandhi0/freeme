import 'package:flutter/material.dart';

import '../../globle.dart';

fMAppBar(
  String title, {
  GestureTapCallback? onBackClick,
  GestureTapCallback? onTrailingClick,
}) {
  return AppBar(
    backgroundColor: backGroundGreenColor,
    elevation: 0,
    automaticallyImplyLeading: false,
    title: title.text(weight: FontWeight.w600, fontSize: 20),
    centerTitle: true,
    leading: onBackClick != null
        ? FmImage.assetImage(
            path: Assets.iconsBackIcon,
            fit: BoxFit.fitWidth,
          ).onClick(onBackClick).paddingAll(
              screenHPadding16.sh(),
            )
        : null,
    actions: [
      onTrailingClick != null
          ? FmImage.assetImage(
              path: Assets.iconsEdit,
              fit: BoxFit.fitWidth,
            ).onClick(onTrailingClick).paddingAll(
                screenWPadding16.sw(),
              )
          : Container()
    ],
  );
}

fMAppBar2({
  String? title,
  String? description,
  GestureTapCallback? onBackClick,
  GestureTapCallback? onTrailingClick,
  required BuildContext context,
}) {
  return Container(
    height: 100,
    width: Get.width,
    color: backGroundGreenColor,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        onBackClick != null
            ? FmImage.assetImage(
                path: Assets.iconsBackIcon,
                fit: BoxFit.fitWidth,
                width: 20,
                height: 20,
              )
                .onClick(onBackClick ??
                    () {


                    })
                .paddingAll(
                  screenHPadding16.sh(),
                )
            : Container(
                width: 20,
              ).paddingOnly(
                right: screenWPadding16.sw(),
              ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              title.text(
                fontSize: 20,
                weight: FontWeight.w600,
              ),
              description.text(fontSize: 16)
            ],
          ).paddingOnly(
            bottom: 16,
          ),
        ),
        onTrailingClick != null
            ? FmImage.assetImage(
                path: Assets.iconsEdit,
                width: 20,
                height: 20,
                fit: BoxFit.contain,
              ).onClick(onTrailingClick ?? () {}).paddingOnly(
                  right: screenWPadding16.sw(),
                )
            : Container(
                width: 20,
              ).paddingOnly(
                right: screenWPadding16.sw(),
              )
      ],
    ),
  );
}
