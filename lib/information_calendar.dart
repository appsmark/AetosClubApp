import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'sizes.dart';

class InformationCalendar extends StatefulWidget {
  const InformationCalendar({super.key});

  @override
  State<InformationCalendar> createState() => _InformationCalendarState();
}

class _InformationCalendarState extends State<InformationCalendar> {
  Sizes sizes = Sizes.instance;
  String htmlcontent = "";

  Future getData() async {
    final response =
        await http.get(Uri.parse("http://apps-mark.nl/aetos/info_calendar"));
    if (response.statusCode == 200) {
      htmlcontent = response.body;
    } else {
      htmlcontent =
          '<font color="#F9B234"><h1>NOG NIET BESCHIKBAAR</h1></font>';
    }
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: sizes.colorBackground,
      appBar: AppBar(
        toolbarHeight: sizes.heightToolbar,
        backgroundColor: sizes.colorBackground,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            size: 0.05 * sizes.screenHeight,
            color: sizes.colorTitle,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          "KALENDER",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: sizes.colorTitle,
              fontSize: sizes.sizeFontTitle,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SizedBox(
        child: Html(
          data: htmlcontent,
        ),
      ),
    );
  }
}
