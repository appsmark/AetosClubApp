import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';
import 'data.dart';
import 'duty.dart';
import 'easter_egg.dart';
import 'information.dart';
import 'ranking.dart';
import 'results.dart';
import 'rss_ranking.dart';
import 'rss_schedule.dart';
import 'schedule.dart';
import 'select_team.dart';
import 'sizes.dart';
import 'version.dart';
import 'version_switch.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  EasterEgg easterEgg = EasterEgg.instance;
  RssRanking rssRanking = RssRanking();
  RssSchedule rssSchedule = RssSchedule();
  Sizes sizes = Sizes.instance;
  Team team = Team();
  TeamInfo teamInfo = TeamInfo();
  Version version = Version.instance;
  List<String> items = [];
  late String dropdownvalue;
  VersionSwitch versionSwitch = VersionSwitch.instance;

  @override
  void initState() {
    super.initState();
    version.updateDialog(context);
    team.currentTeam;
    dropdownvalue = team.currentTeam;
    for (int index = 0; index < teamInfo.teamsInfo.length; index++) {
      items.add(teamInfo.teamsInfo[index][0]);
    }
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    setState(() {});
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
        if (easterEgg.trigger()) {
          versionSwitch.switchState();
        }
        setState(() {});
      },
      child: Scaffold(
        backgroundColor: sizes.colorBackground,
        appBar: AppBar(
          toolbarHeight: sizes.heightToolbar,
          centerTitle: true,
          title: GestureDetector(
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
                          return const SelectTeam();
                        }));
              },
              child: Text(
                "TEAM ${team.currentTeam}",
                style: TextStyle(
                    backgroundColor: Constants().colorBackground,
                    color: versionSwitch.newVersion
                        ? Colors.black
                        : sizes.colorTitle,
                    fontWeight: FontWeight.bold,
                    fontSize: sizes.sizeFontTitle),
              )),
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
                    height: spacingButtons,
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
                  Container(
                    height: 2 * spacingButtons,
                  ),
                  Visibility(
                    visible:
                        false, // team.currentTeam != "XZ1",///////////////////////////
                    child: ElevatedButton(
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
                                  return Duty();
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
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return Information();
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
                                "INFORMATIE",
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
          ],
        ),
      ),
    );
  }
}
