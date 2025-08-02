import 'package:flutter/material.dart';

import 'constants.dart';
import 'data.dart';
import 'duty.dart';
//import 'information.dart';
import 'pdf.dart';
import 'ranking.dart';
import 'results.dart';
import 'schedule.dart';
import 'select_team.dart';
import 'sizes.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  // Index to keep track of the selected tab
  int _selectedIndex = 1;
  Sizes sizes = Sizes.instance;
  Team team = Team();

  final List<Widget> widgetOptions = const [
    SelectTeam(),
    Schedule(),
    Ranking(),
    Results(),
    Duty(),
    // Information(),
    PDFviewing(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/images/logo.png",
              height: 0.5 * sizes.heightToolbar,
            ),
          ),
          /*
            title: Text(
              "", // "TEAM ${team.currentTeam}",
              style: TextStyle(
                backgroundColor: Constants().colorBackground,
                color: Constants().colorTitle,
                fontWeight: FontWeight.bold,
                //      fontSize: sizes.sizeFontTitle,
              ),
            )*/
          //        backgroundColor: Colors.green,
        ),
        body: Center(
          child: widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Team',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_rounded),
              label: 'Programma',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart), // format_list_numbered),
              label: 'Stand',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.format_list_numbered),
              label: 'Uitslagen',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.task),
              label: 'Taken',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book),
              label: 'Info',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Constants().colorAetosBlue,
          unselectedItemColor: Constants().colorAetosMaroon,
          backgroundColor: Constants().colorAetosAmber,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
