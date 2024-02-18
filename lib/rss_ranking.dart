import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'ranking_data.dart';

class RssRanking {
  RankingData rankingData = RankingData.instance;

  Future getRanking() async {
    final response = await http.get(Uri.parse(
        'https://api.nevobo.nl/export/poule/regio-oost/MC3N1/stand.rss'));

    if (response.statusCode == 200) {
      return parseXML(response.body);
    } else {
      throw Exception('Failed to load ranking');
    }
  }

  parseXML(stream) {
    var titles = stream.split("title>");
    String competition = titles[3]
        .replaceAll(RegExp('.*Stand '), '')
        .replaceAll(RegExp('].*'), '');
    var teams = stream.split(RegExp("<stand:team "));
    for (int index = 1; index < teams.length; index++) {
      String team = teams[index]
          .replaceAll(RegExp(r'.*DATA\['), '')
          .replaceAll(RegExp('].*'), '')
          .replaceAll(RegExp('\n.*'), '');
      debugPrint("$team");
    }
  }
/*
  Future<bool> XgetRanking(String group) async {
    var result = false;
    Client client = Client();
    TeamInfo teamInfo = TeamInfo();
    group = teamInfo.getRanking(team.currentTeam);

    rankingData.clear();

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
    var document; // = xml.XmlDocument.parse(feed);
//final employeesNode = document.findElements('employees').first;
    RegExp timeRegex = RegExp(r"\d\d:\d\d");
    for (var item in feed.items) {
      // document = xml.XmlDocument.parse(item.content.toString());
      RegExpMatch? time = timeRegex.firstMatch(item.description!);
      /*
      rankingData.addTeam({
        'date': item.description!
            .replaceAll(RegExp(".*Datum: "), "")
            .replaceAll(RegExp(",.*"), ""),
        'time': item.description!.substring(time!.start, time.end),
        'hall': item.title!.replaceAll(RegExp(".*: "), ""),
      });
      */
      debugPrint(item.description!);
    }
  }

*/
}
