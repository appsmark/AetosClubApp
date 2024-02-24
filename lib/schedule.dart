import 'package:flutter/material.dart';

import 'rss_schedule.dart';
import 'schedule_data.dart';
import 'sizes.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  ScheduleData data = ScheduleData.instance;
  List listOfItems = [];
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
            Expanded(
                child: ListView.builder(
                    itemCount: listOfItems.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                listOfItems[index]['date'],
                                style: TextStyle(
                                    color: sizes.colorSchedule,
                                    fontSize: sizes.sizeFontSchedule,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                listOfItems[index]['time'],
                                style: TextStyle(
                                    color: sizes.colorSchedule,
                                    fontSize: sizes.sizeFontSchedule,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Text(
                            listOfItems[index]['game'],
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
