import 'package:flutter/material.dart';
import 'package:freeme/globle.dart';

extension extOnString on String{
  errorSnack(BuildContext context) {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 6.0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: redColor,
          content: text(fontColor: Colors.white,fontSize: 16,weight: FontWeight.w500),
        ),
      );
    } catch (e) {
      e.debugPrint;
    }
  }

  successSnack(BuildContext context) {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          elevation: 6.0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
          content: text(fontColor: Colors.white,fontSize: 16,weight: FontWeight.w500),
        ),
      );
    } catch (e) {
      e.debugPrint;
    }
  }
}