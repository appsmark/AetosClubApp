import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:flutter/services.dart';
import 'ranking.dart';
import 'settingsscreen.dart';
import 'data.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  bool enableSchedule = true;

  Team team = Team();

  @override
  void initState() {
    super.initState();

    // Suppress statusbar
    //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //      overlays: [SystemUiOverlay.bottom]);
  }

  @override
  Widget build(BuildContext context) {
//    debugPrint("Team retrieved = ${team.currentTeam}");
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = 0.8 * screenWidth;
    double spacingButtons = 0.02 * screenHeight;
    return Scaffold(
      backgroundColor: const Color(0xFF731816),
      appBar: AppBar(
        centerTitle: true,
        actions: [
          GestureDetector(
            child: const Icon(Icons.more_vert),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsScreen()));
            },
          ),
        ],
        title: Text(
          "TEAM ${team.currentTeam}",
          style: const TextStyle(color: Color(0xFF00AADE), fontSize: 35),
        ),
        /*
        title: Consumer<Team>(
            builder: (context, counter, child) => Text(
                  "TEAM ${counter.currentTeam}",
                  style:
                      const TextStyle(color: Color(0xFF00AADE), fontSize: 35),
                )),
        */
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
                ButtonMainScreen(
                  buttonWidth: buttonWidth,
                  text: "STAND",
                  buttonEnabled: enableSchedule,
                ),
                Container(height: spacingButtons),
                ButtonMainScreen(
                  buttonWidth: buttonWidth,
                  text: "PROGRAMMA",
                  buttonEnabled: false,
                ),
                Container(height: spacingButtons),
                ButtonMainScreen(
                  buttonWidth: buttonWidth,
                  text: "WEDSTRIJD",
                  buttonEnabled: false,
                ),
                Container(height: spacingButtons),
                Container(height: spacingButtons),
                ButtonMainScreen(
                  buttonWidth: buttonWidth,
                  text: "ZAALDIENST",
                  buttonEnabled: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonMainScreen extends StatelessWidget {
  const ButtonMainScreen(
      {super.key,
      required this.buttonWidth,
      required this.text,
      required this.buttonEnabled});

  final double buttonWidth;
  final String text;
  // ignore: prefer_typing_uninitialized_variables
  final buttonEnabled;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: buttonEnabled
          ? () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Ranking(
                            listOfItems: data.getTeams(),
                          )));
            }
          : null,
      style: ElevatedButton.styleFrom(
          fixedSize: Size(buttonWidth, 90),
          shape: const StadiumBorder(),
          side: const BorderSide(color: Colors.black, width: 4),
          backgroundColor: const Color(0xFFF9B234)),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 45,
            ),
          ),
        ),
      ),
    );
  }
}
