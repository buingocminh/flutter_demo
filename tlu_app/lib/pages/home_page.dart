import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex =0;
  final tabs= [
    const Center(child: Text('Today')),
    const Center(child: Text('All')),
    Center(child: TextButton(onPressed: (){ print('object');}, child: co Text('1')),),
    const Center(child: Text('Setting')),
    const Center(child: Text('shit'))
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schedule Today') ,
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Today',
              backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.all_inbox),
              label: 'All',
              backgroundColor: Colors.red
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.note_add),
              label: 'Add',
              backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Setting',
              backgroundColor: Colors.blue
          ),
        ],
        onTap: (index){
          setState(() {
            _currentIndex= index;
          });
        },
      ),
    );
  }
}