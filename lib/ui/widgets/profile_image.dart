import 'package:flutter/material.dart';
import 'package:freeme/globle.dart';

import 'package:flutter/material.dart';

class ProfileImageWidget extends StatelessWidget {
  double height;
  double width;
  int verticlePadding = 0;
  int horizontalPadding = 0;
  GestureTapCallback? onCameraClick;
  String? imageUrl;

  ProfileImageWidget(this.height, this.width,
      {Key? key,
      this.verticlePadding = 0,
      this.horizontalPadding = 0,
      this.onCameraClick,
      this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        imageUrl != null && imageUrl!.isNotEmpty
            ? imageUrl.isHttpUrl
                ? _httpImage()
                : _imageFromFile()
            : _defaultImage(),
        onCameraClick != null ? _cameraIcon() : Container()
      ],
    );
  }

  Widget _httpImage() {
    return SizedBox(
      height: height.sh(),
      width: width.sw(),
      child: FmImage.networkImage(
        path: imageUrl ?? "",
        fit: BoxFit.fitWidth,
      ),
    );
  }

  Widget _imageFromFile() {
    return Container(
      height: height.sh(),
      width: width.sw(),
      decoration: const BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
      child: FmImage.fileImage(
        path: imageUrl ?? "",
        fit: BoxFit.fitWidth,
      ),
    );
  }

  Widget _defaultImage() {
    return Container(
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
    );
  }

  Widget _cameraIcon() {
    return Container(
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
    ).onTap(onCameraClick ?? () {}).positioned(
          right: 0,
          bottom: 0,
        );
  }
}
