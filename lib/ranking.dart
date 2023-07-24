import 'package:flutter/material.dart';
import 'data.dart';
import 'rss.dart';

class Ranking extends StatefulWidget {
  final List listOfItems;

//  final List listOfItems = teams  Ranking({Key? key}) : super(key: key);
  //final List listOfItems = List.generate(10, (index) => 'Sample Item - $index');
  const Ranking({Key? key, required this.listOfItems}) : super(key: key);

  @override
  State<Ranking> createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  @override
  void initState() {
    super.initState();
    getRSS("nationale-competitie/2BH");
  }

  @override
  Widget build(BuildContext context) {
    var listOfItems = data.getTeams();
    return Scaffold(
        backgroundColor: Colors.white, // const Color(0xFF731816),
        appBar: AppBar(
          backgroundColor: const Color(0xFF731816),
          centerTitle: true,
          title: const Text(
            "STAND",
            style: TextStyle(color: Color(0xFF00AADE), fontSize: 35),
          ),
        ),

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
  }
}
