import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'data.dart';
import 'root.dart';
import 'version_switch.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Suppress statusbar and navigation bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  Team team = Team();
  team.getStoredTeam();

  VersionSwitch versionSwitch = VersionSwitch.instance;
  versionSwitch.get();

  // Device orientation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(
            const MyApp(),
          ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 1),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                maintainState: false, builder: (context) => const Root())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xFFC1C1C1),
        child: const Center(
          child: Image(
              image: AssetImage('assets/splashscreen.png'),
              height: 1400, // Just a random value
              fit: BoxFit.fitWidth),
        ));
  }
}
