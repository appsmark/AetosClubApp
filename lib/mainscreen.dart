import 'package:flutter/material.dart';
import 'data.dart';
import 'duty.dart';
import 'game.dart';
import 'ranking.dart';
import 'rss.dart';
import 'schedule.dart';
import 'settingsscreen.dart';
import 'sizes.dart';

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

  Sizes sizes = Sizes.instance;
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
    double buttonHeight = 0.1 * screenHeight;
    double buttonWidth = 0.8 * screenWidth;
    double paddingButton = 0.01 * screenHeight;
    double spacingButtons = 0.02 * screenHeight;
    return GestureDetector(
      onDoubleTap: () {
        debugPrint("easter");
      },
      child: Scaffold(
        backgroundColor: sizes.colorBackground,
        appBar: AppBar(
          centerTitle: true,
          actions: [
            GestureDetector(
              child: Icon(
                Icons.more_vert,
                color: sizes.colorTitle,
                size: sizes.sizeFontTitle,
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
              style: TextStyle(
                  color: sizes.colorTitle,
                  fontSize: sizes.sizeFontTitle,
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
          backgroundColor: sizes.colorBackground,
          elevation: 0,
        ),
        body: Column(
          children: [
            Container(
              color: sizes.colorBackground,
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
                        fixedSize: Size(buttonWidth, buttonHeight),
                        shape: const StadiumBorder(),
                        side: BorderSide(
                            color: Colors.black,
                            width: sizes.buttonBorderWidth),
                        backgroundColor: sizes.colorButton),
                    child: Padding(
                      padding: EdgeInsets.all(paddingButton),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          "STAND",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: sizes.sizeFontButton,
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
                        fixedSize: Size(buttonWidth, buttonHeight),
                        shape: const StadiumBorder(),
                        side: BorderSide(
                            color: Colors.black,
                            width: sizes.buttonBorderWidth),
                        backgroundColor: sizes.colorButton),
                    child: Padding(
                      padding: EdgeInsets.all(paddingButton),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          "PROGRAMMA",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: sizes.sizeFontButton,
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
                        fixedSize: Size(buttonWidth, buttonHeight),
                        shape: const StadiumBorder(),
                        side: BorderSide(
                            color: Colors.black,
                            width: sizes.buttonBorderWidth),
                        backgroundColor: sizes.colorButton),
                    child: Padding(
                      padding: EdgeInsets.all(paddingButton),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          "WEDSTRIJD",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: sizes.sizeFontButton,
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
                        fixedSize: Size(buttonWidth, buttonHeight),
                        shape: const StadiumBorder(),
                        side: BorderSide(
                            color: Colors.black,
                            width: sizes.buttonBorderWidth),
                        backgroundColor: sizes.colorButton),
                    child: Padding(
                      padding: EdgeInsets.all(paddingButton),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          "ZAALDIENST",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: sizes.sizeFontButton,
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
