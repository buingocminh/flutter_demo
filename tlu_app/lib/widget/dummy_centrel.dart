import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/schedules_list.dart';

class dummy extends StatefulWidget {
  const dummy({Key? key}) : super(key: key);

  @override
  _dummyState createState() => _dummyState();
}

class _dummyState extends State<dummy> {
  var isloading = false;
  int valueChoose=2;
  final formkey = GlobalKey<FormState>();
  final list = Schedules_list();
  void callsomething() async {
    formkey.currentState!.save();
    savelist["DayAction"]= valueChoose;
    savelist["start"]=startDate.toString();
    savelist["end"]=startDate.toString();
    setState(() {
      isloading = true;
    });
    await list.addSchedule(savelist["name"], savelist["time"], savelist["room"],
            savelist["start"], savelist["end"], savelist["DayAction"])
        .then((res) => setState(() {
              isloading = false;
            }));
  }
  void getfile() async {
    await  list.GetList().then((_) => null);
  }
  var startDate = DateTime.now(), endDate= DateTime.now();
  Map <String,dynamic> savelist =  {
    "name": null,
    "room": null,
    "start": null,
    "end": null,
    "DayAction": null,
    "time": null
  };
  List<String> listItems =['Thứ 2','Thứ 3','Thứ 4','Thứ 5','Thứ 6','Thứ 7','Chủ nhật'];
  List<int> listValue=[2,3,4,5,6,7,0];
  // late int valueChoose=listValue[0];
  void _Showdate(date) {
    print(date);
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime(2050))
        .then((value) => setState(() {
              if (date == "start") {
                startDate = value!;
                // savelist["start"] = value as String;
              } else {
                endDate = value!;
                // savelist["end"] = value as String;
                print(endDate.toString());
              }
            }));
    // print(savelist["start"]);
  }
  Widget buildListPicker()=>SizedBox(

      child: DropdownButton<int>(
        value: valueChoose,
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 30,
        elevation: 16,
        style: const TextStyle(color: Colors.grey),
        underline: Container(
          height: 2,
          color: Colors.grey,
        ),
        onChanged: (int? newValue) {
          setState(() {
            valueChoose = newValue! ;
          });
        },
        items: listValue.map<DropdownMenuItem<int>>((int Svalue) {
          return DropdownMenuItem<int>(
            value: Svalue,
            child: Text("Thứ $Svalue", style: const TextStyle(fontSize: 20),),
          );
        }).toList(),
      )
  );
  @override
  Widget build(BuildContext context) {
    return isloading
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            labelText: "Môn học",
                        ),
                        onSaved: (res) => savelist["name"] = res!,
                      ),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                      TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            labelText: "Phòng học"),
                        onSaved: (res) => savelist["room"] = res!,
                      ),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                      TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            labelText: "Tiết"),
                        onSaved: (res) => savelist["time"] = res!,
                      ),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                      Row(
                        children: [
                          const Text('Ngày học:',style: TextStyle(fontSize: 20, color: Colors.grey),),
                          const Padding(padding: EdgeInsets.symmetric(horizontal: 15)),
                          buildListPicker()
                        ],
                      ),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                      Row(
                        children: [
                          const Text("Ngày bắt đầu:" ),
                          const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                           Expanded(
                            child: Text(DateFormat("dd-MM-yyyy").format(startDate)),
                          ),
                          ElevatedButton(
                              onPressed: () => _Showdate("start"),
                              child: const Icon(Icons.date_range_outlined))
                        ],
                      ),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                      Row(
                        children: [
                          const Text("Ngày kết thúc:" ),
                          const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                          Expanded(
                            child: Text(DateFormat("dd-MM-yyyy").format(endDate)),
                          ),
                          ElevatedButton(
                              onPressed: () => _Showdate("end"),
                              child: const Icon(Icons.date_range_outlined))
                        ],
                      ),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                      ElevatedButton(
                        child: const Text('Save'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.teal,
                          onPrimary: Colors.white,
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          minimumSize:  const Size(100, 40),
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        ),
                        onPressed: callsomething,
                      ),

                      ElevatedButton(
                        child: const Text('Get'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.teal,
                          onPrimary: Colors.white,
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          minimumSize:  const Size(100, 40),
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        ),
                        onPressed: getfile,
                      ),
                    ],
                  )),
            ),
          );
  }
}
