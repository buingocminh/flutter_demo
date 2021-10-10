import 'package:equatable/equatable.dart';
import 'package:tlu_app/model/schedule.dart';

abstract class TodayListState extends Equatable{
  const TodayListState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class TodayListStateInitial extends TodayListState{}
class TodayListStateLoading extends TodayListState{}
class TodayListStateFailure extends TodayListState{}
class TodayListStateSuccess extends TodayListState{
    final List<Schedule> scheduleToday;
    const TodayListStateSuccess({required this.scheduleToday});
    @override
  // TODO: implement props
  List<Object?> get props => [scheduleToday];
}

