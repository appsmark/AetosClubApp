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
        /*
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            size: 0.05 * sizes.screenHeight,
            color: Constants().colorTitle,
          ),
          onTap: () {
   //         Navigator.pop(context);
          },
        ),
        */
        /*
        centerTitle: true,
        title: Text(
          "SELECTEER TEAM",
          style: TextStyle(
              color: Constants().colorTitle,
              fontSize: sizes.sizeFontTitle,
              fontWeight: FontWeight.bold),
        ),*/
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
                //        Navigator.pop(context);
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
                          ? Colors.black //Constants().colorTitle
                          : Colors.black, // Constants().colorBackground,
                      fontSize: sizes.sizeFontSelectTeamButton,
                      fontWeight: FontWeight.bold),
                )),
              ),
            );
          }),
    );
  }

  Divider separator() {
    return Divider(
      indent: 0.05 * sizes.screenWidth,
      endIndent: 0.05 * sizes.screenWidth,
      color: Constants().colorTitle,
    );
  }
}
