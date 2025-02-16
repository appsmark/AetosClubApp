import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'sizes.dart';

class InformationGeneral extends StatefulWidget {
  const InformationGeneral({super.key});

  @override
  State<InformationGeneral> createState() => _InformationGeneralState();
}

class _InformationGeneralState extends State<InformationGeneral> {
  Sizes sizes = Sizes.instance;
  String htmlcontent = "";

  Future getData() async {
    final response =
        await http.get(Uri.parse("http://apps-mark.nl/aetos/info_general"));
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
          sizes.tablet ? "ALGEMENE INFORMATIE" : "ALGEMENE\nINFORMATIE",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: sizes.colorTitle,
              fontSize: sizes.tablet
                  ? sizes.sizeFontTitle
                  : 0.8 * sizes.sizeFontTitle,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SizedBox(
        child: SingleChildScrollView(
          child: Html(
            data: htmlcontent,
          ),
        ),
      ),
    );
  }
}
