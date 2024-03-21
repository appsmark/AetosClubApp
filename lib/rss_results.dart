import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rss_dart/dart_rss.dart';

import 'data.dart';
import 'rss_clean.dart';
import 'results_data.dart';

class RssResults {
  RssClean rssClean = RssClean();
  ResultsData resultsData = ResultsData.instance;

  Future<bool> getResults() async {
    var result = false;
    Client client = Client();
    TeamInfo teamInfo = TeamInfo();
    String group = teamInfo.getResults(team.currentTeam);

    resultsData.clear();

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
    //  RegExp timeRegex = RegExp(r"\d?\d:\d\d");
    for (var item in feed.items) {
      //     RegExpMatch? time = timeRegex.firstMatch(item.description!);
      //   if (time != null) {
      var address = item.description!
          .replaceAll(RegExp(".*Speellocatie: "), '')
          .split(', ');
      resultsData.addGame({
        'game': rssClean.clean(address[0].replaceAll(RegExp(".*: "), "")),
        'result': address[1].replaceAll("Uitslag: ", ""),
        if (address.length == 7)
          'sets':
              "${address[2].replaceAll("Setstanden: ", "")} ${address[3]} ${address[4]} ${address[5]} ${address[6]}",
        if (address.length == 6)
          'sets':
              "${address[2].replaceAll("Setstanden: ", "")} ${address[3]} ${address[4]} ${address[5]}",
      });
//      }
      //   debugPrint(item.description!);
    }
  }
}
