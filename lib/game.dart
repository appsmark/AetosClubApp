import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'constants.dart';
import 'duty_data.dart';
import 'duty_json.dart';
import 'rss_clean.dart';
import 'rss_schedule.dart';
import 'schedule_data.dart';
import 'sizes.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  DutyData dutyData = DutyData.instance;
  ScheduleData data = ScheduleData.instance;
  List listOfDuties = [
    {'date': '', 'counter': '', 'referee': ''}
  ];
  List listOfItems = [
    {'date': '', 'time': '', 'game': '', 'hall': '', 'street': '', 'postal': ''}
  ];
  RssClean rssClean = RssClean();
  RssSchedule rss = RssSchedule();
  Sizes sizes = Sizes.instance;
  JsonDuty duty = JsonDuty();
  String referee = "";
  String counter = "";

  Future getData() async {
    DateTime tempDate;
    await rss.getSchedule();
    await duty.getDuty(true);
    listOfItems = data.getGames();
    listOfDuties = dutyData.getGameData();
    counter = "";
    referee = "";
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
    setState(() {});
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
            "WEDSTRIJD",
            style: TextStyle(
                color: Constants().colorTitle,
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
            SizedBox(
              height: 0.05 * sizes.screenHeight,
            ),
            Text(
              listOfItems[0]['game'].replaceAll(RegExp(' -.*'), ''),
              style: TextStyle(
                  color: Constants().colorSchedule,
                  fontSize: sizes.sizeFontSchedule,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              listOfItems[0]['game'] == "" ? "" : "tegen",
              style: TextStyle(
                  color: Constants().colorSchedule,
                  fontSize: sizes.sizeFontSchedule,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              listOfItems[0]['game'].replaceAll(RegExp('.* - '), ''),
              style: TextStyle(
                  color: Constants().colorSchedule,
                  fontSize: sizes.sizeFontSchedule,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 0.05 * sizes.screenHeight,
            ),
            Visibility(
              visible: counter != "",
              child: Text(
                "Teller: $counter",
                style: TextStyle(
                    color: Constants().colorSchedule,
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
            SizedBox(
              height: 0.05 * sizes.screenHeight,
            ),
            Text(
              rssClean.clean(listOfItems[0]['hall']),
              style: TextStyle(
                  color: Constants().colorSchedule,
                  fontSize: sizes.sizeFontSchedule,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              rssClean.clean(listOfItems[0]['street']),
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
            separator(),
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
