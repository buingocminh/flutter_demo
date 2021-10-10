import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tlu_app/events/today_list_event.dart';
import 'package:tlu_app/model/schedule.dart';
import 'package:tlu_app/model/schedules_list.dart';
import 'package:tlu_app/states/today_list_state.dart';

class TodayListBloc extends Bloc<TodayListEvent,TodayListState>{
  final Schedules_list schedules_list;
  TodayListBloc({required this.schedules_list}) : super(TodayListStateInitial());
  DateTime now = DateTime.now();
  @override
  Stream<TodayListState> mapEventToState(todayListEvent)  async*{
   if(todayListEvent is TodayListEventBegin){
      // yield TodayListStateLoading();
      try{
        // schedules_list.getListToday();
        final List<Schedule> listToday= await schedules_list.getListToday();
        yield TodayListStateSuccess(scheduleToday: listToday);
      }catch(exception){
        yield TodayListStateFailure();
      }
   }
  }
}