
import 'dart:convert';

import 'package:intl/intl.dart';

import './schedule.dart';
import 'package:http/http.dart' as http;

class Schedules_list {
  List<Schedule> schedulesList = [];
  // List get schedules_list {
  //   return _schedulesList.toList();
  // }

  
  List<Schedule> GetListfromday( String dayint){
    List<Schedule> list = [];
    var day = DateTime.parse(dayint);
    schedulesList.forEach((schedule) {
       if (schedule.startDate.isBefore(day)&&schedule.endDate.isAfter(day))  list.add(schedule) ;
    },);
    print(list);
    return list;
  }
  DateTime getfinalDay (){
    DateTime finalDay= DateTime.parse("0000-00-00") ;
    schedulesList.forEach((element) {
      if (element.endDate.isBefore(finalDay)) finalDay=element.endDate;
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
      var schedule =Schedule(
          nameSubject: value["nameSubject"],
          room: value["room"],
          timeBegin: value["timeBegin"],
          startDate: value["startDate"],
          endDate: value["endDate"],
          dayAction: value["dayAction"]);
      schedule.id=scheduleId;
      list.add(schedule);
    });
    schedulesList = list;
  }
  // void convert(){;
  //   print(DateFormat("dd/MM/yyyy").format(DateTime.parse("2020-10-10")));
  // }
  Future<bool> AddSchedule(name, time, room, start, end, dayAction) async {
    final res = await http.post(Uri.parse(url),
        body: jsonEncode({
          "nameSubject": name,
          "room": room,
          "startDate": start,
          "endDate": end,
          "imeBegin":time,
          "dayAction": dayAction
        }));
    if (res.statusCode == 200)
      return true;
    else
      return false;
  }
}
