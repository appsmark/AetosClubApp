import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'data.dart';
import 'duty_data.dart';

class JsonDuty {
  DutyData dutyData = DutyData.instance;
  DateTime now = DateTime.now();

  Future getDuty() async {
    var result =
        await http.get(Uri.parse("http://apps-mark.nl/zaaldienst.json"));

    if (result.statusCode == 200) {
      return parse(jsonDecode(result.body)['duty']);
    } else {
      throw Exception('Failed to load ranking');
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

  parse(inputStream) {
    dutyData.clear();
    for (int index = 0; index < inputStream.length; index++) {
      DateTime tempDate =
          DateFormat("dd MMM yyyy").parse(convert(inputStream[index]["Datum"]));
      if (tempDate.difference(DateTime.now()).inDays >= 0) {
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
