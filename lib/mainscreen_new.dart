import 'package:flutter/material.dart';

import 'easter_egg.dart';
import 'pdf.dart';
import 'ranking.dart';
import 'schedule.dart';
import 'version_switch.dart';

// Stateful widget to manage the
// state of the BottomNavigationBar
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidget();
}

class _MyStatefulWidget extends State<MyStatefulWidget> {
  // Index to keep track of the selected tab
  int _selectedIndex = 0;
  EasterEgg easterEgg = EasterEgg.instance;
  VersionSwitch versionSwitch = VersionSwitch.instance;

  final List<Widget> widgetOptions = const [
    Ranking(),
    Schedule(),
    PDFviewing(),
  ];

  void _onItemTapped(int index) {
    if (easterEgg.trigger()) {
      versionSwitch.switchState();
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'xxx',
          style: TextStyle(
            color: Colors.yellow,
          ),
        ),
//        backgroundColor: Colors.green,
      ),
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'TEAM',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'INFO',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_mail),
            label: 'Mail',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor:
            versionSwitch.newVersion ? Colors.amber[800] : Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
