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
    List gamesArray = [];
    var points = stream.split(RegExp("<stand:punten>"));
    List pointsArray = [];
    int pointsMaxLength = 0;
    var teams = stream.split(RegExp("<stand:team "));
    List teamsArray = [];
    var setswon = stream.split(RegExp("<stand:setsvoor>"));
    List setswonArray = [];
    var setslost = stream.split(RegExp("<stand:setstegen>"));
    List setslostArray = [];
    int setslostMaxLength = 0;
    var pointswon = stream.split(RegExp("<stand:puntenvoor>"));
    List pointswonArray = [];
    var pointslost = stream.split(RegExp("<stand:puntentegen>"));
    List pointslostArray = [];
    int pointslostMaxLength = 0;

    for (int index = 1; index < teams.length; index++) {
      String team = teams[index]
          .replaceAll(RegExp(r'.*DATA\['), '')
          .replaceAll(RegExp('].*'), '')
          .replaceAll(RegExp('\n.*'), '');
      teamsArray.add(team);
      String game = games[index]
          .replaceAll(RegExp('<.*'), '')
          .replaceAll(RegExp('\n.*'), '');
      gamesArray.add(game);
      String point = points[index]
          .replaceAll(RegExp('<.*'), '')
          .replaceAll(RegExp('\n.*'), '');
      pointsArray.add(point);
      switch (point.length) {
        case 1:
          point = " $point";
          break;
      }
      String setwon = setswon[index]
          .replaceAll(RegExp('<.*'), '')
          .replaceAll(RegExp('\n.*'), '');
      setswonArray.add(setwon);
      switch (setwon.length) {
        case 1:
          setwon = "  $setwon";
          break;
      }
      String setlost = setslost[index]
          .replaceAll(RegExp('<.*'), '')
          .replaceAll(RegExp('\n.*'), '');
      setslostArray.add(setlost);
      switch (setlost.length) {
        case 1:
          setlost = "  $setlost";
          break;
      }
      String pointwon = pointswon[index]
          .replaceAll(RegExp('<.*'), '')
          .replaceAll(RegExp('\n.*'), '');
      pointswonArray.add(pointwon);
      switch (pointwon.length) {
        case 1:
          pointwon = "      $pointwon";
          break;
        case 2:
          pointwon = "    $pointwon";
          break;
        case 3:
          pointwon = "  $pointwon";
          break;
      }
      String pointlost = pointslost[index]
          .replaceAll(RegExp('<.*'), '')
          .replaceAll(RegExp('\n.*'), '');
      pointslostArray.add(pointlost);
    }
    for (int index = 0; index < teamsArray.length; index++) {
      if (pointslostArray[index].length > pointslostMaxLength) {
        pointslostMaxLength = pointslostArray[index].length;
      }
      if (pointsArray[index].length > pointsMaxLength) {
        pointsMaxLength = pointsArray[index].length;
      }
      if (gamesArray[index].length > setslostMaxLength) {
        setslostMaxLength = gamesArray[index].length;
      }
    }
    for (int index = 0; index < teamsArray.length; index++) {
      switch (pointsMaxLength) {
        case 2:
          switch (pointsArray[index].length) {
            case 1:
              pointsArray[index] = " ${pointsArray[index]}";
              break;
          }
          break;
      }
      switch (setslostMaxLength) {
        case 2:
          switch (setslostArray[index].length) {
            case 1:
              setslostArray[index] = " ${setslostArray[index]}";
              break;
          }
          break;
      }
      switch (pointslostMaxLength) {
        case 3:
          switch (pointslostArray[index].length) {
            case 1:
              pointslostArray[index] = "  ${pointslostArray[index]}";
              break;
            case 2:
              pointslostArray[index] = " ${pointslostArray[index]}";
              break;
          }
          break;
        case 4:
          switch (pointslostArray[index].length) {
            case 1:
              pointslostArray[index] = "   ${pointslostArray[index]}";
              break;
            case 2:
              pointslostArray[index] = "  ${pointslostArray[index]}";
              break;
            case 3:
              pointslostArray[index] = " ${pointslostArray[index]}";
              break;
          }
          break;
      }
      rankingData.addTeam({
        'team': teamsArray[index],
        'games': gamesArray[index],
        'points': pointsArray[index],
        'setswon': setswonArray[index],
        'setslost': setslostArray[index],
        'pointswon': pointswonArray[index],
        'pointslost': pointslostArray[index]
      });
    }
  }
}
