import 'package:flutter/material.dart';

import 'data.dart';
import 'duty_data.dart';
import 'duty_json.dart';
import 'rss_clean.dart';
import 'sizes.dart';

class Duty extends StatefulWidget {
  final List listOfItems;

  const Duty({super.key, required this.listOfItems});

  @override
  State<Duty> createState() => _DutyState();
}

class _DutyState extends State<Duty> {
  int i = 0;
  Sizes sizes = Sizes.instance;
  JsonDuty duty = JsonDuty();
  DutyData data = DutyData.instance;
  RssClean rssClean = RssClean();

  Future getData() async {
    await duty.getDuty(false);
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
          if (data.data.isNotEmpty)
            Expanded(
                child: ListView.builder(
                    itemCount: data.data.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      if (data.data[index]['duty'] != team.currentTeam) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  rssClean.clean(data.data[index]['date']),
                                  style: TextStyle(
                                      color: sizes.colorSchedule,
                                      fontSize: sizes.sizeFontSchedule,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  data.data[index]['hometeam'] == "CMV"
                                      ? "${data.data[index]['time']} - ${data.data[index]['endtime']}"
                                      : data.data[index]['time'],
                                  style: TextStyle(
                                      color: sizes.colorSchedule,
                                      fontSize: sizes.sizeFontSchedule,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Text(
                              "Sporthal ${data.data[index]['hall']}",
                              style: TextStyle(
                                  color: sizes.colorSchedule,
                                  fontSize: sizes.sizeFontSchedule,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              data.data[index]['hometeam'] == "CMV"
                                  ? "CMV wedstrijden"
                                  : rssClean.clean(
                                      "${data.data[index]['hometeam']} - ${data.data[index]['visitor']}"),
                              style: TextStyle(
                                  color: sizes.colorSchedule,
                                  fontSize: sizes.sizeFontSchedule,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Fluiten: ${data.data[index]['referee']}",
                              style: TextStyle(
                                  color: team.currentTeam ==
                                          data.data[index]['referee']
                                      ? sizes.colorTitle
                                      : sizes.colorSchedule,
                                  fontSize: sizes.sizeFontSchedule,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Tellen: ${data.data[index]['counter']}",
                              style: TextStyle(
                                  color: team.currentTeam ==
                                          data.data[index]['counter']
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
                                  rssClean.clean(data.data[index]['date']),
                                  style: TextStyle(
                                      color: sizes.colorSchedule,
                                      fontSize: sizes.sizeFontSchedule,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "${data.data[index]['time']} - ${data.data[index]['endtime']}",
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
                              "Zaalwacht: ${data.data[index]['duty']}",
                              style: TextStyle(
                                  color: team.currentTeam ==
                                          data.data[index]['duty']
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
          if (data.data.isEmpty)
            Text(
              "GEEN DIENST",
              style: TextStyle(
                  color: sizes.colorSchedule,
                  fontSize: 1.5 * sizes.sizeFontSchedule,
                  fontWeight: FontWeight.bold),
            ),
        ]));
  }

  Divider separator() {
    return Divider(
      indent: 0.05 * sizes.screenWidth,
      endIndent: 0.05 * sizes.screenWidth,
      color: sizes.colorTitle,
    );
  }
}
