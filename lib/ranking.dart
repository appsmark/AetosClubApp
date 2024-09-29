import 'package:flutter/material.dart';

import 'data.dart';
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
    data.clear();
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
            for (var item in listOfItems)
              Padding(
                padding: EdgeInsets.only(top: 0.018 * sizes.screenHeight),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 0.075 * sizes.screenWidth,
                        child: Text(
                          "${listOfItems.indexOf(item) + 1}",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: item['team'].contains(
                                      "AETOS ${team.currentTeam.replaceAll('-', ' ')}")
                                  ? sizes.colorTitle
                                  : sizes.colorRanking,
                              fontWeight: FontWeight.bold,
                              fontSize: sizes.sizeFontRanking),
                        )),
                    SizedBox(
                      width: 0.05 * sizes.screenWidth,
                    ),
                    SizedBox(
                        width: 0.5 * sizes.screenWidth,
                        child: Text(
                          item['team'],
                          style: TextStyle(
                              color: item['team'].contains(
                                      "AETOS ${team.currentTeam.replaceAll('-', ' ')}")
                                  ? sizes.colorTitle
                                  : sizes.colorRanking,
                              fontWeight: FontWeight.bold,
                              fontSize: sizes.sizeFontRanking),
                        )),
                    SizedBox(
                        width: 0.075 * sizes.screenWidth,
                        child: Text(
                          item['games'],
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: item['team'].contains(
                                      "AETOS ${team.currentTeam.replaceAll('-', ' ')}")
                                  ? sizes.colorTitle
                                  : sizes.colorRanking,
                              fontWeight: FontWeight.bold,
                              fontSize: sizes.sizeFontRanking),
                        )),
                    SizedBox(
                        width: 0.05 * sizes.screenWidth,
                        child: Text(
                          "-",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: item['team'].contains(
                                      "AETOS ${team.currentTeam.replaceAll('-', ' ')}")
                                  ? sizes.colorTitle
                                  : sizes.colorRanking,
                              fontWeight: FontWeight.bold,
                              fontSize: sizes.sizeFontRanking),
                        )),
                    SizedBox(
                        width: 0.079 * sizes.screenWidth,
                        child: Text(
                          item['points'],
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: item['team'].contains(
                                      "AETOS ${team.currentTeam.replaceAll('-', ' ')}")
                                  ? sizes.colorTitle
                                  : sizes.colorRanking,
                              fontWeight: FontWeight.bold,
                              fontSize: sizes.sizeFontRanking),
                        ))
                  ],
                ),
              ),
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
