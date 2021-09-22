import 'package:flutter/material.dart';

import '../model/schedules_list.dart';
class dummy extends StatelessWidget {
  const dummy({Key? key}) : super(key: key);
  void callsomething()
  
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(child: Text("abc"),onPressed: ()=> callsomething(),)
    );
  }
}
