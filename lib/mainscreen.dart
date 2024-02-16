import 'package:flutter/material.dart';
import 'data.dart';
import 'duty.dart';
import 'game.dart';
import 'ranking.dart';
import 'rss.dart';
import 'schedule.dart';
import 'settingsscreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  bool enableDuty = true;
  bool enableGame = true;
  bool enableRanking = true;
  bool enableSchedule = true;

  Team team = Team();
  TeamInfo teamInfo = TeamInfo();

  @override
  void initState() {
    super.initState();
    team.currentTeam;
    getRSS(teamInfo.getRanking(team.currentTeam));
    //   getSchedule(teamInfo.getRanking(team.currentTeam));
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = 0.8 * screenWidth;
    double spacingButtons = 0.02 * screenHeight;
    return GestureDetector(
      onDoubleTap: () {
        debugPrint("easter");
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF731816),
        appBar: AppBar(
          centerTitle: true,
          actions: [
            GestureDetector(
              child: Icon(
                Icons.more_vert,
                color: const Color(0xFF00AADE),
                size: 0.12 * MediaQuery.of(context).size.width,
              ),
              onTap: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 100),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return const SettingsScreen();
                        }));
              },
            ),
          ],
          title: GestureDetector(
            child: Text(
              "TEAM ${team.currentTeam}",
              style: const TextStyle(
                  color: Color(0xFF00AADE),
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
/*
              onTap: () {
                team.alternativeTeam;
                setState(() {
                  getRSS(teamInfo.getRanking(team.alternativeTeam));
                });
              }
*/
          ),
          backgroundColor: const Color(0xFF731816),
          elevation: 0,
        ),
        body: Column(
          children: [
            Container(
              color: const Color(0xFF731816),
              height: 0.8 * screenHeight,
              width: screenWidth,
              child: Column(
                children: [
                  Container(height: spacingButtons),
                  ElevatedButton(
                    onPressed: enableRanking
                        ? () {
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(milliseconds: 100),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return const Ranking();
                                    }));
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(buttonWidth, 90),
                        shape: const StadiumBorder(),
                        side: const BorderSide(color: Colors.black, width: 4),
                        backgroundColor: const Color(0xFFF9B234)),
                    child: const Padding(
                      padding: EdgeInsets.all(28),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          "STAND",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(height: spacingButtons),
                  ElevatedButton(
                    onPressed: enableSchedule
                        ? () {
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(milliseconds: 100),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return const Schedule();
                                    }));
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(buttonWidth, 90),
                        shape: const StadiumBorder(),
                        side: const BorderSide(color: Colors.black, width: 4),
                        backgroundColor: const Color(0xFFF9B234)),
                    child: const Padding(
                      padding: EdgeInsets.all(28),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          "PROGRAMMA",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(height: spacingButtons),
                  ElevatedButton(
                    onPressed: enableGame
                        ? () {
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(milliseconds: 100),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return Game(
                                        listOfItems: data.getTeams(),
                                      );
                                    }));
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(buttonWidth, 90),
                        shape: const StadiumBorder(),
                        side: const BorderSide(color: Colors.black, width: 4),
                        backgroundColor: const Color(0xFFF9B234)),
                    child: const Padding(
                      padding: EdgeInsets.all(28),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          "WEDSTRIJD",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(height: spacingButtons),
                  Container(height: spacingButtons),
                  ElevatedButton(
                    onPressed: enableDuty
                        ? () {
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(milliseconds: 100),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return Duty(
                                        listOfItems: data.getTeams(),
                                      );
                                    }));
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(buttonWidth, 90),
                        shape: const StadiumBorder(),
                        side: const BorderSide(color: Colors.black, width: 4),
                        backgroundColor: const Color(0xFFF9B234)),
                    child: const Padding(
                      padding: EdgeInsets.all(28),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          "ZAALDIENST",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
