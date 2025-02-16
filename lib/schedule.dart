import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'constants.dart';
import 'data.dart';
import 'duty_data.dart';
import 'duty_json.dart';
import 'rss_clean.dart';
import 'rss_schedule.dart';
import 'schedule_data.dart';
import 'scheduledetails.dart';
import 'sizes.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  String counter = "";
  bool counterOwnTeam = false;
  ScheduleData data = ScheduleData.instance;
  DutyData dutyData = DutyData.instance;
  String dutyTeam = "";
  JsonDuty jsonDuty = JsonDuty();
  List listOfDuties = [
    {'date': '', 'counter': '', 'referee': ''}
  ];
  List listOfItems = [
    {'date': '', 'time': '', 'game': '', 'hall': '', 'street': '', 'postal': ''}
  ];
  String referee = "";
  RssSchedule rss = RssSchedule();
  Sizes sizes = Sizes.instance;

  Future getData() async {
    DateTime tempDate;
    await rss.getSchedule();
    await jsonDuty.getDuty(true);

    setState(() {
      listOfItems = data.getGames();
      listOfDuties = dutyData.getGameData();
      if (listOfItems[0]["game"].toString().startsWith("AETOS")) {
        if (listOfDuties.isNotEmpty) {
          if (listOfDuties[0]["date"] != null) {
            tempDate = DateFormat("yyyy-MM-dd").parse(listOfDuties[0]["date"]);
            if (tempDate.difference(DateTime.now()).inDays >= 0) {
              if ((listOfItems[0]["game"].toString().split(' - ')[1] !=
                  "AETOS ${team.currentTeam}")) {
                counter = listOfDuties[0]['counter'];
                counterOwnTeam = listOfItems[0]["game"]
                    .toString()
                    .startsWith("AETOS $counter");
                referee = listOfDuties[0]['referee'];
                dutyTeam = listOfDuties[0]['duty'];
              }
            }
          }
        }
      }
    });
  }

  @override
  initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants().colorBackground,
        appBar: AppBar(
          toolbarHeight: sizes.heightToolbar,
          backgroundColor: Constants().colorBackground,
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back,
              size: 0.05 * sizes.screenHeight,
              color: Constants().colorTitle,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text(
            "PROGRAMMA",
            style: TextStyle(
                color: Constants().colorTitle,
                fontSize: sizes.sizeFontTitle,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            separator(),
            GestureDetector(
              onTap: () {
                ScheduleDetails().scheduleDetails(
                    context, 0, listOfItems, counter, referee, dutyTeam);
              },
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        listOfItems[0]['date'],
                        style: TextStyle(
                            color: Constants().colorSchedule,
                            fontSize: sizes.sizeFontSchedule,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        listOfItems[0]['time'] == "0:00"
                            ? ""
                            : listOfItems[0]['time'],
                        style: TextStyle(
                            color: Constants().colorSchedule,
                            fontSize: sizes.sizeFontSchedule,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text(
                    listOfItems[0]['game'],
                    style: TextStyle(
                        color: Constants().colorSchedule,
                        fontSize: sizes.sizeFontSchedule,
                        fontWeight: FontWeight.bold),
                  ),
                  Visibility(
                    visible: counter != "",
                    child: SizedBox(
                      height: 0.01 * sizes.screenHeight,
                    ),
                  ),
                  Visibility(
                    visible: counter != "",
                    child: Text(
                      "Teller: $counter",
                      style: TextStyle(
                          color: counterOwnTeam
                              ? Constants().colorTitle
                              : Constants().colorSchedule,
                          fontSize: sizes.sizeFontSchedule,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Visibility(
                    visible: referee != "",
                    child: Text(
                      "Scheidsrechter: $referee",
                      style: TextStyle(
                          color: Constants().colorSchedule,
                          fontSize: sizes.sizeFontSchedule,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Visibility(
                    visible: dutyTeam != "",
                    child: Text(
                      "Zaalwacht: $dutyTeam",
                      style: TextStyle(
                          color: Constants().colorSchedule,
                          fontSize: sizes.sizeFontSchedule,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 0.01 * sizes.screenHeight,
                  ),
                  Text(
                    RssClean().clean(listOfItems[0]['hall']),
                    style: TextStyle(
                        color: Constants().colorSchedule,
                        fontSize: sizes.sizeFontSchedule,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    RssClean().clean(listOfItems[0]['street']),
                    style: TextStyle(
                        color: Constants().colorSchedule,
                        fontSize: sizes.sizeFontSchedule,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    listOfItems[0]['postal'],
                    style: TextStyle(
                        color: Constants().colorSchedule,
                        fontSize: sizes.sizeFontSchedule,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            separator(),
            Expanded(
                child: ListView.builder(
                    itemCount: listOfItems.length - 1,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              ScheduleDetails().scheduleDetails(
                                  context, index + 1, listOfItems, "", "", "");
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  listOfItems[index + 1]['date'],
                                  style: TextStyle(
                                      color: Constants().colorSchedule,
                                      fontSize: sizes.sizeFontSchedule,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  listOfItems[index]['time'] == "0:00"
                                      ? ""
                                      : listOfItems[index + 1]['time'],
                                  style: TextStyle(
                                      color: Constants().colorSchedule,
                                      fontSize: sizes.sizeFontSchedule,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              ScheduleDetails().scheduleDetails(
                                  context, index + 1, listOfItems, "", "", "");
                            },
                            child: Text(
                              listOfItems[index + 1]['game'],
                              style: TextStyle(
                                  color: Constants().colorSchedule,
                                  fontSize: sizes.sizeFontSchedule,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          separator(),
                        ],
                      );
                    }))
          ],
        ));
  }

  Divider separator() {
    return Divider(
      indent: 0.05 * sizes.screenWidth,
      endIndent: 0.05 * sizes.screenWidth,
      color: Constants().colorTitle,
    );
  }
}
