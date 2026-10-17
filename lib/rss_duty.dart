import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:xml/xml.dart';

import 'duty_data.dart';
import 'schedule_data.dart';

class RssDuty extends ChangeNotifier {
  static final instance = RssDuty._internal();

  DutyData dutyData = DutyData.instance;
  ScheduleData scheduleData = ScheduleData.instance;

  RssDuty._internal();

  Future<bool> getSchedule() async {
    bool result = false;
    Client client = Client();
    getRssFeed(client);
    return result;
  }

  Future<String> getRssFeed(Client client) async {
    Response response = Response('', 200);
    try {
      response = await client.get(
        Uri(scheme: 'https', host: 'aetos.nl', path: 'rss'),
      );
      parseRss(response.body);
    } catch (e) {
      debugPrint(e.toString());
    }
    notifyListeners();
    return (response.body);
  }

  void parseRss(String response) {
    DateTime tempDate;
    String date = "";

    String dutyTeam = "";
    String dutyTeamOld = "";
    String endtime = "";
    String hall = "";
    String license = "";
    String starttime = "";
    String hometeam = "";
    String visitor = "";
    String referee = "";
    String counter = "";
    String task = "";
    int taskCount = 0;
    Iterable creatorElement;
    XmlElement? node;
    XmlDocument document = XmlDocument.parse(response);
    Iterable<XmlElement> item = document.findAllElements('item');

    for (int i = 0; i < document.findAllElements('item').length; i++) {
      node = item.elementAt(i).getElement('category');

      creatorElement = item
          .elementAt(i)
          .findElements('datum', namespace: 'https://aetos-arnhem.nl/rss/ns');
      date = creatorElement.single.text;
      tempDate = DateFormat("dd-MM-yyyy").parse(date);

      if (tempDate.difference(DateTime.now()).inDays >= 0) {
        if (node!.firstChild?.value == "zaaldienst") {
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
              .findElements(
                'team',
                namespace: 'https://aetos-arnhem.nl/rss/ns',
              );
          dutyTeam = creatorElement.single.text;
          dutyTeam = dutyTeam.replaceAll('DS ', "D");
          dutyTeam = dutyTeam.replaceAll('HS ', "H");
          dutyTeam = dutyTeam.replaceAll(' ', "");

          dutyData.add({
            "type": "zaaldienst",
            "date": date,
            "time": starttime,
            "endtime": endtime,
            "hall": hall,
            "duty": dutyTeam,
          });
        } else {
          if (node.firstChild?.value == "volleystars") {
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
                .findElements(
                  'team',
                  namespace: 'https://aetos-arnhem.nl/rss/ns',
                );
            dutyTeam = creatorElement.single.text;
            dutyTeam = dutyTeam.replaceAll('DS ', "D");
            dutyTeam = dutyTeam.replaceAll('HS ', "H");
            dutyTeam = dutyTeam.replaceAll(' ', "");
            creatorElement = item
                .elementAt(i)
                .findElements(
                  'omschrijving',
                  namespace: 'https://aetos-arnhem.nl/rss/ns',
                );
            task = creatorElement.single.text;
            if (task == "Afbouwen") {
              task = "Tellen/Opruimen";
            }
            if (task == "Opbouwen") {
              task = "Opbouwen/Tellen";
            }
            if (dutyTeam == dutyTeamOld) {
              taskCount++;
              dutyTeamOld = dutyTeam;
            } else {
              taskCount = 1;
              dutyTeamOld = dutyTeam;
            }
            dutyData.add({
              "type": "volleystars",
              "date": date,
              "time": starttime,
              "endtime": endtime,
              "hall": hall,
              "task": task,
              "taskCount": taskCount,
              "duty": dutyTeam,
            });
          } else {
            creatorElement = item
                .elementAt(i)
                .findElements(
                  'tijd',
                  namespace: 'https://aetos-arnhem.nl/rss/ns',
                );
            starttime = creatorElement.single.text;
            creatorElement = item
                .elementAt(i)
                .findElements(
                  'sporthal',
                  namespace: 'https://aetos-arnhem.nl/rss/ns',
                );
            hall = creatorElement.single.text;

            creatorElement = item
                .elementAt(i)
                .findElements(
                  'fluiten',
                  namespace: 'https://aetos-arnhem.nl/rss/ns',
                );
            if (creatorElement.isNotEmpty) {
              referee = creatorElement.single.text;
            } else {
              referee = "?";
            }
            referee = referee.replaceAll('DS ', "D");
            referee = referee.replaceAll('HS ', "H");
            referee = referee.replaceAll(' ', "");
            creatorElement = item
                .elementAt(i)
                .findElements(
                  'fluitlicentie',
                  namespace: 'https://aetos-arnhem.nl/rss/ns',
                );
            if (creatorElement.isNotEmpty) {
              license = "(${creatorElement.single.text})";
            } else {
              license = "";
            }
            creatorElement = item
                .elementAt(i)
                .findElements(
                  'tellen',
                  namespace: 'https://aetos-arnhem.nl/rss/ns',
                );
            if (creatorElement.isNotEmpty) {
              counter = creatorElement.single.text;
              counter = counter.replaceAll('DS ', "D");
              counter = counter.replaceAll('HS ', "H");
              counter = counter.replaceAll(' ', "");
            } else {
              counter = "?";
            }
            creatorElement = item
                .elementAt(i)
                .findElements(
                  'thuisteam',
                  namespace: 'https://aetos-arnhem.nl/rss/ns',
                );
            hometeam = creatorElement.single.text;
            creatorElement = item
                .elementAt(i)
                .findElements(
                  'uitteam',
                  namespace: 'https://aetos-arnhem.nl/rss/ns',
                );
            visitor = creatorElement.single.text;

            dutyData.add({
              "type": "wedstrijd",
              "date": date,
              "time": starttime,
              "endtime": endtime,
              "hall": hall,
              "hometeam": hometeam,
              "visitor": visitor,
              "referee": referee,
              "license": license,
              "counter": counter,
            });
          }
        }
      }
    }
  }
}
