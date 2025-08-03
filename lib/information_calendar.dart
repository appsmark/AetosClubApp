import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'constants.dart';
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

      htmlcontent = r"""
<font color="#F9B234">
<html>
<head>
<style>
h1 {text-align: center;}
h2 {text-align: center;}
p {text-align: center;}
div {text-align: center;}
</style>
</head>
<body>
<hr style="border: 1px solid #00AADE">
whoopy
<h1>Abeach start vrij spelen</h1>
<h1>7 april</h2>

<hr style="height:20px;border-width:0;color:gray;background-color:gray">
<h1>Abeach start trainingen</h1>
<h1>7 mei</h2>
<hr />
<h1>Abeach Openingstoernooi</h1>
<h2>31 mei</h2>
<hr style="border: 1px solid #00AADE">
<h1>EINDFEEST 2024-2025</h1>
<h2>21 juni 20:00 - 01:00</h2>
<hr style="border: 1px solid #00AADE">
</body>
</font>
""";
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
      backgroundColor: Constants().colorBackground,
      appBar: AppBar(
        toolbarHeight: sizes.heightToolbar,
        backgroundColor: Constants().colorBackground,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            size: 0.05 * sizes.screenHeight,
            color: Constants().colorTitle,
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
              color: Constants().colorTitle,
              fontSize: sizes.sizeFontTitle,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          separator(),
          SingleChildScrollView(
            child: Html(
              data: htmlcontent,
            ),
          ),
        ],
      ),
    );
  }

  Divider separator() {
    return Divider(
      indent: 0.05 * sizes.screenWidth,
      endIndent: 0.05 * sizes.screenWidth,
      color: Constants().colorTitle,
    );
  }
}
