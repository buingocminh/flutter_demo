
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tlu_app/blocs/today_list_bloc.dart';
import 'package:tlu_app/events/today_list_event.dart';
import 'package:tlu_app/states/today_list_state.dart';

class TodayPage extends StatefulWidget {
  const TodayPage({Key? key}) : super(key: key);

  @override
  _TodayPageState createState() => _TodayPageState();
}
class _TodayPageState extends State<TodayPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<TodayListBloc>(context).add(const TodayListEventBegin());
  }
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<TodayListBloc,TodayListState>(
       builder: (context,state){
          if(state is TodayListStateInitial){
            return const Center(child: CircularProgressIndicator());
          }
          if(state is TodayListStateLoading){
            return const Center(child: CircularProgressIndicator());
          }
          if(state is TodayListStateFailure){
            return const Center(
              child: Text('Cannot load Schedule from Server', style: TextStyle(fontSize: 22, color: Colors.red),),
            );
          }
          if(state is TodayListStateSuccess){
            if(state.scheduleToday.isEmpty){
              return const Center(
                child: Text('Nay đéo phải học đâu thằng lz', style: TextStyle(fontSize: 22, color: Colors.red),),
              );
            }
            return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: state.scheduleToday.length,
                itemBuilder: (BuildContext, index){
                  return Container(
                    margin: const EdgeInsets.only(bottom: 5,left: 10, right: 10,top: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.purple, Colors.red],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 8,
                          spreadRadius: 2,
                          offset: Offset(4, 4),
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,

                      children: [
                        Text(state.scheduleToday[index].timeBegin, style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white)),
                        const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(state.scheduleToday[index].nameSubject, style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),
                            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                             Row(
                               children: [
                                 const Icon(Icons.location_on,color: Colors.white60),
                                 const Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                                 Text(state.scheduleToday[index].room, style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white)),
                               ],
                             )
                          ],
                        )
                      ],
                    )
                  );
                }
            );
          }
          return const Center(child: Text('Other states..'));//never run this line, only fix warning.
       },
    );
  }
}
