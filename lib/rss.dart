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
    //debugPrint(xml);
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
  if (comp.indexOf("helft") > 0) {
    comp = comp.substring(0, comp.indexOf("Eerste helft"));
    comp = comp.substring(0, comp.indexOf("Tweede helft"));
  }
  comp = comp.replaceAll("Tweede", "2e");
  data.setCompetition(comp);

  final rankings = rank.findElements('stand:ranking');
  for (final ranking in rankings) {
    final teamName = ranking.findElements('stand:team').first.text;
    final pointsTeam =
        int.parse(ranking.findElements('stand:puntenvoor').first.text);
    data.addTeam(teamName, pointsTeam);
  }
  return result;
}
