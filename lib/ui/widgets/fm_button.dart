import 'package:flutter/material.dart';
import 'package:freeme/globle.dart';

class FmButton extends StatelessWidget {
  GestureTapCallback ontap;
  double? width;
  String? name;
  double? height;
  Widget? child;
  ButtonType type;
  Color? textColor;
  Color? borderColor;
  String? assetPath;

  ///this will only work in rounded button//last one

  FmButton(
      {required this.ontap,
      this.width,
      this.name,
      this.height = 54,
      super.key,
      this.textColor,
      this.borderColor,
      this.assetPath,
      this.type = ButtonType.greenRectangle,
      this.child});

  @override
  Widget build(BuildContext context) {
    if (type == ButtonType.greenRectangle) {
      return GestureDetector(
        onTap: () => onTapClick(context),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: buttonGreenColor,
            border: Border.all(
              color: borderColor ?? Colors.black,
              width: 1,
            ),
          ),
          child: child ??
              (name ?? "")
                  .text(
                      fontSize: 18,
                      fontColor: textColor ?? Colors.black,
                      weight: FontWeight.w500)
                  .center,
        ),
      );
    } else if (type == ButtonType.greenCircular) {
      return GestureDetector(
        onTap: () => onTapClick(context),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: buttonGreenColor,
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
          ),
          child: child ??
              (name ?? "")
                  .text(
                      fontSize: 18,
                      fontColor: Colors.black,
                      weight: FontWeight.w500)
                  .center,
        ),
      );
    } else if (type == ButtonType.yellow) {
      return GestureDetector(
        onTap: () => onTapClick(context),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: yellowButtonColor,
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
          ),
          child: child ??
              (name ?? "")
                  .text(
                      fontSize: 18,
                      fontColor: Colors.black,
                      weight: FontWeight.w500)
                  .center,
        ),
      );
    } else if (type == ButtonType.red) {
      return GestureDetector(
        onTap: () => onTapClick(context),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: redButtonColor,
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
          ),
          child: child ??
              (name ?? "")
                  .text(
                      fontSize: 18,
                      fontColor: Colors.black,
                      weight: FontWeight.w500)
                  .center,
        ),
      );
    } else if (type == ButtonType.rounded) {
      return assetPath != null
          ? GestureDetector(
              onTap: () => onTapClick(context),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: backGroundGreenColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                child: FmImage.assetImage(
                  path: assetPath!,
                  width: 20,
                  height: 20,
                ).paddingOnly(
                  top: 14.sh(),
                  bottom: 14.sh(),
                  left: 14.sw(),
                  right: 14.sw(),
                ),
              ),
            )
          : Container();
    } else if (type == ButtonType.fullGreen) {
      return GestureDetector(
        onTap: () => onTapClick(context),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: buttonGreenColor.withOpacity(0.25),
            border: Border.all(
              color: darkGreenColor2,
              width: 1,
            ),
          ),
          child: child ??
              (name ?? "")
                  .text(
                    fontSize: 18,
                    fontColor: darkGreenColor2,
                  )
                  .center,
        ),
      );
    } else if (type == ButtonType.delete) {
      return GestureDetector(
        onTap: () => onTapClick(context),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            border: Border.all(
              color: redColor,
              width: 1,
            ),
          ),
          child: child ??
              (name ?? "")
                  .text(
                    fontSize: 18,
                    fontColor: redColor,
                weight: FontWeight.w500
                  )
                  .center,
        ),
      );
    }
    return Container();
  }

  onTapClick(BuildContext context) {
    ontap();
    FocusScope.of(context).unfocus();
  }
}

enum ButtonType {
  greenRectangle,
  greenCircular,
  yellow,
  red,
  rounded,
  fullGreen,
  delete
}
