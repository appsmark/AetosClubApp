import 'dart:convert';
import 'package:http/http.dart' as http;

import 'data.dart';
import 'duty_data.dart';

class JsonDuty {
  DutyData dutyData = DutyData.instance;

  Future getDuty() async {
    var result =
        await http.get(Uri.parse("http://apps-mark.nl/zaaldienst.json"));

    if (result.statusCode == 200) {
      return parse(jsonDecode(result.body)['duty']);
    } else {
      throw Exception('Failed to load ranking');
    }
  }

  parse(inputStream) {
    dutyData.clear();
    for (int index = 0; index < inputStream.length; index++) {
      if ((inputStream[index]["scheids"] == team.currentTeam) ||
          (inputStream[index]["teller"] == team.currentTeam)) {
        dutyData.add({
          "date": inputStream[index]["Datum"],
          "time": inputStream[index]["Tijd"],
          "hometeam": inputStream[index]["Thuisteam"],
          "visitor": inputStream[index]["Uitteam"],
          "hall": inputStream[index]["Locatie"],
          "referee": inputStream[index]["scheids"],
          "counter": inputStream[index]["teller"],
        });
      }
    }
  }
}
