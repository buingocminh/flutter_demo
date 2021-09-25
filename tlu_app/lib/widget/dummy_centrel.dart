import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    savelist["start"]=startDate.toString();
    savelist["end"]=endDate.toString();
    print(savelist);
    setState(() {
      isloading = true;
    });
    await list.AddSchedule(savelist["name"], savelist["time"], savelist["room"],
            savelist["start"], savelist["end"], savelist["teacher"])
        .then((res) => setState(() {
              isloading = false;
            }));
  }

  void getfile() async {
    await  list.GetList().then((_) => null);
  }

  var startDate, endDate;
  Map <String,dynamic> savelist =  {
    "name": null,
    "room": null,
    "start": null,
    "end": null,
    "teacher": null,
    "time": null
  };

  void _Showdate(date) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime(2050))
        .then((value) => setState(() {
              if (date == "start") {
                startDate = value;
                savelist["start"] = value as String;
              } else {
                endDate = value;
                savelist["end"] = value as String;
              }
            }));
    print(savelist);
  }



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
                    Row(
                      children: [
                        Text((startDate == null)
                            ? "startdate"
                            : DateFormat("dd-MM-yyyy").format(startDate)),
                        ElevatedButton(
                            onPressed: () => _Showdate("start"),
                            child: Text("date"))
                      ],
                    ),
                    Row(
                      children: [
                        Text((endDate == null)
                            ? "enddate"
                            : DateFormat("dd-MM-yyyy").format(endDate)),
                        ElevatedButton(
                            onPressed: () => _Showdate("end"),
                            child: Text("date"))
                      ],
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
