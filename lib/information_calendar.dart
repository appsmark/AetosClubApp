import 'package:flutter/material.dart';

import 'sizes.dart';

class InformationCalendar extends StatefulWidget {
  const InformationCalendar({super.key});

  @override
  State<InformationCalendar> createState() => _InformationCalendarState();
}

class _InformationCalendarState extends State<InformationCalendar> {
  Sizes sizes = Sizes.instance;

  @override
  void initState() {
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
        body: Column(
          children: [Text("plop")],
        ));
  }
}
