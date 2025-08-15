import 'package:aetos/constants.dart';
import 'package:flutter/material.dart';

import 'data.dart';
import 'sizes.dart';

class SelectTeam extends StatefulWidget {
  const SelectTeam({super.key});

  @override
  State<SelectTeam> createState() => _SelectTeamState();
}

class _SelectTeamState extends State<SelectTeam> {
  Sizes sizes = Sizes.instance;
  TeamInfo teamInfo = TeamInfo();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants().colorBackground,
      appBar: AppBar(
        toolbarHeight: sizes.heightToolbar,
        backgroundColor: Constants().colorBackground,
      ),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
          ),
          itemCount: teamInfo.teamsInfo.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                team.set(teamInfo.teamsInfo[index][0]);
                setState(() {});
              },
              onLongPress: () {
                team.set(teamInfo.teamsInfo[index][0]);
                setState(() {});
              },
              child: Card(
                color: team.currentTeam == teamInfo.teamsInfo[index][0]
                    ? Constants().colorTitle
                    : Constants().colorButton,
                child: Center(
                    child: Text(
                  teamInfo.teamsInfo[index][0],
                  style: TextStyle(
                      color: team.currentTeam == teamInfo.teamsInfo[index][0]
                          ? Constants().colorAetosAmber
                          : Constants().colorAetosMaroon,
                      fontSize: sizes.sizeFontSelectTeamButton,
                      fontWeight: FontWeight.bold),
                )),
              ),
            );
          }),
    );
  }
}
