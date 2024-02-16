import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rss_dart/dart_rss.dart';

Future<bool> getRSS(urlRSS) async {
  var result = false;
  return result;
}

Future<bool> getSchedule(String group) async {
  var result = false;
  Client client = Client();
  // String group = "dames/3";
  getRssFeed(client, group).then((value) {
    if (value.description!.isNotEmpty) {
      //  List<Information> informationList = parseRSS(value);
      parseRSS(value);
    }
    //   printInformationList(informationList);
  });
  return result;
}

Future<RssFeed> getRssFeed(Client client, String group) async {
  Response response = Response('', 200);
  try {
    response = await client.get(Uri.parse(group));
//        'https://api.nevobo.nl/export/team/CNH8Q1U/' +
    //          group +
    //        '/programma.rss'));
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
  final xitems = feed.items;
  RegExp timeGame = RegExp(r"\d\d:\d\d");
  for (var item in xitems) {
    RegExpMatch? time = timeGame.firstMatch(item.description!);
    // debugPrint("${item.description!}");
/*
      debugPrint(
          "${item.description!.replaceAll(RegExp(".*Datum: "), "").replaceAll(RegExp(",.*"), "")}");
      debugPrint(item.description!.substring(time!.start, time.end));
      debugPrint("${item.title!.replaceAll(RegExp(".*\: "), "")}");
*/

    //   debugPrint(
    //     "${item.description!.replaceAll(RegExp(".*Datum: "), "").replaceAll(RegExp(",.*"), "")}     ${item.description!.substring(time!.start, time.end)}    ${item.title!.replaceAll(RegExp(".*: "), "")}");
  }
}
