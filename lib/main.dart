import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hr/calendar.dart';
import 'package:hr/chat.dart';
import 'package:hr/constants/theme.dart';

void main() => runApp(MaterialApp(
      theme: defaultTargetPlatform == TargetPlatform.iOS ? kIOSTheme : kDefaultTheme,
      home: HrApp(),
    ));

class HrApp extends StatefulWidget {
  @override
  _HrAppState createState() => _HrAppState();
}

class _HrAppState extends State<HrApp> {
  int _selectedTabIndex = 0;

  List _pages = [
    Text("Home"),
    Calendar(),
    Chat(),
    Text("ff"),
  ];

  _changeIndex(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HR"), backgroundColor: Colors.lightBlue[900]),
      body: Center(child: _pages[_selectedTabIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _changeIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), title: Text("Calendar")),
          BottomNavigationBarItem(icon: Icon(Icons.chat), title: Text("Chat")),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), title: Text("My Account")),
        ],
      ),
    );
  }
}
