import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class FmImage extends StatelessWidget {
  double? height;
  double? width;
  double? size;
  ImageType type;
  String path;
  BoxShape shape;
  BoxFit? fit;
  Color? color;
  BorderRadius radius;
  String? errorImage;

  FmImage(
    this.height,
    this.width,
    this.size,
    this.type,
    this.path,
    this.shape,
    this.fit,
    this.radius, {
    this.color,
    this.errorImage,
    super.key,
  });

  factory FmImage.fileImage({
    required String path,
    double? size,
    double? height,
    double? width,
    BoxShape? shape,
    BoxFit? fit,
    BorderRadius? radius,
  }) {
    return FmImage(
      height,
      width,
      size ?? 20,
      ImageType.file,
      path,
      shape ?? BoxShape.circle,
      fit,
      radius ?? BorderRadius.circular(0),
    );
  }

  factory FmImage.networkImage(
      {required String path,
      double? size,
      double? height,
      double? width,
      BoxShape? shape,
      BoxFit? fit,
      BorderRadius? radius,
      String? errorImage,
      String? placeHolderImage}) {
    return FmImage(
      height,
      width,
      size ?? 80,
      ImageType.Netwrok,
      path,
      shape ?? BoxShape.circle,
      fit,
      errorImage: errorImage,
      radius ?? BorderRadius.circular(0),
    );
  }

  factory FmImage.assetImage({
    required String path,
    double? size,
    double? height,
    double? width,
    BoxShape? shape,
    BoxFit? fit,
    Color? color,
    BorderRadius? radius,
  }) {
    return FmImage(
      height,
      width,
      size,
      ImageType.Asset,
      path,
      shape ?? BoxShape.rectangle,
      fit,
      radius ?? BorderRadius.circular(0),
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (type == ImageType.Netwrok) {
      return Container();
    }

    if (type == ImageType.Asset) {
      return shape == BoxShape.circle
          ? ClipOval(
              child: Image.asset(
                path,
                height: height ?? size,
                width: width ?? size,
                fit: fit,
                color: color,
              ),
            )
          : ClipRRect(
              borderRadius: radius,
              child: Image.asset(
                path,
                height: height ?? size,
                width: width ?? size,
                fit: fit,
                color: color,
              ),
            );
    }

    if (type == ImageType.file) {
      return shape == BoxShape.circle
          ? ClipOval(
              child: Image.file(
                File(path),
                height: height ?? size,
                width: width ?? size,
                fit: fit,
              ),
            )
          : ClipRRect(
              borderRadius: radius,
              child: Image.file(
                File(path),
                height: height ?? size,
                width: width ?? size,
                fit: fit,
              ),
            );
    }

    return Container();
  }
}

enum ImageType { Asset, Netwrok, file }
