
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
  
  var url =
      "https://testproject-htminhk-default-rtdb.asia-southeast1.firebasedatabase.app/Schedule.json";

  Future<void> GetList() async {
    final res = await http.get(Uri.parse(url));
    final datas = jsonDecode(res.body) as Map<String, dynamic>;
    final List<Schedule> list = [];
    datas.forEach((scheduleId, value) {
      list.add(Schedule(
          id: scheduleId,
          name: value["name"],
          room: value["room"],
          time: value["time"],
          startDate: value["start"],
          endDate: value["end"],
          teacher: value["abc"]));
    });
    schedulesList = list;
  }
  // void convert(){;
  //   print(DateFormat("dd/MM/yyyy").format(DateTime.parse("2020-10-10")));
  // }
  Future<bool> AddSchedule(name, time, room, start, end, teacher) async {
    final res = await http.post(Uri.parse(url),
        body: jsonEncode({
          "name": name,
          "room": room,
          "start": start,
          "end": end,
          "time":time,
          "teacher": teacher
        }));
    if (res.statusCode == 200)
      return true;
    else
      return false;
  }
}
