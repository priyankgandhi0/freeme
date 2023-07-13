import 'package:flutter/material.dart';


Future fMDialog({
  required BuildContext context,
  required Widget child,
  double? horizontalPadding,
  Border? border,
  Color? barrierColor
}) {
  return showDialog(
    context: context,
    barrierColor: barrierColor ?? Colors.black54,
    builder: (_) => Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      insetPadding: horizontalPadding != null
          ? EdgeInsets.symmetric(horizontal: horizontalPadding)
          : EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: border
        ),
        child: child,
      ),
    ),
  );
}
