import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import 'data.dart';
import 'package:flutter/material.dart';

Future<bool> getRSS(urlRSS) async {
  var result = false;
  var url = Uri.parse(urlRSS);

  // Await the http get response, then decode the json-formatted response.
  var response = await http.get(url);
  var xml = "";
  if (response.statusCode == 200) {
    //   debugPrint('======');
//    debugPrint(response.body);
    xml =
        '<?xml version="1.0" encoding="UTF-8"?>\n<ranks>\n${response.body.substring(response.body.indexOf('<item'))}';

    xml = xml.substring(0, xml.indexOf('</channel'));

    //   xml = xml.replaceAll('stand:puntenvoor>0', 'stand:puntenvoor:>3');
    xml = '$xml\n</ranks>';
    debugPrint(xml);
    result = true;
  } else {
    debugPrint('Request failed with status: ${response.statusCode}.');
  }
  data.clear();
  final document = XmlDocument.parse(xml);

  final rank = document.findElements('ranks').first;

  final item = rank.findElements('item').first;
  String comp = item.findElements('title').toString();
  comp = comp.substring(6 + comp.indexOf("Stand"), comp.indexOf("]"));
  comp = comp.replaceAll("Dames ", "");
  comp = comp.replaceAll("Heren ", "");
  comp = comp.replaceAll("Arnh/Wag ", "Arnhem / Wageningen\n");
  if (comp.indexOf("helft") > 0) {
    comp = comp.substring(0, comp.indexOf("Eerste helft"));
//    comp = comp.substring(0, comp.indexOf("Tweede helft"));
  }
  comp = comp.replaceAll("Tweede", "2e");
  data.setCompetition(comp);

  final rankings = rank.findElements('stand:ranking');
  for (final ranking in rankings) {
    final teamName = ranking.findElements('stand:team').first.text;
    final played =
        int.parse(ranking.findElements('stand:wedstrijden').first.text);
    final points = int.parse(ranking.findElements('stand:punten').first.text);
    data.addTeam(teamName, played, points);
  }
  return result;
}

Future<bool> getSchedule(urlRSS) async {
  var result = false;
  var url = Uri.parse(urlRSS);

  // Await the http get response, then decode the json-formatted response.
  var response = await http.get(url);
  var xml = "";
  if (response.statusCode == 200) {
    //   debugPrint('======');
//    debugPrint(response.body);
    xml =
        '<?xml version="1.0" encoding="UTF-8"?>\n<ranks>\n${response.body.substring(response.body.indexOf('<item'))}';

    xml = xml.substring(0, xml.indexOf('</channel'));

    xml = '$xml\n</ranks>';
//    debugPrint(xml);
    result = true;
  } else {
    debugPrint('Request failed with status: ${response.statusCode}.');
  }
  data.clear();
  final document = XmlDocument.parse(xml);

  final rank = document.findElements('ranks').first;

  final item = rank.findElements('item').first;
  String description = item.findElements('description').toString();
  debugPrint(description);

  final rankings = rank.findElements('item');
  for (final ranking in rankings) {
    final gameString = ranking.findElements('description').first.text;
    var gameDate = gameString.substring(gameString.indexOf("Datum") + 7);
    try {
      gameDate = gameDate.substring(0, gameDate.indexOf(", Speellocatie"));
      data.addGame(gameDate);
    } catch (e) {
      debugPrint(e.toString());
    }
//    gameDate = gameDate.replaceAll(", ", "\n");
//    debugPrint(gameDate);
    var gameLocation = gameString.substring(
        gameString.indexOf("locatie:") + 9); //, gameDate.indexOf(","));
    gameLocation = gameLocation.replaceAll(", ", "\n");
    //  debugPrint(gameLocation);
//    data.addTeam(teamName, pointsTeam);
  }
  return result;
}
