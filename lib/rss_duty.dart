import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rss_dart/dart_rss.dart';
import 'package:xml/xml.dart';

import 'duty_data.dart';
import 'schedule_data.dart';

class RssDuty extends ChangeNotifier {
  static final instance = RssDuty._internal();

  DutyData dutyData = DutyData.instance;
  ScheduleData scheduleData = ScheduleData.instance;

  RssDuty._internal();

  void getIt() {}
  Future<bool> getSchedule() async {
    bool result = false;
    Client client = Client();
    getRssFeed(client).then((value) {
      result = true;
    });
    return result;
  }

  Future<String> getRssFeed(Client client) async {
    Response response = Response('', 200);
    try {
      response = await client.get(
        Uri(
          scheme: 'https',
          host: 'aetos-wedstijden.lovable.app',
          path: '/api/public/rss',
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
    String date = "";

    String dutyTeam = "";
    String endtime = "";
    String hall = "";
    String starttime = "";

    Iterable creatorElement;
    XmlElement? node;
    final document = XmlDocument.parse(response.body);
    final item = document.findAllElements('item');
    for (int i = 0; i < document.findAllElements('item').length; i++) {
      //    debugPrint(document.findAllElements('item').toString());
      node = item.elementAt(i).getElement('category');
      if (node!.firstChild?.value == "Zaaldienst") {
        creatorElement = item
            .elementAt(i)
            .findElements('datum', namespace: 'https://aetos-arnhem.nl/rss/ns');
        date = creatorElement.single.text;

        creatorElement = item
            .elementAt(i)
            .findElements(
              'begintijd',
              namespace: 'https://aetos-arnhem.nl/rss/ns',
            );
        starttime = creatorElement.single.text;

        creatorElement = item
            .elementAt(i)
            .findElements(
              'eindtijd',
              namespace: 'https://aetos-arnhem.nl/rss/ns',
            );
        endtime = creatorElement.single.text;

        creatorElement = item
            .elementAt(i)
            .findElements(
              'sporthal',
              namespace: 'https://aetos-arnhem.nl/rss/ns',
            );
        hall = creatorElement.single.text;

        creatorElement = item
            .elementAt(i)
            .findElements('team', namespace: 'https://aetos-arnhem.nl/rss/ns');
        dutyTeam = creatorElement.single.text;
        dutyTeam = dutyTeam.replaceAll('DS ', "D");
        dutyTeam = dutyTeam.replaceAll('HS ', "H");
        dutyTeam = dutyTeam.replaceAll(' ', "");

        dutyData.add({
          "date": date,
          "time": starttime,
          "endtime": endtime,
          "hall": hall,
          "duty": dutyTeam,
        });
      } else {}
    }

    notifyListeners();
    return (response.body);
  }

  Future<RssFeed> xgetRssFeed(Client client, String group) async {
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

  void parseRSS(RssFeed feed) {
    //RegExp timeRegex = RegExp(r"\d?\d:\d\d");
    String? home = "";
    String? visitor = "";
    for (var item in feed.items) {
      //   RegExpMatch? time = timeRegex.firstMatch(item.description!);
      // if (time != null) {

      home = item.title
          ?.replaceAll("Wedstrijd: ", "")
          .replaceAll(RegExp(" -.*"), "");
      visitor = item.title
          ?.replaceAll("Wedstrijd: ", "")
          .replaceAll(RegExp(".*- "), "");
      dutyData.add({
        "date": "12 10",
        "time": "12:30",
        //"endtime": endtime,
        "hometeam": home,
        "visitor": visitor,
        //        "hall": inputStream[index]["Locatie"],
        "referee": 'D1',
        //    "counter": inputStream[index]["teller"],
        //  "duty": dutyTeam,
      });
      //   debugPrint(item.description!);
    }
  }
}
