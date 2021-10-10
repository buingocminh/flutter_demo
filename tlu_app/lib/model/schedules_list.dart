import 'dart:convert';
import 'package:intl/intl.dart';

import './schedule.dart';
import 'package:http/http.dart' as http;

class Schedules_list {
  List<Schedule> schedulesList = [];
  DateTime now =  DateTime.now();

  // List get schedules_list {
  //   return _schedulesList.toList();
  // }

  List<Schedule> GetListfromday(String dayint) {
    List<Schedule> list = [];
    var day = DateTime.parse(dayint);
    schedulesList.forEach(
      (schedule) {
        if (schedule.startDate.isBefore(day) && schedule.endDate.isAfter(day))
          list.add(schedule);
      },
    );
    return list;
  }

  DateTime getfinalDay() {
    DateTime finalDay = DateTime.parse("0000-00-00");
    schedulesList.forEach((element) {
      if (element.endDate.isBefore(finalDay)) finalDay = element.endDate;
    });
    return finalDay;
  }

  var url =
      "https://testproject-htminhk-default-rtdb.asia-southeast1.firebasedatabase.app/Schedule.json";

  Future<void> GetList() async {
    final res = await http.get(Uri.parse(url));
    final datas = jsonDecode(res.body) as Map<String, dynamic>;
    final List<Schedule> list = [];
    datas.forEach((scheduleId, value) {
      var schedule = Schedule(
          nameSubject: value["nameSubject"],
          room: value["room"],
          timeBegin: value["timeBegin"],
          startDate: value["startDate"],
          endDate: value["endDate"],
          dayAction: value["dayAction"]);
      schedule.id = scheduleId;
      list.add(schedule);
    });
    schedulesList = list;
  }
  Future<List<Schedule>> getListToday() async{
    final res = await http.get(Uri.parse(url));
    final datas = jsonDecode(res.body) as Map<String, dynamic>;
    final List<Schedule> list=[];
    datas.forEach((scheduleId, value) {
      print("vào đây");
      print(value["dayAction"]);
      print(DateFormat('EEEE').format(now));
      print(DateTime.parse(value["startDate"]));
      DateTime before= DateTime.parse(value["startDate"]);
      DateTime after =DateTime.parse(value["endDate"]);
      if( DateTime.parse(value["startDate"]).isBefore(now) && DateTime.parse(value["endDate"]).isAfter(now)) {
        print("ko lỗi");
      }
      if(DateFormat('EEEE').format(now)== value["dayAction"] ){
        print("vào đi");
        var schedule = Schedule(
            nameSubject: value["nameSubject"],
            room: value["room"],
            timeBegin: value["imeBegin"],
            startDate: DateTime.parse(value["startDate"]),
            endDate: DateTime.parse(value["endDate"]),
            dayAction: value["dayAction"]);
        schedule.id = scheduleId;
        list.add(schedule);
      }
    });
    return list;
  }

  // void convert(){;
  //   print(DateFormat("dd/MM/yyyy").format(DateTime.parse("2020-10-10")));
  // }
  Future<bool> addSchedule(name, time, room, start, end, dayAction) async {
    final res = await http.post(Uri.parse(url),
        body: jsonEncode({
          "nameSubject": name,
          "room": room,
          "startDate": start,
          "endDate": end,
          "imeBegin": time,
          "dayAction": dayAction
        }));
    if (res.statusCode == 200)
      return true;
    else
      return false;
  }
}
