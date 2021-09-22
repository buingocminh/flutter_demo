import 'package:equatable/equatable.dart';
abstract class TodayListEvent extends Equatable{
 const TodayListEvent();
}
class TodayListEventBegin extends TodayListEvent{
  const TodayListEventBegin();
@override
  // TODO: implement props
  List<Object?> get props => [];
}