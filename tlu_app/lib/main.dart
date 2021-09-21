import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'TLU Schedule',
      home: Home(),
    );
  }
}
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
    const Center(child: Text('Add')),
    const Center(child: Text('Setting'))
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

