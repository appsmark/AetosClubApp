import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rss_dart/dart_rss.dart';

import 'data.dart';
import 'schedule_data.dart';

class RssSchedule {
  ScheduleData scheduleData = ScheduleData.instance;

  Future<bool> getSchedule(String group) async {
    var result = false;
    Client client = Client();
    TeamInfo teamInfo = TeamInfo();
    group = teamInfo.getSchedule(team.currentTeam);

    scheduleData.clear();

    await getRssFeed(client, group).then((value) {
      if (value.description!.isNotEmpty) {
        parseRSS(value);
      }
    });
    return result;
  }

  Future<RssFeed> getRssFeed(Client client, String group) async {
    Response response = Response('', 200);
    try {
      response = await client.get(Uri.parse(group));
    } catch (e) {
      debugPrint(e.toString());
    }
    if (response.body != "Not Found") {
      return RssFeed.parse(response.body);
    } else {
      return const RssFeed();
    }
  }

  parseRSS(RssFeed feed) {
    RegExp timeRegex = RegExp(r"\d\d:\d\d");
    for (var item in feed.items) {
      RegExpMatch? time = timeRegex.firstMatch(item.description!);
      scheduleData.addGame({
        'date': item.description!
            .replaceAll(RegExp(".*Datum: "), "")
            .replaceAll(RegExp(",.*"), ""),
        'time': item.description!.substring(time!.start, time.end),
        'hall': item.title!.replaceAll(RegExp(".*: "), ""),
      });
      //   debugPrint("${item.description!}");
    }
  }
}
