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
          backgroundColor: sizes.colorBackground,
          leading: BackButton(
            color: sizes.colorTitle,
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
            Text(
              data.competition,
              style: TextStyle(
                  color: sizes.colorCompetition,
                  fontSize: sizes.sizeFontCompetition),
            ),
            separator(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(28.0),
                child: Table(columnWidths: {
                  0: FixedColumnWidth(30),
                  1: FlexColumnWidth(200),
                  2: FixedColumnWidth(80)
                }, children: [
                  for (var item in listOfItems)
                    TableRow(children: [
                      Text(
                        (1 + listOfItems.indexOf(item)).toString(),
                        style: TextStyle(
                            color: sizes.colorRanking,
                            fontSize: sizes.sizeFontRanking),
                      ),
                      Text(
                        item['team'],
                        style: TextStyle(
                            color: sizes.colorRanking,
                            fontSize: sizes.sizeFontRanking),
                      ),
                      Text(
                        "${item['games']} - ${item['points']}",
                        style: TextStyle(
                            color: sizes.colorRanking,
                            fontSize: sizes.sizeFontRanking),
                      ),
                    ])
                ]),
              ),
            )
          ],
        ));
  }

  Text separator() {
    return Text(
      "---------------------------------------------------",
      style: TextStyle(color: sizes.colorRanking, fontSize: 20),
    );
  }
}
