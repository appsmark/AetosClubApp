import 'package:flutter/material.dart';

import 'rss_schedule.dart';
import 'schedule_data.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  ScheduleData data = ScheduleData.instance;
  List listOfItems = [];
  RssSchedule rss = RssSchedule();

  Future getData() async {
    await rss.getSchedule("");
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
        backgroundColor: const Color(0xFF731816),
        appBar: AppBar(
          backgroundColor: const Color(0xFF731816),
          leading: const BackButton(
            color: Color(0xFF00AADE),
          ),
          centerTitle: true,
          title: const Text(
            "PROGRAMMA",
            style: TextStyle(
                color: Color(0xFF00AADE),
                fontSize: 35,
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
                                style: const TextStyle(
                                    color: Color(0xFFF9B234), fontSize: 20),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                listOfItems[index]['time'],
                                style: const TextStyle(
                                    color: Color(0xFFF9B234), fontSize: 20),
                              ),
                            ],
                          ),
                          Text(
                            listOfItems[index]['game'],
                            style: const TextStyle(
                                color: Color(0xFFF9B234), fontSize: 20),
                          ),
                          separator(),
                        ],
                      );
                    }))
          ],
        ));
  }

  Text separator() {
    return const Text(
      "---------------------------------------------------",
      style: TextStyle(color: Color(0xFFF9B234), fontSize: 20),
    );
  }
}
