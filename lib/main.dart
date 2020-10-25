import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: HrApp()));

class HrApp extends StatefulWidget {
  @override
  _HrAppState createState() => _HrAppState();
}

class _HrAppState extends State<HrApp> {
  int _selectedTabIndex = 0;

  List _pages = [
    Text("Home"),
    Text("Calendar"),
    Text("Account"),
  ];

  _changeIndex(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("codesundar"), backgroundColor: Colors.lightBlue[900]),
      body: Center(child: _pages[_selectedTabIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        onTap: _changeIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), title: Text("Calendar")),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), title: Text("My Account")),
        ],
      ),
    );
  }
}
