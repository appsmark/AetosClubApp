import 'package:flutter/material.dart';

import 'constants.dart';
import 'contact.dart';
import 'data.dart';
import 'duty.dart';
import 'hall_info.dart';
import 'info.dart';
import 'persistent.dart';
import 'ranking.dart';
import 'results.dart';
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
  HallInfo hallInfo = HallInfo.instance;
  Persistent persistent = Persistent.instance;
  Sizes sizes = Sizes.instance;
  Team team = Team();
  Version version = Version.instance;
  int _selectedIndex = 1;

  final List<Widget> widgetOptions = const [
    SelectTeam(),
    Schedule(),
    Ranking(),
    Results(),
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

  void listener() {
    setState(() {
      _selectedIndex = persistent.menuIndex;
    });
  }

  @override
  void initState() {
    team.addListener(listener);
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
          leading: Center(
            child: Text(
              " ${team.currentTeam}",
              style: TextStyle(
                fontSize: sizes.sizeFontTitle,
                fontWeight: FontWeight.bold,
                color: Constants().colorAetosBlue,
              ),
            ),
          ),
          title: GestureDetector(
            onTap: () {
              displayHallInfo(context);
            },
            child: Image.asset(
              "assets/images/logo.png",
              height: 0.9 * sizes.heightToolbar,
            ),
          ),
        ),
        body: Center(child: widgetOptions.elementAt(_selectedIndex)),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outline),
              label: 'Team',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_rounded),
              label: 'Rooster',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.format_list_numbered),
              label: 'Stand',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.scoreboard_outlined),
              label: 'Scores',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.task_outlined),
              label: 'Taken',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_outlined),
              label: 'Info',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contact_emergency_outlined),
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

  Future<void> displayHallInfo(BuildContext context) {
    double columnWidth = 0.06 * sizes.screenWidth;
    double columnWidthTeam = 0.45 * sizes.screenWidth;
    return showDialog(
      //   barrierColor: Colors.green,
      //   fullscreenDialog: true,
      context: context,
      builder: (BuildContext context) {
        hallInfo.get();
        return AlertDialog(
          backgroundColor: Constants().colorAetosMaroon,
          contentTextStyle: TextStyle(
            color: Constants().colorAetosBlue,
            fontSize: 0.01 * sizes.screenHeight,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.01 * sizes.screenHeight),
            side: BorderSide(
              color: Constants().colorAetosAmber,
              width: 0.005 * sizes.screenHeight,
            ),
          ),
          title: Text(
            "Middachtensingel\n${hallInfo.getDate()}",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Constants().colorAetosAmber,
              fontSize: 0.035 * sizes.screenHeight,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Table(
                  columnWidths: {
                    0: FixedColumnWidth(columnWidth),
                    1: FixedColumnWidth(columnWidthTeam),
                    //           2: FixedColumnWidth(columnWidth),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  border: TableBorder.all(
                    color: Constants().colorAetosBlue,
                    width: 0.001 * sizes.screenHeight,
                  ),
                  children: [
                    /*
                    TableRow(
                      children: [
                        TableCell(
                          child: Text(
                            "Tijd",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Constants().colorAetosAmber,
                              fontSize: sizes.sizeFontHallInfo,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TableCell(
                          child: Text(
                            "Wedstrijd",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Constants().colorAetosAmber,
                              fontSize: sizes.sizeFontHallInfo,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        /*
                        TableCell(
                          child: Text(
                            "Zaal\nwacht",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Constants().colorAetosAmber,
                              fontSize: sizes.sizeFontHallInfo,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        */
                      ],
                    ),*/
                    for (int i = 0; i < hallInfo.numberOfGames; i++)
                      TableRow(
                        children: [
                          TableCell(
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                hallInfo.getTime(i),
                                style: TextStyle(
                                  color: Constants().colorAetosAmber,
                                  fontSize: sizes.sizeFontHallInfo,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Text(
                              //                              "${hallInfo.getHomeTeam(i)}\nFluiter: ${hallInfo.getReferee(i)}\nTeller: ${hallInfo.getCounter(i)}",
                              "${hallInfo.getHomeTeam(i)}\nF: ${hallInfo.getReferee(i)}   T: ${hallInfo.getCounter(i)}   Z: ${hallInfo.getDutyTeam(i)}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Constants().colorAetosAmber,
                                fontSize: sizes.sizeFontHallInfo,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          /*
                          TableCell(
                            child: Text(
                              hallInfo.getDutyTeam(i),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Constants().colorAetosAmber,
                                fontSize: sizes.sizeFontHallInfo,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          */
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
          /*
          actions: <Widget>[
            TextButton(
              child: Text(
                'Sluit',
                style: TextStyle(
                  color: Constants().colorAetosMaroon,
                  fontSize: 0.025 * sizes.screenHeight,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],*/
        );
      },
    );
  }
}
