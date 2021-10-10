import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tlu_app/blocs/today_list_bloc.dart';
import 'package:tlu_app/model/schedules_list.dart';
import 'package:tlu_app/pages/home_page.dart';
void main() {
  final Schedules_list schedules_list= Schedules_list();
  runApp( MyApp(list: schedules_list));
}

class MyApp extends StatelessWidget {
  final Schedules_list list;
  const MyApp({Key? key , required this.list}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TLU Schedule',
      home: BlocProvider(
        create: ( context) => TodayListBloc(schedules_list: list),
        child: const Home(),
      ),
      routes: {},
    );
  }
}


