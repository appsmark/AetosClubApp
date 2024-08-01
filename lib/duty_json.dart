import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'data.dart';
import 'duty_data.dart';

class JsonDuty {
  DutyData dutyData = DutyData.instance;
  DateTime now = DateTime.now();
  bool testLocal = true;

  Future getDuty(bool mode) async {
    if (testLocal) {
      String fileText = await rootBundle.loadString('assets/zaaldienst.json');
      debugPrint(fileText);
      return parse(jsonDecode(fileText)['duty'], mode);
    } else {
      var result =
          await http.get(Uri.parse("http://apps-mark.nl/zaaldienst.json"));

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

  parse(inputStream, bool mode) {
    dutyData.clear();
    for (int index = 0; index < inputStream.length; index++) {
      DateTime tempDate =
          DateFormat("yyyy-mm-dd").parse(convert(inputStream[index]["Datum"]));
//          DateFormat("dd MMM yyyy").parse(convert(inputStream[index]["Datum"]));
      if (tempDate.difference(DateTime.now()).inDays >= 0) {
        if (mode) {
          if (inputStream[index]["Thuisteam"] != null) {
            String compare =
                inputStream[index]["Thuisteam"].replaceAll(" ", "");
            if (compare == "AETOS${team.currentTeam}") {
              dutyData.addGameData({
                "date": inputStream[index]["Datum"].replaceAll(" 2024", ""),
                "referee": inputStream[index]["scheids"],
                "counter": inputStream[index]["teller"],
                "duty": inputStream[index]["Zaalwacht"],
              });
            }
          }
        } else {
          if ((inputStream[index]["scheids"] == team.currentTeam) ||
              (inputStream[index]["teller"] == team.currentTeam) ||
              (inputStream[index]["Zaalwacht"] == team.currentTeam)) {
            dutyData.add({
              "date": inputStream[index]["Datum"].replaceAll(" 2024", ""),
              "time": inputStream[index]["Tijd"],
              "endtime": inputStream[index]["Eindtijd"],
              "hometeam": inputStream[index]["Thuisteam"],
              "visitor": inputStream[index]["Uitteam"],
              "hall": inputStream[index]["Locatie"],
              "referee": inputStream[index]["scheids"],
              "counter": inputStream[index]["teller"],
              "duty": inputStream[index]["Zaalwacht"],
            });
          }
        }
      }
    }
  }
}
