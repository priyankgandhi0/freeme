import 'package:freeme/globle.dart';
import 'package:freeme/models/summery_model.dart';

class TableTowCalculation {
  String? date;
  int? oneX;
  int? oneFiveX;
  int? twoX;
  int? paidHours;
  String? grossWages;
  int mp = 0;

  TableTowCalculation.calculate(HourlySummary e) {
    oneX = calaculateTime(e) <= 8
        ? calaculateTime(e) != 0
            ? calaculateTime(e)
            : null
        : 8;
    if (calaculateTime(e) > 8) {
      if (calaculateTime(e) > 12) {
        oneFiveX = 4;
      } else {
        oneFiveX = (calaculateTime(e) - 8);
      }
    }
    twoX = (calaculateTime(e) > 12) ? (calaculateTime(e) - 12) : null;
    date = changeToMyFormat(e);
    paidHours =
        ((oneX ?? 0) + ((oneFiveX ?? 0) * 1.5) + ((twoX ?? 0) * 2)).toInt();

    if (e.paymentDetails?.rate != null &&
        e.paymentDetails?.rate != 0 &&
        e.paymentDetails?.totalHours != null &&
        e.paymentDetails?.totalHours != 0) {
      var perHourRate =  ((e.paymentDetails?.rate ?? 0) / (e.paymentDetails?.totalHours ?? 0));
      if(paidHours!=0 && perHourRate!=0){
        grossWages = "\$${((paidHours ?? 0)*perHourRate)} ";
      }
    }
    calculateMp(e);
  }

  void calculateMp(HourlySummary e) {
    if((!e.callTime.isNullOrEmpty) && (!e.firstMealStart.isNullOrEmpty)){
      DateTime callTime = convertToMyTimeFormat(e.callTime ?? "", e.date ?? "");
      DateTime firstMealStart = convertToMyTimeFormat(e.firstMealStart ?? "", e.date ?? "");
      Duration duration = firstMealStart.difference(callTime);
      if(duration.inHours>=6){
        mp = mp+1;
      }
    }

    if((!e.firstMealEnd.isNullOrEmpty) && (!e.secondMealStart.isNullOrEmpty)){
      DateTime firstMealEnd = convertToMyTimeFormat(e.firstMealEnd ?? "", e.date ?? "");
      DateTime secondMealStart = convertToMyTimeFormat(e.secondMealStart ?? "", e.date ?? "");
      Duration duration = secondMealStart.difference(firstMealEnd);
      if(duration.inHours>=6){
        mp = mp+1;
      }
    }
    if((!e.secondMealEnd.isNullOrEmpty) && (!e.wrap.isNullOrEmpty)){
      DateTime secondMealEnd = convertToMyTimeFormat(e.secondMealEnd ?? "", e.date ?? "");
      DateTime wrap = convertToMyTimeFormat(e.wrap ?? "", e.date ?? "");
      Duration duration = wrap.difference(secondMealEnd);
      if(duration.inHours>=6){
        mp = mp+1;
      }
    }
  }


  int calaculateTime(HourlySummary e) {
    if ((!e.callTime.isNullOrEmpty) && (!e.wrap.isNullOrEmpty)) {
      DateTime callTime = convertToMyTimeFormat(e.callTime ?? "", e.date ?? "");
      DateTime wrap = convertToMyTimeFormat(e.wrap ?? "", e.date ?? "");
      Duration duration = wrap.difference(callTime);
      if ((!e.firstMealStart.isNullOrEmpty) &&
          (!e.firstMealEnd.isNullOrEmpty)) {
        DateTime firstMealStart =
            convertToMyTimeFormat(e.firstMealStart ?? "", e.date ?? "");
        DateTime firstMealEnd =
            convertToMyTimeFormat(e.firstMealEnd ?? "", e.date ?? "");
        Duration firstMealDuration = firstMealEnd.difference(firstMealStart);
        duration =
            Duration(minutes: duration.inMinutes - firstMealDuration.inMinutes);
      }
      if ((!e.secondMealStart.isNullOrEmpty) &&
          (!e.secondMealEnd.isNullOrEmpty)) {
        DateTime secondMealStart =
            convertToMyTimeFormat(e.secondMealStart ?? "", e.date ?? "");
        DateTime secondMealEnd =
            convertToMyTimeFormat(e.secondMealEnd ?? "", e.date ?? "");
        Duration secondMealDuration = secondMealEnd.difference(secondMealStart);
        duration = Duration(
            minutes: duration.inMinutes - secondMealDuration.inMinutes);
      }
      return duration.inHours;
    }
    return 0;
  }

  DateTime convertToMyTimeFormat(String time, String date) {
    var now = date.split("-");
    int hour = int.parse(time.split(":").first.toString());
    int minute = int.parse(time.split(":").last.substring(0, 2));
    bool isPm = time.contains("PM") ? true : false;
    return DateTime.utc(
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
  }

  String changeToMyFormat(HourlySummary e) {
    return "${e.date?.split("-")[1]}/${e.date?.split("-").last}";
  }


}
