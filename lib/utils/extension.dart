import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../constant/app_string.dart';

extension extOnDouble on num {
  sh() {
    return toDouble();
  }

  sw() {
    return toDouble();
  }

  get paddingHorizontal {
    return EdgeInsets.symmetric(horizontal: toDouble());
  }

  get paddingVerticle {
    return EdgeInsets.symmetric(horizontal: toDouble());
  }
}

extension ExtOnDynamic on dynamic {
  get debugPrint {
    if (kDebugMode) {
      print("--->(@) ${this.toString()}");
    }
  }

  get printLine {
    if (kDebugMode) {
      print(
          "--------------------------------------------------------------------------------------------->(*)");
    }
  }
}

extension extOnWidget on Widget {
 Widget get center {
    return Center(
      child: this,
    );
  }

  Widget onClick(GestureTapCallback ontap) {
    return InkWell(
      onTap: ontap,
      child: this,
    );
  }

  Widget onTap(GestureTapCallback ontap) {
    return GestureDetector(
      onTap: ontap,
      child: this,
    );
  }

  Widget positioned({
    double? bottom,
    double? top,
    double? left,
    double? right,
  }) {
    return Positioned(
      bottom: bottom,
      top: top,
      left: left,
      right: right,
      child: this,
    );
  }

  Widget get safeArea{
   return SafeArea(child: this);
  }
}

extension extOnString on String? {
  Widget text(
      {FontWeight? weight,
      Color? fontColor,
      double? fontSize,
      bool underLine = false}) {
    return Text(
      this ?? "",
      style: TextStyle(
        color: fontColor ?? Colors.black,
        fontSize: fontSize ?? 14,
        fontFamily: sfPro,
        decoration: underLine ? TextDecoration.underline : null,
        fontWeight: weight ?? FontWeight.normal,
      ),
    );
  }
}
