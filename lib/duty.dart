import 'package:flutter/material.dart';

import 'constants.dart';
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
        backgroundColor: Constants().colorBackground,
        body: Column(children: [
          separator(),
          GestureDetector(
            onTap: () {
              //          popupRanking(context);
            },
            child: /*pointsInfo.isNotEmpty
                ? pointsInfo[3]
                    ? Text(
                        "Stand Aetos punten: Doel behaald",
                        style: TextStyle(
                            color: Constants().colorTitle,
                            fontSize: sizes.sizeFontSchedule,
                            fontWeight: FontWeight.bold),
                      )
                    : Text(
                        "Stand Aetos punten: ${pointsInfo[1]} van ${pointsInfo[2]}",
                        style: TextStyle(
                            color: Constants().colorTitle,
                            fontSize: sizes.sizeFontSchedule,
                            fontWeight: FontWeight.bold),
                      )
                : */
                Text(""),
          ),
//          separator(),
          if (dutyData.data.isNotEmpty)
            Expanded(
                child: ListView.builder(
                    itemCount: dutyData.data.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      if ((dutyData.data[index]['duty'] == team.currentTeam) &&
                          (dutyData.data[index].length == 5)) {
                        // Zaalwacht
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  rssClean.clean(dutyData.data[index]['date']),
                                  style: TextStyle(
                                      color: Constants().colorSchedule,
                                      fontSize: sizes.sizeFontSchedule,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "${dutyData.data[index]['time']} - ${dutyData.data[index]['endtime']}",
                                  style: TextStyle(
                                      color: Constants().colorSchedule,
                                      fontSize: sizes.sizeFontSchedule,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Text(
                              "Sporthal ${dutyData.data[index]['hall']}",
                              style: TextStyle(
                                  color: Constants().colorSchedule,
                                  fontSize: sizes.sizeFontSchedule,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Zaalwacht: ${dutyData.data[index]['duty']}",
                              style: TextStyle(
                                  color: team.currentTeam ==
                                          dutyData.data[index]['duty']
                                      ? Constants().colorTitle
                                      : Constants().colorSchedule,
                                  fontSize: sizes.sizeFontSchedule,
                                  fontWeight: FontWeight.bold),
                            ),
                            separator(),
                          ],
                        );
                      } else {
                        if ((dutyData.data[index]['referee'] ==
                                team.currentTeam) ||
                            (dutyData.data[index]['counter'] ==
                                team.currentTeam) ||
                            dutyData.data[index]['hometeam']
                                .toString()
                                .contains("VolleyStars")) {
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    rssClean
                                        .clean(dutyData.data[index]['date']),
                                    style: TextStyle(
                                        color: Constants().colorSchedule,
                                        fontSize: sizes.sizeFontSchedule,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    dutyData.data[index]['hometeam']
                                            .toString()
                                            .contains("VolleyStars")
                                        ? dutyData.data[index]['time'] == "null"
                                            ? ""
                                            : "${dutyData.data[index]['time']} - ${dutyData.data[index]['endtime']}"
                                        : dutyData.data[index]['time'],
                                    style: TextStyle(
                                        color: Constants().colorSchedule,
                                        fontSize: sizes.sizeFontSchedule,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Text(
                                "Sporthal ${dutyData.data[index]['hall']}",
                                style: TextStyle(
                                    color: Constants().colorSchedule,
                                    fontSize: sizes.sizeFontSchedule,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                dutyData.data[index]['hometeam']
                                        .toString()
                                        .contains("VolleyStars")
                                    ? "Volley Stars wedstrijden"
                                    : rssClean.clean(
                                        "${dutyData.data[index]['hometeam']} - ${dutyData.data[index]['visitor']}"),
                                style: TextStyle(
                                    color: Constants().colorSchedule,
                                    fontSize: sizes.sizeFontSchedule,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Fluiten: ${dutyData.data[index]['referee']}",
                                style: TextStyle(
                                    color: team.currentTeam ==
                                            dutyData.data[index]['referee']
                                        ? Constants().colorTitle
                                        : Constants().colorSchedule,
                                    fontSize: sizes.sizeFontSchedule,
                                    fontWeight: FontWeight.bold),
                              ),
                              Visibility(
                                visible: dutyData.data[index]['counter'] != "",
                                child: Text(
                                  "Tellen: ${dutyData.data[index]['counter']}",
                                  style: TextStyle(
                                      color: team.currentTeam ==
                                              dutyData.data[index]['counter']
                                          ? Constants().colorTitle
                                          : Constants().colorSchedule,
                                      fontSize: sizes.sizeFontSchedule,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              separator(),
                            ],
                          );
                        } else {
                          return Column();
                        }
                      }
                    })),
/*
          if (dutyData.data.isEmpty)
            Text(
              "GEEN DIENST",
              style: TextStyle(
                  color: Constants().colorSchedule,
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
      color: Constants().colorTitle,
    );
  }

  Future<void> popupRanking(BuildContext context) {
    pointsData.getRanking();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Constants().colorRanking,
          title: Text(
            "ONDERLINGE STAND\nAETOS PUNTEN",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Constants().colorTitle,
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
                                  ? Constants().colorBackground
                                  : Constants().colorTitle,
                              fontSize: sizes.tablet
                                  ? 0.015 * sizes.screenHeight
                                  : 0.025 * sizes.screenHeight,
                              fontWeight: FontWeight.bold),
                        ),
                        /*
                        Spacer(),
                        Text(
                          "${(-100 * pointsData.ranking[index][1]).round()}%           ",
                          style: TextStyle(
                              color: pointsData.ranking[index][1] < 0
                                  ? Constants().colorBackground
                                  : Constants().colorTitle,
                              fontSize: sizes.tablet
                                  ? 0.015 * sizes.screenHeight
                                  : 0.025 * sizes.screenHeight,
                              fontWeight: FontWeight.bold),
                        ),
                        */
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
