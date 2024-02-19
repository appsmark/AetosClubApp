import 'package:flutter/material.dart';

import 'rss_ranking.dart';
import 'ranking_data.dart';

class Ranking extends StatefulWidget {
  const Ranking({super.key});

  @override
  State<Ranking> createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  RankingData data = RankingData.instance;
  List listOfItems = [];
  RssRanking rss = RssRanking();

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
        backgroundColor: const Color(0xFF731816),
        appBar: AppBar(
          backgroundColor: const Color(0xFF731816),
          leading: const BackButton(
            color: Color(0xFF00AADE),
          ),
          centerTitle: true,
          title: const Text(
            "STAND",
            style: TextStyle(
                color: Color(0xFF00AADE),
                fontSize: 35,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Text(
              data.competition,
              style: const TextStyle(color: Color(0xFFF9B234), fontSize: 20),
            ),
            separator(),
            Expanded(
                child: ListView.builder(
                    itemCount: listOfItems.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 0.02 * MediaQuery.of(context).size.height,
                              left: 0.1 * MediaQuery.of(context).size.width,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "${index + 1}   ",
                                  style: const TextStyle(
                                      color: Color(0xFFF9B234), fontSize: 20),
                                ),
                                Text(
                                  listOfItems[index]['team'],
                                  style: const TextStyle(
                                      color: Color(0xFFF9B234), fontSize: 20),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, right: 2),
                                  child: Text(
                                    "${listOfItems[index]['games']} - ${listOfItems[index]['points']}",
                                    style: const TextStyle(
                                        color: Color(0xFFF9B234), fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }))
          ],
        ));
  }

  Text separator() {
    return const Text(
      "---------------------------------------------------",
      style: TextStyle(color: Color(0xFFF9B234), fontSize: 20),
    );
  }
}
