import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rss_dart/dart_rss.dart';

import 'data.dart';
import 'rss_clean.dart';
import 'schedule_data.dart';

class RssSchedule {
  RssClean rssClean = RssClean();
  ScheduleData scheduleData = ScheduleData.instance;

  Future<bool> getSchedule() async {
    var result = false;
    Client client = Client();
    TeamInfo teamInfo = TeamInfo();
    String group = teamInfo.getSchedule(team.currentTeam);

    scheduleData.clear();

    await getRssFeed(client, group).then((value) {
      if (value.description != null) {
        if (value.description!.isNotEmpty) {
          parseRSS(value);
        }
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
    RegExp timeRegex = RegExp(r"\d?\d:\d\d");
    for (var item in feed.items) {
      RegExpMatch? time = timeRegex.firstMatch(item.description!);
      if (time != null) {
        var address = item.description!
            .replaceAll(RegExp(".*Speellocatie: "), '')
            .split(', ');
        scheduleData.addGame({
          'date': item.description!
              .replaceAll(RegExp(".*Datum: "), "")
              .replaceAll(RegExp(",.*"), ""),
          'time': item.description!.substring(time.start, time.end),
          'game': rssClean.clean(item.title!.replaceAll(RegExp(".*: "), "")),
          'hall': address[0],
          'street': address[1],
          'postal': address[2],
        });
      }
      //   debugPrint(item.description!);
    }
  }
}
