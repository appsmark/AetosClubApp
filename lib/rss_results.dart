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
    for (var item in feed.items) {
      var address = item.description!
          .replaceAll(RegExp(".*Speellocatie: "), '')
          .split(', ');
      if (address.length > 5) {
        resultsData.addGame({
          'game': rssClean.clean(address[0].replaceAll(RegExp(".*: "), "")),
          'result': address[1].replaceAll("Uitslag: ", ""),
          if (address.length == 7)
            'sets':
                "${address[2].replaceAll("Setstanden: ", "")} ${address[3]} ${address[4]} ${address[5]} ${address[6]}",
          if (address.length == 7)
            'totals1': int.parse(
                    address[2].replaceAll("Setstanden: ", "").split("-")[0]) +
                int.parse(address[3].split("-")[0]) +
                int.parse(address[4].split("-")[0]) +
                int.parse(address[5].split("-")[0]) +
                int.parse(address[6].split("-")[0]),
          if (address.length == 7)
            'totals2': int.parse(
                    address[2].replaceAll("Setstanden: ", "").split("-")[1]) +
                int.parse(address[3].split("-")[1]) +
                int.parse(address[4].split("-")[1]) +
                int.parse(address[5].split("-")[1]) +
                int.parse(address[6].split("-")[1]),
          if (address.length == 6)
            'sets':
                "${address[2].replaceAll("Setstanden: ", "")} ${address[3]} ${address[4]} ${address[5]}",
          if (address.length == 6)
            'totals1': int.parse(
                    address[2].replaceAll("Setstanden: ", "").split("-")[0]) +
                int.parse(address[3].split("-")[0]) +
                int.parse(address[4].split("-")[0]) +
                int.parse(address[5].split("-")[0]),
          if (address.length == 6)
            'totals2': int.parse(
                    address[2].replaceAll("Setstanden: ", "").split("-")[1]) +
                int.parse(address[3].split("-")[1]) +
                int.parse(address[4].split("-")[1]) +
                int.parse(address[5].split("-")[1]),
        });
      }
    }
  }
}
