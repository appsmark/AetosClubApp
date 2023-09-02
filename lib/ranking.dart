import 'package:flutter/material.dart';
import 'data.dart';
import 'rss.dart';

class Ranking extends StatefulWidget {
  final List listOfItems;

  const Ranking({Key? key, required this.listOfItems}) : super(key: key);

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

  String ranking() {
    for (int i = 0; i < 5; i++) {}
    return ("hoppa");
  }

  @override
  Widget build(BuildContext context) {
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
        body: ListView.builder(
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
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 35,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        index.toString(),
                        style:
                            TextStyle(color: Color(0xFFF9B234), fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 140,
                  child: Text(
                    listOfItems[index].team(),
                    style: TextStyle(color: Color(0xFFF9B234), fontSize: 20),
                  ),
                ),
                SizedBox(
                  width: 10,
                  child: Text(
                    listOfItems[index].pointsPro(),
                    style: TextStyle(color: Color(0xFFF9B234), fontSize: 20),
                  ),
                ),
                SizedBox(
                  width: 20,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "-",
                      style: TextStyle(color: Color(0xFFF9B234), fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                  child: Text(
                    listOfItems[index].pointsPro(),
                    style: TextStyle(color: Color(0xFFF9B234), fontSize: 20),
                  ),
                ),
              ]);
            })
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
