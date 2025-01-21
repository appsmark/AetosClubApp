import 'package:flutter/material.dart';

import 'data.dart';
import 'duty_data.dart';
import 'duty_json.dart';
import 'points_data.dart';
import 'points_json.dart';
import 'rss_clean.dart';
import 'sizes.dart';

class Duty extends StatefulWidget {
  const Duty({super.key});

  @override
  State<Duty> createState() => _DutyState();
}

class _DutyState extends State<Duty> {
  int i = 0;
  Sizes sizes = Sizes.instance;
  JsonDuty duty = JsonDuty();
  DutyData dutyData = DutyData.instance;
  JsonPoints points = JsonPoints();
  PointsData pointsData = PointsData.instance;
  List pointsInfo = [];
  RssClean rssClean = RssClean();

  Future getData() async {
    dutyData.clear();
    await duty.getDuty(false);
    pointsData.clear();
    await points.getPoints();
    pointsInfo = pointsData.get(team.currentTeam);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: sizes.colorBackground,
        appBar: AppBar(
          toolbarHeight: sizes.heightToolbar,
          backgroundColor: sizes.colorBackground,
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back,
              size: 0.05 * sizes.screenHeight,
              color: sizes.colorTitle,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text(
            "ZAALDIENST",
            style: TextStyle(
                color: sizes.colorTitle,
                fontSize: sizes.sizeFontTitle,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(children: [
          separator(),
          GestureDetector(
            onTap: () {
              popupRanking(context);
            },
            child: pointsInfo.isNotEmpty
                ? pointsInfo[3]
                    ? Text(
                        "Stand Aetos punten: Doel behaald",
                        style: TextStyle(
                            color: sizes.colorTitle,
                            fontSize: sizes.sizeFontSchedule,
                            fontWeight: FontWeight.bold),
                      )
                    : Text(
                        "Stand Aetos punten: ${pointsInfo[1]} van ${pointsInfo[2]}",
                        style: TextStyle(
                            color: sizes.colorTitle,
                            fontSize: sizes.sizeFontSchedule,
                            fontWeight: FontWeight.bold),
                      )
                : Text(""),
          ),
          separator(),
          if (dutyData.data.isNotEmpty)
            Expanded(
                child: ListView.builder(
                    itemCount: dutyData.data.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      if (dutyData.data[index]['duty'] != team.currentTeam) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  rssClean.clean(dutyData.data[index]['date']),
                                  style: TextStyle(
                                      color: sizes.colorSchedule,
                                      fontSize: sizes.sizeFontSchedule,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  dutyData.data[index]['hometeam'] == "CMV"
                                      ? "${dutyData.data[index]['time']} - ${dutyData.data[index]['endtime']}"
                                      : dutyData.data[index]['time'],
                                  style: TextStyle(
                                      color: sizes.colorSchedule,
                                      fontSize: sizes.sizeFontSchedule,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Text(
                              "${dutyData.data[index]['hall']}",
                              style: TextStyle(
                                  color: sizes.colorSchedule,
                                  fontSize: sizes.sizeFontSchedule,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              dutyData.data[index]['hometeam'] == "CMV"
                                  ? "CMV wedstrijden"
                                  : rssClean.clean(
                                      "${dutyData.data[index]['hometeam']} - ${dutyData.data[index]['visitor']}"),
                              style: TextStyle(
                                  color: sizes.colorSchedule,
                                  fontSize: sizes.sizeFontSchedule,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Fluiten: ${dutyData.data[index]['referee']}",
                              style: TextStyle(
                                  color: team.currentTeam ==
                                          dutyData.data[index]['referee']
                                      ? sizes.colorTitle
                                      : sizes.colorSchedule,
                                  fontSize: sizes.sizeFontSchedule,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Tellen: ${dutyData.data[index]['counter']}",
                              style: TextStyle(
                                  color: team.currentTeam ==
                                          dutyData.data[index]['counter']
                                      ? sizes.colorTitle
                                      : sizes.colorSchedule,
                                  fontSize: sizes.sizeFontSchedule,
                                  fontWeight: FontWeight.bold),
                            ),
                            separator(),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  rssClean.clean(dutyData.data[index]['date']),
                                  style: TextStyle(
                                      color: sizes.colorSchedule,
                                      fontSize: sizes.sizeFontSchedule,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "${dutyData.data[index]['time']} - ${dutyData.data[index]['endtime']}",
                                  style: TextStyle(
                                      color: sizes.colorSchedule,
                                      fontSize: sizes.sizeFontSchedule,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Text(
                              "Sporthal Middachtensingel",
                              style: TextStyle(
                                  color: sizes.colorSchedule,
                                  fontSize: sizes.sizeFontSchedule,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Zaalwacht: ${dutyData.data[index]['duty']}",
                              style: TextStyle(
                                  color: team.currentTeam ==
                                          dutyData.data[index]['duty']
                                      ? sizes.colorTitle
                                      : sizes.colorSchedule,
                                  fontSize: sizes.sizeFontSchedule,
                                  fontWeight: FontWeight.bold),
                            ),
                            separator(),
                          ],
                        );
                      }
                    })),
/*
          if (dutyData.data.isEmpty)
            Text(
              "GEEN DIENST",
              style: TextStyle(
                  color: sizes.colorSchedule,
                  fontSize: 1.5 * sizes.sizeFontSchedule,
                  fontWeight: FontWeight.bold),
            ),
*/
        ]));
  }

  Divider separator() {
    return Divider(
      indent: 0.05 * sizes.screenWidth,
      endIndent: 0.05 * sizes.screenWidth,
      color: sizes.colorTitle,
    );
  }

  Future<void> popupRanking(BuildContext context) {
    pointsData.getRanking();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: sizes.colorRanking,
          title: Text(
            "ONDERLINGE STAND\nAETOS PUNTEN",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: sizes.colorTitle,
                fontSize: sizes.tablet
                    ? 0.015 * sizes.screenHeight
                    : 0.025 * sizes.screenHeight,
                fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            SizedBox(
              height: 0.6 * sizes.screenHeight,
              width: 0.8 * sizes.screenWidth,
              child: ListView.builder(
                  itemCount: pointsData.ranking.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "           ${pointsData.ranking[index][0]}",
                          style: TextStyle(
                              color: pointsData.ranking[index][1] < 0
                                  ? sizes.colorBackground
                                  : sizes.colorTitle,
                              fontSize: sizes.tablet
                                  ? 0.015 * sizes.screenHeight
                                  : 0.025 * sizes.screenHeight,
                              fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Text(
                          "${(-100 * pointsData.ranking[index][1]).round()}%           ",
                          style: TextStyle(
                              color: pointsData.ranking[index][1] < 0
                                  ? sizes.colorBackground
                                  : sizes.colorTitle,
                              fontSize: sizes.tablet
                                  ? 0.015 * sizes.screenHeight
                                  : 0.025 * sizes.screenHeight,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    );
                  }),
            )
          ],
        );
      },
    );
  }
}
