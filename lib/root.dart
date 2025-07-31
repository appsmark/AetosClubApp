import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data.dart';
import 'mainscreen.dart';
import 'mainscreen_new.dart';
import 'sizes.dart';
import 'version_switch.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  Sizes sizes = Sizes.instance;
  Team team = Team();
  VersionSwitch versionSwitch = VersionSwitch.instance;

  @override
  void initState() {
    super.initState();
    team.currentTeam;
  }

  @override
  Widget build(BuildContext context) {
    sizes.setSizes(context);
    return ChangeNotifierProvider(
      create: (context) => Team(),
//      child: const MainScreen(),
      child: versionSwitch.newVersion ? MyStatefulWidget() : MainScreen(),
    );
  }
}
