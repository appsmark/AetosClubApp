import 'package:flutter/material.dart';

import 'sizes.dart';

class InformationGeneral extends StatefulWidget {
  const InformationGeneral({super.key});

  @override
  State<InformationGeneral> createState() => _InformationGeneralState();
}

class _InformationGeneralState extends State<InformationGeneral> {
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
            "ALGEMENE\nINFORMATIE",
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
