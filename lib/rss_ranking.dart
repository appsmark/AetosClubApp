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
    var games = stream.split(RegExp("<stand:wedstrijden>"));
    var points = stream.split(RegExp("<stand:punten>"));
    var teams = stream.split(RegExp("<stand:team "));
    for (int index = 1; index < teams.length; index++) {
      String team = teams[index]
          .replaceAll(RegExp(r'.*DATA\['), '')
          .replaceAll(RegExp('].*'), '')
          .replaceAll(RegExp('\n.*'), '');
      String game = games[index]
          .replaceAll(RegExp('<.*'), '')
          .replaceAll(RegExp('\n.*'), '');
      String point = points[index]
          .replaceAll(RegExp('<.*'), '')
          .replaceAll(RegExp('\n.*'), '');
      debugPrint("$team  $game - $point");
      rankingData.addTeam({'team': team, 'games': game, 'points': point});
    }
  }
}
