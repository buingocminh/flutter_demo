import 'dart:convert';

import './schedule.dart';
import 'package:http/http.dart' as http;

class Schedules_list {
  List<Schedule> _schedulesList = [];

  List get schedules_list {
    return _schedulesList.toList();
  }

  var url =
      "https://testproject-htminhk-default-rtdb.asia-southeast1.firebasedatabase.app/Schedule.json";

  Future<void> GetList() async {
    final res = await http.get(Uri.parse(url));
    final datas = jsonDecode(res.body) as Map<String, dynamic>;
    final List<Schedule> list = [];
    print(jsonDecode(res.body));
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
    _schedulesList = list;
  }

  Future<bool> AddSchedule(name, time, room, start, end, teacher) async {
    final res = await http.post(Uri.parse(url),
        body: jsonEncode({
          "name": name,
          "room": room,
          "start": start,
          "end": end,
          "teacher": teacher
        }));
    if (res.statusCode == 200)
      return true;
    else
      return false;
  }
}
