import 'package:flutter/material.dart';
import 'data.dart';
import 'rss.dart';

class Schedule extends StatefulWidget {
//  final List listOfItems;

//  const Schedule({Key? key, required this.listOfItems}) : super(key: key);
  const Schedule({Key? key}) : super(key: key);

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  var listOfItems = data.getGames();
  int i = 0;
  Team team = Team();
  TeamInfo teamInfo = TeamInfo();

  @override
  void initState() {
    super.initState();
    getSchedule(teamInfo.getSchedule(team.currentTeam));
    //teamInfo.getSchedule(team.currentTeam);
    listOfItems = data.getGames();
    //  debugPrint(listOfItems.toString());
  }

  @override
  Widget build(BuildContext context) {
    // listOfItems = data.getGames();
    // debugPrint(listOfItems.toString());
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
            Expanded(
                child: ListView.builder(
                    itemCount: listOfItems.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Text(
                        listOfItems[index].gameDate(),
                        style: const TextStyle(
                            color: Color(0xFFF9B234), fontSize: 20),
                      );
                    }))
          ],
        ));
  }
}
