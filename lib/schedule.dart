import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'duty_data.dart';
import 'duty_json.dart';
import 'rss_clean.dart';
import 'rss_schedule.dart';
import 'schedule_data.dart';
import 'sizes.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  String counter = "";
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
              counter = listOfDuties[0]['counter'];
              referee = listOfDuties[0]['referee'];
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
            "PROGRAMMA",
            style: TextStyle(
                color: sizes.colorTitle,
                fontSize: sizes.sizeFontTitle,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            separator(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  listOfItems[0]['date'],
                  style: TextStyle(
                      color: sizes.colorSchedule,
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
                      color: sizes.colorSchedule,
                      fontSize: sizes.sizeFontSchedule,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text(
              listOfItems[0]['game'],
              style: TextStyle(
                  color: sizes.colorSchedule,
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
                    color: sizes.colorSchedule,
                    fontSize: sizes.sizeFontSchedule,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Visibility(
              visible: referee != "",
              child: Text(
                "Scheidsrechter: $referee",
                style: TextStyle(
                    color: sizes.colorSchedule,
                    fontSize: sizes.sizeFontSchedule,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Visibility(
              visible: dutyTeam != "",
              child: Text(
                "Zaalwacht: $dutyTeam",
                style: TextStyle(
                    color: sizes.colorSchedule,
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
                  color: sizes.colorSchedule,
                  fontSize: sizes.sizeFontSchedule,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              RssClean().clean(listOfItems[0]['street']),
              style: TextStyle(
                  color: sizes.colorSchedule,
                  fontSize: sizes.sizeFontSchedule,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              listOfItems[0]['postal'],
              style: TextStyle(
                  color: sizes.colorSchedule,
                  fontSize: sizes.sizeFontSchedule,
                  fontWeight: FontWeight.bold),
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
                              log("==========$index");
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  listOfItems[index + 1]['date'],
                                  style: TextStyle(
                                      color: sizes.colorSchedule,
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
                                      color: sizes.colorSchedule,
                                      fontSize: sizes.sizeFontSchedule,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            listOfItems[index + 1]['game'],
                            style: TextStyle(
                                color: sizes.colorSchedule,
                                fontSize: sizes.sizeFontSchedule,
                                fontWeight: FontWeight.bold),
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
      color: sizes.colorTitle,
    );
  }
}
