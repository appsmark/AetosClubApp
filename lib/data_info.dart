import 'dart:convert';

import 'package:http/http.dart' as http;

class DataInfo {
  static final instance = DataInfo._internal();

  DataInfo._internal();

  List data = [];

  Future getData() async {
    var result = await http.get(
      Uri.parse("http://apps-mark.nl/aetos/data_info.json"),
    );

    if (result.statusCode == 200) {
      return parse(jsonDecode(result.body)['contacts']);
    } else {
      throw Exception('Failed to load info');
    }
  }

  void parse(List inputStream) {
    String file = "";
    String title = "";
    String type = "";
    data.clear();
    for (int index = 0; index < inputStream.length; index++) {
      if (inputStream[index]["type"] != null) {
        type = inputStream[index]["type"];
        title = inputStream[index]["title"];
        if (inputStream[index]["file"] == null) {
          file = "";
        } else {
          file = inputStream[index]["file"];
        }
        data.add({'type': type, 'title': title, 'file': file});
      }
    }
  }
}
