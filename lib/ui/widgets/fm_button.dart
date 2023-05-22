import 'package:flutter/material.dart';
import 'package:freeme/globle.dart';

class FmButton extends StatelessWidget {
  GestureTapCallback  ontap;
  double? width;
  String? name;
  double? height;
  double? fontSize;
  double? radius;
  Color? color;
  Color? textColor;
  Widget? child;

  FmButton({
    required this.ontap,
    this.width,
    this.name,
    this.height = 45,
    this.fontSize,
    this.radius,
    this.color,
    super.key,
    this.textColor,this.child
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        ontap();
        FocusScope.of(context).unfocus();

      },
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 5),
          color: color??buttonColor,
          border: Border.all(color: Colors.black)
        ),
        child: child ??  (name ?? "").text(
          fontSize: fontSize,
          fontColor: textColor ??Colors.black,
        ).center,
      ),
    );
  }
}
