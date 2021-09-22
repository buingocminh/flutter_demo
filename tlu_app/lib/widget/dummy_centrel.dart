import 'package:flutter/material.dart';

import '../model/schedules_list.dart';
import '../model/schedule.dart';

class dummy extends StatefulWidget {
  const dummy({Key? key}) : super(key: key);

  @override
  _dummyState createState() => _dummyState();
}

class _dummyState extends State<dummy> {
  var isloading = false;
  final formkey = GlobalKey<FormState>();
  final list = Schedules_list();

  void callsomething() async {
    formkey.currentState!.save();
    setState(() {
      isloading = true;
    });
    await list.AddSchedule(savelist["name"], savelist["time"], savelist["room"],
            savelist["start"], savelist["end"], savelist["teacher"])
        .then((res) => setState(() {
              isloading = false;
            }));
  }
  void getfile(){
    list.GetList();
    print(list.schedules_list);
  }
  var savelist = {
    "name": "",
    "room": "",
    "start": "",
    "end": "end",
    "teacher": "",
    "time": ""
  };

  @override
  Widget build(BuildContext context) {
    return isloading
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
          child: Form(
              key: formkey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: "name"),
                    onSaved: (res) => savelist["name"] = res!,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Time"),
                    onSaved: (res) => savelist["time"] = res!,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Room"),
                    onSaved: (res) => savelist["room"] = res!,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Start"),
                    onSaved: (res) => savelist["start"] = res!,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "End"),
                    onSaved: (res) => savelist["end"] = res!,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Teacher"),
                    onSaved: (res) => savelist["teacher"] = res!,
                  ),
                  TextButton(onPressed: callsomething, child: Text("save")),
                  TextButton(onPressed: getfile, child: Text("get"))
                ],
              )),
        );
  }
}
