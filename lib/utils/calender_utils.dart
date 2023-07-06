// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:table_calendar/table_calendar.dart';


int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

DateTime? convertTo24Format(String time, String date) {
  if(time.isNotEmpty){
    var now = date.split("-");
    int hour = int.parse(time.split(":").first.toString());
    int minute = int.parse(time.split(":").last.substring(0, 2));
    bool isPm = time.contains("PM") ? true : false;
    var datTime = DateTime.utc(
        int.parse(now[0]),
        int.parse(now[1]),
        int.parse(now[2]),
        isPm
            ? hour != 12
            ? hour + 12
            : hour
            : hour == 12
            ? 0
            : hour,
        minute,
        0);
    var datTime2 = DateTime.utc(
        int.parse(now[0]),
        int.parse(now[1]),
        int.parse(now[2]),
        datTime.hour-1,minute-1,0
    );
    return datTime2;
  }

  return null;
 /* return DateTime.now();*/
}
