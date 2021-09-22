import 'dart:convert';

import './schedule.dart';
import 'package:http/http.dart'as http;
class Schedules_list {
  var _schedulesList = [];

  List get schedules_list {
    return _schedulesList.toList();
  }
  static const url="https://testproject-htminhk-default-rtdb.asia-southeast1.firebasedatabase.app/Schedule.json";
  Future<void> GetList() async {

  }
  Future<void>AddSchedule(name,room,time,start,end, teacher )async{
    http.post(Uri.parse(url),body: jsonEncode({
      "name": name,
      "room":room,
      "start":start,
      "end":end,
      "teacher":teacher
    }));
  }
}