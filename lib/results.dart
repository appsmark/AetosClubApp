import 'package:flutter/material.dart';

import 'rss_results.dart';
import 'results_data.dart';
import 'sizes.dart';

class Results extends StatefulWidget {
  const Results({super.key});

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  ResultsData data = ResultsData.instance;
  List listOfItems = [];
  RssResults rss = RssResults();
  Sizes sizes = Sizes.instance;

  Future getData() async {
    await rss.getResults();
    setState(() {
      listOfItems = data.getGames();
    });
  }

  @override
  initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: sizes.colorBackground,
        /*
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
            "UITSLAGEN",
            style: TextStyle(
                color: sizes.colorTitle,
                fontSize: sizes.sizeFontTitle,
                fontWeight: FontWeight.bold),
          ),
        ),*/
        body: Column(
          children: [
            SizedBox(
              height: 0.05 * sizes.screenHeight,
            ),
            separator(),
            Expanded(
                child: ListView.builder(
                    itemCount: listOfItems.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Column(
                        children: [
                          Text(
                            listOfItems[index]['game'],
                            style: TextStyle(
                                color: sizes.colorResults,
                                fontSize: sizes.sizeFontResults,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                listOfItems[index]['result'],
                                style: TextStyle(
                                    color: sizes.colorResults,
                                    fontSize: sizes.sizeFontResults,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 0.06 * sizes.screenWidth),
                              Text(
                                listOfItems[index]['totals1'] != ""
                                    ? "${listOfItems[index]['totals1']}-${listOfItems[index]['totals2']}"
                                    : "",
                                style: TextStyle(
                                    color: sizes.colorResults,
                                    fontSize: sizes.sizeFontResults,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Text(
                            listOfItems[index]['sets'],
                            style: TextStyle(
                                color: sizes.colorResults,
                                fontSize: sizes.sizeFontResults,
                                fontWeight: FontWeight.bold),
                          ),
                          separator(),
                        ],
                      );
                    }))
          ],
        ));
  }

  Divider separator() {
    return Divider(
      indent: 0.05 * sizes.screenWidth,
      endIndent: 0.05 * sizes.screenWidth,
      color: sizes.colorTitle,
    );
  }
}
