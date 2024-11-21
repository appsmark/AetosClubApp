import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'points_data.dart';

class JsonPoints {
  PointsData pointsData = PointsData.instance;
  DateTime now = DateTime.now();
  bool testLocal = false;

  Future getPoints() async {
    if (testLocal) {
      String fileText = await rootBundle.loadString('assets/punten.json');
      //   debugPrint(fileText);
      return parse(jsonDecode(fileText)['points']);
    } else {
      var result = await http.get(Uri.parse("http://apps-mark.nl/punten.json"));

      if (result.statusCode == 200) {
        return parse(jsonDecode(result.body)['points']);
      } else {
        throw Exception('Failed to load points');
      }
    }
  }

  parse(inputStream) {
    /*
    String date = "";
    String team = "";
    String need = "";
    String remain = "";
    String points = "";
*/
    pointsData.clear();
    for (int index = 0; index < inputStream.length; index++) {
      pointsData.add({
        "date": inputStream[index]["date"],
        "team": inputStream[index]["team"],
        "need": inputStream[index]["need"],
        "points": inputStream[index]["points"],
        "remain": inputStream[index]["remain"],
      });
    }
  }
}
