import 'package:flutter/material.dart';

import 'rss_schedule.dart';
import 'schedule_data.dart';
import 'sizes.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  ScheduleData data = ScheduleData.instance;
  List listOfItems = [
    {'date': '', 'time': '', 'game': '', 'hall': '', 'street': '', 'postal': ''}
  ];
  RssSchedule rss = RssSchedule();
  Sizes sizes = Sizes.instance;

  Future getData() async {
    await rss.getSchedule();
    setState(() {
      listOfItems = data.getGames();
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
          backgroundColor: sizes.colorBackground,
          leading: BackButton(
            color: sizes.colorTitle,
          ),
          centerTitle: true,
          title: Text(
            "WEDSTRIJD",
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
                  listOfItems[0]['time'],
                  style: TextStyle(
                      color: sizes.colorSchedule,
                      fontSize: sizes.sizeFontSchedule,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 0.05 * sizes.screenHeight,
            ),
            Text(
              listOfItems[0]['game'],
              style: TextStyle(
                  color: sizes.colorSchedule,
                  fontSize: sizes.sizeFontSchedule,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 0.05 * sizes.screenHeight,
            ),
            Text(
              listOfItems[0]['hall'],
              style: TextStyle(
                  color: sizes.colorSchedule,
                  fontSize: sizes.sizeFontSchedule,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              listOfItems[0]['street'],
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
          ],
        ));
  }

  Text separator() {
    return Text(
      "---------------------------------------------------",
      style: TextStyle(
          color: sizes.colorSchedule, fontSize: sizes.sizeFontSchedule),
    );
  }
}
