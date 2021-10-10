import 'dart:math';


class Schedule {
  String id = Random().nextInt(100).toString();// sửa tạm
  final String nameSubject;
  late final String nameClass;
  final String room;
  late final int numberOfCredits;
  final DateTime startDate;
  final DateTime endDate;
  final String timeBegin;
  final String dayAction;
  late final String teacher;

  Schedule({
    required this.nameSubject,
    required this.room,
    required this.startDate,
    required this.endDate,
    required this.timeBegin,
    required this.dayAction});
  void data (){
    print(nameSubject+room+startDate.toString()+endDate.toString()+timeBegin+dayAction.toString());
  }
}
