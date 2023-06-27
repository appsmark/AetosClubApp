import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';
import 'package:xml/xml.dart';

final List _teams = [];
final List _points = [];

Future<RssFeed?> getRSS() async {
  var url =
      Uri.parse("https://api.nevobo.nl/export/poule/regio-oost/DPD/stand.rss");

  // Await the http get response, then decode the json-formatted response.
  var response = await http.get(url);
  var xml = "";
  if (response.statusCode == 200) {
    //     debugPrint('======');
//      debugPrint(response.body);
    xml = '<?xml version="1.0" encoding="UTF-8"?>\n<ranks>\n' +
        response.body.substring(response.body.indexOf('<stand'));
    xml = xml.substring(0, xml.indexOf('</channel'));
    //   xml = xml.replaceAll('stand:puntenvoor>0', 'stand:puntenvoor:>3');
    xml = xml + '\n</ranks>';
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
  final document = XmlDocument.parse(xml);

  final rank = document.findElements('ranks').first;

  final rankings = rank.findElements('stand:ranking');
  for (final ranking in rankings) {
    final teamName = ranking.findElements('stand:team').first.text;
    final pointsTeam = ranking.findElements('stand:puntenvoor').first.text;
    _teams.add(teamName);
    _points.add(pointsTeam);
  }
  debugPrint(_points.first);
  debugPrint(_teams.first);
  debugPrint(_teams.last);
  return null;
}
