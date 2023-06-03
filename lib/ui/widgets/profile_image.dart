import 'package:flutter/material.dart';
import 'package:freeme/globle.dart';

Widget profileImage(
  int height,
  int width, {
  int verticlePadding = 0,
  int horizontalPadding = 0,
  GestureTapCallback? onCameraClick,
}) {
  return Stack(
    children: [
      Container(
        height: height.sh(),
        width: width.sw(),
        decoration: const BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
        child: FmImage.assetImage(
          path: Assets.iconsUserIcon,
          fit: BoxFit.fitWidth,
        ).paddingOnly(
          left: horizontalPadding.sw(),
          right: horizontalPadding.sw(),
          top: verticlePadding.sh(),
          bottom: verticlePadding.sh(),
        ),
      ),
      onCameraClick != null
          ? Container(
              height: 44,
              width: 44,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Container(
                height: 38,
                width: 38,
                decoration: const BoxDecoration(
                  color: backGroundGreenColor,
                  shape: BoxShape.circle,
                ),
                child: FmImage.assetImage(
                  path: Assets.iconsCamera,
                  fit: BoxFit.fitWidth,
                ).paddingOnly(
                  left: 11.sw(),
                  right: 11.sw(),
                  top: 12.sh(),
                  bottom: 12.sh(),
                ),
              ).center,
            ).onTap(onCameraClick).positioned(
                right: 0,
                bottom: 0,
              )
          : Container()
    ],
  );
}
