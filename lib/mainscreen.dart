import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ranking.dart';
import 'settingsscreen.dart';
//import 'rss.dart';

import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  RssFeed? _rssFeed = null; // RSS Feed Object
  List _teams = [];
  List _points = [];

  Future<RssFeed?> getRSS() async {
    var url = Uri.parse(
        "https://api.nevobo.nl/export/poule/regio-oost/DPD/stand.rss");

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    var xml;
    if (response.statusCode == 200) {
      //     debugPrint('======');
//      debugPrint(response.body);
      xml = '<?xml version="1.0" encoding="UTF-8"?>\n<ranks>\n' +
          response.body.substring(response.body.indexOf('<stand'));
      xml = xml.substring(0, xml.indexOf('</channel'));
      //   xml = xml.replaceAll('stand:puntenvoor>0', 'stand:puntenvoor:>3');
      xml = xml + '\n</ranks>';
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    //   var rssFeed = new RssFeed.parse(response.body);
    //debugPrint('=+=+=+=+=+=');
    //   debugPrint(xml);
    final document = XmlDocument.parse(xml);

    final ranking = document.findElements('ranks').first;

    final students = ranking.findElements('stand:ranking');
    for (final student in students) {
      final teamName = student.findElements('stand:team').first.text;
      final pointsTeam = student.findElements('stand:puntenvoor').first.text;
      _teams.add(teamName);
      _points.add(pointsTeam);
    }
    debugPrint(_points.first);
    debugPrint(_teams.first);
    debugPrint(_teams.last);
/*
    final client = http.Client();
    try {
      final response = await client.get(Uri.parse(
          "https://api.nevobo.nl/export/poule/regio-oost/DPD/stand.rss"));
      return RssFeed.parse(response.body);
    } catch (e) {
      print(e);
    } finally {
      client.close();
    }
    */
    return null;
  }

  updateFeed(feed) {
    setState(() {
      _rssFeed = feed;
    });
  }

  @override
  void initState() {
    super.initState();

    // Suppress statusbar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);

    getRSS();
/*
    getRSS().then((feed) {
      // Update the _feed variable
      updateFeed(feed);

      // print feed Metadata
      print('FEED METADATA');
      print('------------------');
      print('Link: ${feed?.link}');
      print('Description: ${feed?.description}');
      print('Docs: ${feed?.docs}');
      print('Last build data: ${feed?.lastBuildDate}');
      print('Number of items: ${feed?.items?.length}');
      print('Number of rankings: ${feed?.items?.first.description}');
*/
/*
      for (RssItem rssItem in feed.items) {
        // Only print the titles of the articles: comments do not have a description (subtitle), but articles do
        if (rssItem.description != null) {
          print('Title: ${rssItem.title}');
          print('Link: ${rssItem.link}');
          print('Publish date: ${rssItem.pubDate.toString()}');

          // Create a new Medium article from the rssitem
          MediumArticle mediumArticle = MediumArticle(
              title: rssItem.title,
              link: rssItem.link,
              datePublished: rssItem.pubDate.toString());

          // Add the article to the list
          _mediumArticles.add(mediumArticle);
        }
      }
      */
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = 0.8 * screenWidth;
    double spacingButtons = 0.02 * screenHeight;
    return Scaffold(
      backgroundColor: const Color(0xFF731816),
      appBar: AppBar(
        actions: [
          GestureDetector(
            child: const Icon(Icons.more_vert),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsScreen()));
            },
          ),
        ],
        title: const Text(
          "TEAM H6",
          style: TextStyle(color: Color(0xFF00AADE), fontSize: 35),
        ),
        backgroundColor: const Color(0xFF731816),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xFF731816),
            height: 0.8 * screenHeight,
            width: screenWidth,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Ranking()));
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(buttonWidth, 90),
                      shape: const StadiumBorder(),
                      side: const BorderSide(color: Colors.black, width: 4),
                      backgroundColor: const Color(0xFFF9B234)),
                  child: const Padding(
                    padding: EdgeInsets.all(28),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        'STAND',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 45,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(height: spacingButtons),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Ranking()));
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(buttonWidth, 90),
                      shape: const StadiumBorder(),
                      side: const BorderSide(color: Colors.black, width: 4),
                      backgroundColor: const Color(0xFFF9B234)),
                  child: const Padding(
                    padding: EdgeInsets.all(28.0),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text('PROGRAMMA',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 35,
                          )),
                    ),
                  ),
                ),
                Container(height: spacingButtons),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Ranking()));
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(buttonWidth, 90),
                      shape: const StadiumBorder(),
                      side: const BorderSide(color: Colors.black, width: 4),
                      backgroundColor: const Color(0xFFF9B234)),
                  child: const Padding(
                    padding: EdgeInsets.all(28.0),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text('WEDSTRIJD',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 35,
                          )),
                    ),
                  ),
                ),
                Container(height: 2 * spacingButtons),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Ranking()));
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(buttonWidth, 90),
                      shape: const StadiumBorder(),
                      side: const BorderSide(color: Colors.black, width: 4),
                      backgroundColor: const Color(0xFFF9B234)),
                  child: const Padding(
                    padding: EdgeInsets.all(28.0),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text('ZAALDIENST',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 35,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
