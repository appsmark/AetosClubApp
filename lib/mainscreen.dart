import 'package:flutter/material.dart';

import 'beach.dart';
import 'beach_data.dart';
import 'data.dart';
import 'duty.dart';
import 'game.dart';
import 'login.dart';
import 'ranking.dart';
import 'results.dart';
import 'rss_ranking.dart';
import 'rss_schedule.dart';
import 'schedule.dart';
//import 'settingsscreen.dart';
import 'sizes.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  BeachData beachData = BeachData.instance;
  RssRanking rssRanking = RssRanking();
  RssSchedule rssSchedule = RssSchedule();
  Sizes sizes = Sizes.instance;
  Team team = Team();
  TeamInfo teamInfo = TeamInfo();
  List<String> items = [];
  late String dropdownvalue;

  @override
  void initState() {
    super.initState();
    team.currentTeam;
    dropdownvalue = team.currentTeam;
    for (int index = 0; index < teamInfo.teamsInfo.length; index++) {
      items.add(teamInfo.teamsInfo[index][0]);
    }
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
        debugPrint("easter egg");
      },
      child: Scaffold(
        backgroundColor: sizes.colorBackground,
        appBar: AppBar(
          toolbarHeight: sizes.heightToolbar,
          centerTitle: true,
          title: DropdownButton(
            underline: const SizedBox(),
            dropdownColor: sizes.colorSelection,
            value: dropdownvalue,
            autofocus: true,
            iconSize: 0.0,
            items: items.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(
                  items == "BEACH"
                      ? "   BEACH"
                      : items.length < 3
                          ? " TEAM $items"
                          : "TEAM $items",
                  style: TextStyle(
                      color: sizes.colorTitle, fontSize: sizes.sizeFontTitle),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                team.set(newValue);
                dropdownvalue = newValue!;
                if (dropdownvalue == "BEACH") {
                  if (beachData.access) {
                    beachData.enabled = true;
                  } else {
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
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return const Login();
                            }));
                  }
                } else {
                  beachData.enabled = false;
                  teamInfo.getSchedule(team.currentTeam);
                  teamInfo.getRanking(team.currentTeam);
                }
              });
            },
          ),
          backgroundColor: sizes.colorBackground,
          elevation: 0,
        ),
        body: Column(
          children: [
            if (beachData.enabled && !beachData.access)
              Container(
                color: sizes.colorBackground,
                height: 0.8 * screenHeight,
                width: screenWidth,
                child: Column(
                  children: [
                    Container(height: spacingButtons),
                    ElevatedButton(
                      onPressed: () {
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
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return const Login();
                                }));
                      },
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
                            "INLOGGEN BEACH",
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
            if (beachData.enabled && beachData.access)
              Container(
                color: sizes.colorBackground,
                height: 0.8 * screenHeight,
                width: screenWidth,
                child: Column(
                  children: [
                    Container(height: spacingButtons),
                    ElevatedButton(
                      onPressed: () {
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
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return const Beach();
                                }));
                      },
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
                            "RESERVERINGEN",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: sizes.sizeFontButton,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        beachData.setAccess(false);
                      },
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
                            "UITLOGGEN",
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
            if (!beachData.enabled)
              Container(
                color: sizes.colorBackground,
                height: 0.8 * screenHeight,
                width: screenWidth,
                child: Column(
                  children: [
                    Container(height: spacingButtons),
                    ElevatedButton(
                      onPressed: () {
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
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return const Ranking();
                                }));
                      },
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
                      onPressed: () {
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
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return const Schedule();
                                }));
                      },
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
                      onPressed: () {
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
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return const Game();
                                }));
                      },
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
                    ElevatedButton(
                      onPressed: () {
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
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return const Results();
                                }));
                      },
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
                            "UITSLAGEN",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: sizes.sizeFontButton,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 2 * spacingButtons,
                    ),
                    ElevatedButton(
                      onPressed: () {
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
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return Duty(
                                    listOfItems: data.getTeams(),
                                  );
                                }));
                      },
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
