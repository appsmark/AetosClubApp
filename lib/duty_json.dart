import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'data.dart';
import 'duty_data.dart';

class JsonDuty {
  DutyData dutyData = DutyData.instance;
  DateTime now = DateTime.now();
  bool testLocal = false;

  Future getDuty(bool mode) async {
    if (testLocal) {
      String fileText = await rootBundle.loadString('assets/zaaldienst.json');
      return parse(jsonDecode(fileText)['duty'], mode);
    } else {
      var result = await http
          .get(Uri.parse("http://apps-mark.nl/aetos/zaaldienst.json"));

      if (result.statusCode == 200) {
        return parse(jsonDecode(result.body)['duty'], mode);
      } else {
        throw Exception('Failed to load duty');
      }
    }
  }

  String convert(String inputStream) {
    String result = inputStream.replaceAll("januari", "Jan");
    result = result.replaceAll("februari", "Feb");
    result = result.replaceAll("march", "Mar");
    result = result.replaceAll("april", "Apr");
    result = result.replaceAll("june", "Jun");
    return result;
  }

  void parse(List inputStream, bool mode) {
    String date = "";
    String day = "";
    String dutyTeam = "";
    String endtime = "";
    String month = "";
    String referee = "";
    DateTime tempDate;

    dutyData.clear();
    for (int index = 0; index < inputStream.length; index++) {
      if (testLocal) {
        tempDate = DateFormat("yyyy-MM-dd")
            .parse(convert(inputStream[index]["Datum"]));
      } else {
        tempDate = DateFormat("yyyy-MM-dd")
            .parse(convert(inputStream[index]["Datum"]));
      }

      if (inputStream[index]["Zaalwacht"] != null) {
        dutyTeam = inputStream[index]["Zaalwacht"];
      }
      /*
      if ((inputStream[index]["Locatie"] != null) &&
          (inputStream[index]["Locatie"] != "Middachtensingel")) {
        dutyTeam = "";
      }
*/
      if (tempDate.difference(DateTime.now()).inDays >= 0) {
        if (mode) {
          if (inputStream[index]["Thuisteam"] != null) {
            String compare =
                inputStream[index]["Thuisteam"].replaceAll(" ", "");
            compare = compare.replaceAll("HS", "H");
            compare = compare.replaceAll("DS", "D");
            if (compare == "AETOS${team.currentTeam}") {
              referee = inputStream[index]["scheids"];
              if (referee == "x") {
                referee = "NeVoBo";
              }
              dutyData.addGameData({
                "date": inputStream[index]["Datum"],
                "referee": referee,
                "counter": inputStream[index]["teller"],
                "duty": dutyTeam,
              });
            }
          }
        } else {
          if ((inputStream[index]["scheids"] == team.currentTeam) ||
              (inputStream[index]["teller"] == team.currentTeam) ||
              (inputStream[index]["Zaalwacht"] == team.currentTeam)) {
            date = inputStream[index]["Datum"];
            month = date.split('-')[1];
            month = month.replaceAll("09", "september");
            month = month.replaceAll("10", "oktober");
            month = month.replaceAll("11", "november");
            month = month.replaceAll("12", "december");
            month = month.replaceAll("01", "januari");
            month = month.replaceAll("02", "februari");
            month = month.replaceAll("03", "maart");
            month = month.replaceAll("04", "april");
            month = month.replaceAll("05", "mei");
            day = date.split('-')[2];
            if (day[0] == "0") {
              day = day[1];
            }
            if (inputStream[index]["Eindtijd"] != null) {
              endtime = inputStream[index]["Eindtijd"];
              endtime = endtime.replaceAll("eind", "einde");
            }
            referee = "";
            if (inputStream[index]["scheids"] != null) {
              referee = inputStream[index]["scheids"];
              if (referee == "x") {
                referee = "NeVoBo";
              }
            }
            if (referee.isEmpty) {
              dutyData.add({
                "date": "$day $month",
                "time": inputStream[index]["Tijd"],
                "endtime": endtime,
                "duty": dutyTeam,
              });
            } else {
              dutyData.add({
                "date": "$day $month",
                "time": inputStream[index]["Tijd"],
                "endtime": endtime,
                "hometeam": inputStream[index]["Thuisteam"],
                "visitor": inputStream[index]["Uitteam"],
                "hall": inputStream[index]["Locatie"],
                "referee": referee,
                "counter": inputStream[index]["teller"],
                "duty": dutyTeam,
              });
            }
          }
        }
      }
    }
  }
}
