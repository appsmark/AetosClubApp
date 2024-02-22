import 'package:flutter/material.dart';

import 'rss_ranking.dart';
import 'ranking_data.dart';
import 'sizes.dart';

class Ranking extends StatefulWidget {
  const Ranking({super.key});

  @override
  State<Ranking> createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  RankingData data = RankingData.instance;
  List listOfItems = [];
  RssRanking rss = RssRanking();
  Sizes sizes = Sizes.instance;

  Future getData() async {
    await rss.getRanking();
    setState(() {
      listOfItems = data.getTeams();
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
            "STAND",
            style: TextStyle(
                color: sizes.colorTitle,
                fontSize: sizes.sizeFontTitle,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            separator(),
            Text(
              data.competition,
              style: TextStyle(
                  color: sizes.colorCompetition,
                  fontWeight: FontWeight.bold,
                  fontSize: sizes.sizeFontCompetition),
            ),
            separator(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 0.02 * sizes.screenWidth,
                  right: 0.05 * sizes.screenWidth,
                ),
                child: Table(columnWidths: {
                  0: FixedColumnWidth(0.15 * sizes.screenWidth),
                  1: FlexColumnWidth(0.4 * sizes.screenWidth),
                  2: FixedColumnWidth(0.1 * sizes.screenWidth),
                  3: FixedColumnWidth(0.01 * sizes.screenWidth),
                  4: FixedColumnWidth(0.1 * sizes.screenWidth),
                }, children: [
                  for (var item in listOfItems)
                    TableRow(children: [
                      Padding(
                        padding:
                            EdgeInsets.only(top: 0.01 * sizes.screenHeight),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "${listOfItems.indexOf(item) + 1}  ",
                            style: TextStyle(
                                color: sizes.colorRanking,
                                fontWeight: FontWeight.bold,
                                fontSize: sizes.sizeFontRanking),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 0.01 * sizes.screenHeight),
                        child: Text(
                          item['team'],
                          style: TextStyle(
                              color: sizes.colorRanking,
                              fontWeight: FontWeight.bold,
                              fontSize: sizes.sizeFontRanking),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 0.01 * sizes.screenHeight),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "${item['games']}",
                            style: TextStyle(
                                color: sizes.colorRanking,
                                fontWeight: FontWeight.bold,
                                fontSize: sizes.sizeFontRanking),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 0.01 * sizes.screenHeight),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            " - ",
                            style: TextStyle(
                                color: sizes.colorRanking,
                                fontWeight: FontWeight.bold,
                                fontSize: sizes.sizeFontRanking),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 0.01 * sizes.screenHeight),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "${item['points']}",
                            style: TextStyle(
                                color: sizes.colorRanking,
                                fontWeight: FontWeight.bold,
                                fontSize: sizes.sizeFontRanking),
                          ),
                        ),
                      ),
                    ])
                ]),
              ),
            )
          ],
        ));
  }

  Padding separator() {
    return Padding(
      padding: EdgeInsets.only(
        left: 0.05 * sizes.screenWidth,
        right: 0.05 * sizes.screenWidth,
      ),
      child: Divider(
        color: sizes.colorTitle,
      ),
    );
  }
}
