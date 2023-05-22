import 'package:flutter/material.dart';

import '../../constant/app_string.dart';

class FmText extends StatelessWidget {
  String? text;
  FontWeight? weight;
  double? fontSize;
  Color? fontColor;

  FmText(this.text, {
    Key? key,
    this.weight,
    this.fontColor,
    this.fontSize
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      style: TextStyle(
        color: fontColor ?? Colors.black,
        fontSize: fontSize ?? 14,
        fontFamily: sfPro,
        fontWeight: weight ?? FontWeight.normal),
    );
  }
}
