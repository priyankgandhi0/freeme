// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:freeme/main.dart';

void main() {

  test("test1", () {
    String ss = removeZeroFromAhed("01:00");
    expect(ss, "1:00");
  });


}

String removeZeroFromAhed(String? time){
  if(time!=null && time.isNotEmpty){
    if(time[0]=="0"){
      return time.substring(1,time.length);
    }else{
      return time;
    }
  }else{
    return "";
  }
}