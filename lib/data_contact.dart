import 'dart:convert';

import 'package:http/http.dart' as http;

class DataContact {
  static final instance = DataContact._internal();

  DataContact._internal();

  List data = [];

  void add(Map map) {
    data.add(map);
  }

  Future getContacts() async {
    var result = await http.get(
      Uri.parse("http://apps-mark.nl/aetos/contacts.json"),
    );
    if (result.statusCode == 200) {
      return parse(jsonDecode(result.body)['contacts']);
    } else {
      throw Exception('Failed to load contacts');
    }
  }

  void parse(List inputStream) {
    data.clear();
    for (int index = 0; index < inputStream.length; index++) {
      data.add({
        "type": inputStream[index]["type"],
        "title": inputStream[index]["title"],
        "mail": inputStream[index]["mail"],
      });
    }
  }
}
