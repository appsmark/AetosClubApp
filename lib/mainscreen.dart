import 'package:flutter/material.dart';

import 'constants.dart';
import 'contact.dart';
import 'data.dart';
import 'duty.dart';
import 'info.dart';
import 'persistent.dart';
import 'ranking.dart';
//import 'results.dart';
import 'schedule.dart';
import 'select_team.dart';
import 'sizes.dart';
import 'version.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  // Index to keep track of the selected tab
  Persistent persistent = Persistent.instance;
  Sizes sizes = Sizes.instance;
  Team team = Team();
  Version version = Version.instance;
  int _selectedIndex = 1;

  final List<Widget> widgetOptions = const [
    SelectTeam(),
    Schedule(),
    Ranking(),
    Duty(),
    Info(),
    Contact(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      persistent.setMenuIndex(index);
    });
  }

  @override
  void initState() {
    _selectedIndex = persistent.menuIndex;
    version.updateDialog(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: sizes.heightToolbar,
          centerTitle: true,
          title: Image.asset(
            "assets/images/logo.png",
            height: 0.9 * sizes.heightToolbar,
          ),
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
              icon: Icon(Icons.format_list_numbered),
              label: 'Stand',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.task),
              label: 'Taken',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book),
              label: 'Info',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contact_emergency),
              label: 'Contact',
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
