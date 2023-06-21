import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ranking.dart';
import 'settingsscreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreen();

//  _AnchoredAdaptiveExampleState createState() =>   _AnchoredAdaptiveExampleState();
}

class _MainScreen extends State<MainScreen> {
  @override
  void initState() {
    super.initState();

    // Suppress statusbar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double buttonFontSize = 35;
    //0.8 * screenWidth;
    double buttonWidth = 0.8 * screenWidth;
    double spacingButtons = 0.02 * screenHeight;
    return Scaffold(
      backgroundColor: const Color(0xFF731816),
      appBar: AppBar(
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
        title: const Text(
          "TEAM H6",
          style: TextStyle(color: Color(0xFF00AADE), fontSize: 35),
        ),
        backgroundColor: const Color(0xFF731816),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            height: statusBarHeight,
            color: Colors.red,
          ),
          Container(
            color: const Color(0xFF731816),
            height: 0.8 * screenHeight,
            width: screenWidth,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Ranking()));
                  },
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
                        'STAND',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 45,
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
                        MaterialPageRoute(
                            builder: (context) => const Ranking()));
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(buttonWidth, 90),
                      shape: const StadiumBorder(),
                      side: const BorderSide(color: Colors.black, width: 4),
                      backgroundColor: const Color(0xFFF9B234)),
                  child: const Padding(
                    padding: EdgeInsets.all(28.0),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text('PROGRAMMA',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 35,
                          )),
                    ),
                  ),
                ),
                Container(height: spacingButtons),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Ranking()));
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(buttonWidth, 90),
                      shape: const StadiumBorder(),
                      side: const BorderSide(color: Colors.black, width: 4),
                      backgroundColor: const Color(0xFFF9B234)),
                  child: const Padding(
                    padding: EdgeInsets.all(28.0),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text('WEDSTRIJD',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 35,
                          )),
                    ),
                  ),
                ),
                Container(height: 2 * spacingButtons),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Ranking()));
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(buttonWidth, 90),
                      shape: const StadiumBorder(),
                      side: const BorderSide(color: Colors.black, width: 4),
                      backgroundColor: const Color(0xFFF9B234)),
                  child: const Padding(
                    padding: EdgeInsets.all(28.0),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text('ZAALDIENST',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 35,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
