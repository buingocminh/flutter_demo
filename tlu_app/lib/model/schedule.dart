import 'dart:math';

class Schedule {
  int id = Random().nextInt(100);
  final String nameSubject;
  late final String nameClass;
  final String room;
  late final int numberOfCredits;
  final DateTime startDate;
  final DateTime endDate;
  final String timeBegin;
  final int dayAction;
  late final String teacher;

  Schedule({
    required this.nameSubject,
    required this.room,
    required this.startDate,
    required this.endDate,
    required this.timeBegin,
    required this.dayAction}) {

  }

}
