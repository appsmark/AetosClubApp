import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'data.dart';
import 'ranking_data.dart';
import 'rss_clean.dart';

class RssRanking {
  RssClean rssClean = RssClean();
  Team team = Team();
  TeamInfo teamInfo = TeamInfo();
  RankingData rankingData = RankingData.instance;

  Future getRanking() async {
    //  String group = teamInfo.getSchedule(team.currentTeam);
/*    final response = await http.get(Uri.parse(
        'https://api.nevobo.nl/export/poule/regio-oost/MC3N1/stand.rss'));
  */
    final response =
        await http.get(Uri.parse(teamInfo.getRanking(team.currentTeam)));

    if (response.statusCode == 200) {
      return parseXML(response.body);
    } else {
      throw Exception('Failed to load ranking');
    }
  }

  parseXML(inputStream) {
    rankingData.clear();
    String stream = rssClean.clean(inputStream);
    var titles = stream.split("title>");
    String competition = titles[3]
        .replaceAll(RegExp('.*Stand '), '')
        .replaceAll(RegExp('].*'), '');
    rankingData.competition = rssClean.clean(competition);
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
