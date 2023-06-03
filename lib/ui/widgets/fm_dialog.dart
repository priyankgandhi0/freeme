import 'package:flutter/material.dart';


Future fMDialog({
  required BuildContext context,
  required Widget child,
  double? horizontalPadding,
  Border? border
}) {
  return showDialog(
    context: context,
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
