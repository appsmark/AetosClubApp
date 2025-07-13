import 'package:aetos/pdf.dart';
import 'package:aetos/ranking.dart';
import 'package:aetos/schedule.dart';
import 'package:flutter/material.dart';

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

  final List<Widget> widgetOptions = const [
    Ranking(),
    Schedule(),
    PDFviewing(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'GeeksForGeeks',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
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
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
