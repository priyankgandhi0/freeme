import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
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
      return CachedNetworkImage(
        imageUrl: path,
        fit: fit,
        color: Colors.white,
        imageBuilder: (context, imageprovider) {
          return Container(
            height: height ?? size,
            width: width ?? size,
            decoration: shape == BoxShape.circle
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageprovider,
                      fit: fit,
                    ),
                  )
                : BoxDecoration(
                    borderRadius: radius,
                    image: DecorationImage(
                      image: imageprovider,
                      fit: fit,
                    ),
                  ),
          );
        },
        placeholder: (context, url) => const CupertinoActivityIndicator(
          radius: 20,
          color: Colors.black,
        ),
        errorWidget: (context, url, error) {
          return Container(
            height: height ?? size,
            width: width ?? size,
            decoration: shape == BoxShape.circle
                ? const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.black)
                : BoxDecoration(borderRadius: radius, color: Colors.black),
            child: const Icon(
              Icons.error,
              color: Colors.grey,
              size: 30,
            ),
          );
        },
      );
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
