// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:table_calendar/table_calendar.dart';

/// Example event class.
class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
    value: (item) => List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
  ..addAll({
    kToday: [
      Event('Today\'s Event 1'),
      Event('Today\'s Event 2'),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

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
