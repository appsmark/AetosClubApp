import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data.dart';
import 'mainscreen.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  Team team = Team();

  @override
  void initState() {
    super.initState();
    team.get();
//    team.getStoredTeam();
    //   data.clear();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Team(),
      child: const MainScreen(),
    );
//    return const MainScreen();
  }
}
