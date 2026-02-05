import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HallInfo {
  static final HallInfo instance = HallInfo._internal();

  List data = [];
  DateTime dateNextSaturday = DateTime.now();
  int numberOfGames = 0;

  HallInfo._internal();

  Future<bool> get() async {
    var result = false;
    try {
      await getDuty();
      dateNextSaturday = getNextSaturday(DateTime.now());
      //      ).toString().substring(0, 10);

      result = true;
    } catch (e) {
      debugPrint(e.toString());
    }

    return result;
  }

  /// Calculates the date of the next Saturday from a given date
  static DateTime getNextSaturday(DateTime date) {
    // Saturday is day 6 in Dart (Monday=1, Sunday=7)
    final daysUntilSaturday = (6 - date.weekday) % 7;
    if (daysUntilSaturday == 0 && date.weekday != 6) {
      return date.add(Duration(days: 7));
    }
    return date.add(
      Duration(days: daysUntilSaturday == 0 ? 0 : daysUntilSaturday),
    );
  }

  Future getDuty() async {
    var result = await http.get(
      Uri.parse("http://apps-mark.nl/aetos/zaaldienst2526.json"),
    );

    if (result.statusCode == 200) {
      return parse(jsonDecode(result.body)['duty']);
    } else {
      throw Exception('Failed to load duty');
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

  void parse(List inputStream) {
    String date = "";
    String day = "";
    String dutyTeam = "";
    String month = "";
    String referee = "";
    DateTime tempDate;

    data = [];
    dateNextSaturday = getNextSaturday(DateTime.now());
    numberOfGames = 0;
    for (int index = 0; index < inputStream.length; index++) {
      tempDate = DateFormat(
        "yyyy-MM-dd",
      ).parse(convert(inputStream[index]["Datum"]));

      if (inputStream[index]["Zaalwacht"] != null) {
        dutyTeam = inputStream[index]["Zaalwacht"];
      }

      if (tempDate.day == dateNextSaturday.day &&
          tempDate.month == dateNextSaturday.month &&
          tempDate.year == dateNextSaturday.year) {
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
        referee = "";
        if (inputStream[index]["scheids"] != null) {
          referee = inputStream[index]["scheids"];
          if (referee == "x") {
            referee = "NeVoBo";
          }
        }
        if (inputStream[index]["Thuisteam"] != null) {
          numberOfGames++;
          data.add({
            "time": inputStream[index]["Tijd"],
            "hometeam": inputStream[index]["Thuisteam"],
            "dutyTeam": dutyTeam,
            "referee": referee,
            "counter": inputStream[index]["teller"],
          });
        }
      }
    }
  }

  String getReferee(int index) {
    if (index >= data.length) {
      return "?";
    }
    if (data[index]["referee"] == "") {
      return "?";
    }
    return data[index]["referee"];
  }

  String getDutyTeam(int index) {
    if (data[index]["dutyTeam"] == null) {
      return "?";
    }
    return data[index]["dutyTeam"];
  }

  String getCounter(int index) {
    if (index >= data.length) {
      return "?";
    }
    return data[index]["counter"];
  }

  String getTime(int index) {
    if (index >= data.length) {
      return "?";
    }
    return data[index]["time"];
  }

  String getHomeTeam(int index) {
    if (index >= data.length) {
      return "?";
    }
    return data[index]["hometeam"];
  }

  String getDate() {
    return "${dateNextSaturday.day}-${dateNextSaturday.month}-${dateNextSaturday.year}";
  }
}
