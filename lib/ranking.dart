import 'package:flutter/material.dart';
import 'data.dart';
import 'rss.dart';

class Ranking extends StatefulWidget {
  // final List listOfItems;

  const Ranking({Key? key}) : super(key: key);
//  const Ranking({Key? key, required this.listOfItems}) : super(key: key);

  @override
  State<Ranking> createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  var listOfItems = data.getTeams();
  int i = 0;
  Team team = Team();
  TeamInfo teamInfo = TeamInfo();

  @override
  void initState() {
    super.initState();
    getRSS(teamInfo.getRanking(team.currentTeam));
    listOfItems = data.getTeams();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("ranking");
    listOfItems = data.getTeams();
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
            style: TextStyle(color: Color(0xFF00AADE), fontSize: 35),
          ),
        ),
        body: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  data.competition,
                  style: const TextStyle(
                      color: Color(0xFF00AADE),
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: listOfItems.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Row(children: [
                        /*
                CircleAvatar(
                    child: Text(
                  index.toString(),
                  style: TextStyle(fontSize: 20),
                )),
              */
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 18.0, bottom: 8, top: 8),
                          child: SizedBox(
                            width: 35,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                (index + 1).toString(),
                                style: TextStyle(
                                    color: listOfItems[index].team() ==
                                            "AETOS ${team.currentTeam}"
                                        ? const Color(0xFF00AADE)
                                        : const Color(0xFFF9B234),
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 180,
                          child: Text(
                            listOfItems[index].team(),
                            style: listOfItems[index].team() ==
                                    "AETOS ${team.currentTeam}"
                                ? const TextStyle(
                                    color: Color(0xFF00AADE), fontSize: 20)
                                : const TextStyle(
                                    color: Color(0xFFF9B234), fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              index == 5
                                  ? "45"
                                  : listOfItems[index].pointsPro(),
                              style: TextStyle(
                                  //backgroundColor: Colors.amber,
                                  color: listOfItems[index].team() ==
                                          "AETOS ${team.currentTeam}"
                                      ? const Color(0xFF00AADE)
                                      : const Color(0xFFF9B234),
                                  fontSize: 20),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 13,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "-",
                              style: TextStyle(
                                  color: listOfItems[index].team() ==
                                          "AETOS ${team.currentTeam}"
                                      ? const Color(0xFF00AADE)
                                      : const Color(0xFFF9B234),

                                  //backgroundColor: Colors.white,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              index == 5
                                  ? "45"
                                  : listOfItems[index].pointsPro(),
                              style: TextStyle(
                                  //backgroundColor: Colors.yellow,
                                  color: listOfItems[index].team() ==
                                          "AETOS ${team.currentTeam}"
                                      ? const Color(0xFF00AADE)
                                      : const Color(0xFFF9B234),
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      ]);
                    }))
          ],
        )
/*
      body: ListView.builder(
          itemCount: listOfItems.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                debugPrint('Tapped on item #$index');
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(listOfItems[index].team() +
                        "     " +
                        listOfItems[index].pointsPro()),
                  ],
                ),
              ),
            );
          }),
*/
/*
        body: ListView.separated(
          separatorBuilder: (context, inta) {
            return const Divider(
              color: Colors.black,
            );
          },
          // shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              childAspectRatio: 2.0,
              children: [
                Center(child: Text(listOfItems[index].team())),
                Center(child: Text(listOfItems[index].pointsPro())),
                Center(child: Text(listOfItems[index].team())),
              ],
            );
          },
          itemCount: listOfItems.length,
        ));
        */
        );
  }
}
