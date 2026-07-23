/*
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rss_dart/dart_rss.dart';
import 'package:rss_dart/domain/rss_content.dart';
import 'package:xml/xml.dart';

void main(List<String> arguments) {
  Client client = Client();
  getRssFeed(client).then((value) {
    //  List<Information> informationList = parseRSS(value);
    // printInformationList(informationList);
    const dcNamespace = 'https://aetos-arnhem.nl/rss/ns';
    String xmlstring = value.toString();
    /*
    final document = XmlDocument.parse(xmlstring);
    final item = document.findAllElements('item').first;
    final Iterable<XmlElement> items = document.childElements;
   
}*/
    var storeDocument = XmlDocument.parse(xmlstring);
    debugPrint(storeDocument.findAllElements('item').toString());
    final String it = storeDocument.findAllElements('item').toString();
    debugPrint(it);
    /*
    for (int i = 0; i < storeDocument.findAllElements('item').length; i++) {
      it.add(document.findElements('item').single);
    } 
    final creatorElement = item
        .findElements('sporthal', namespace: dcNamespace)
        .firstOrNull;
    if (creatorElement != null) {
      debugPrint(creatorElement.innerText);
    }*/
  });
}

Future<String> getRssFeed(Client client) async {
  Response response = Response('', 200);
  try {
    response = await client.get(
      Uri(
        scheme: 'https',
        host: 'aetos-wedstijden.lovable.app',
        path: '/api/public/rss',
      ),
    );
  } catch (e) {
    debugPrint(e.toString());
  }
  const dcNamespace = 'https://aetos-arnhem.nl/rss/ns';
  Iterable creatorElement;
  XmlElement? node;
  final document = XmlDocument.parse(response.body);
  final item = document.findAllElements('item');
  for (int i = 0; i < document.findAllElements('item').length; i++) {
    //    debugPrint(document.findAllElements('item').toString());
    node = item.elementAt(i).getElement('category');
    if (node!.firstChild?.value == "Zaaldienst") {
      creatorElement = item
          .elementAt(i)
          .findElements('begintijd', namespace: dcNamespace);
      if (creatorElement.isNotEmpty) {
        debugPrint(creatorElement.single.text);
      }
    } else {
      /*
      debugPrint(item.elementAt(i).getElement('category').toString());
      creatorElement = item
          .elementAt(i)
          .findElements('wedstrijdcode', namespace: dcNamespace);
      if (creatorElement != null) {
        if (creatorElement.isNotEmpty) {
          debugPrint(creatorElement?.single.text);
        }
      }
    */
    }
  }

  /*
  final creatorElement = item
      .findElements('sporthal', namespace: dcNamespace)
      .firstOrNull;

  debugPrint(creatorElement?.innerText);
  //  return RssFeed.parse(response.body);
  */
  return (response.body);
}

List<Information> parseRSS(RssFeed feed) {
  List<Information> informationList = [];
  for (var item in feed.items) {
    Information blogInformation = Information(
      //      date: item.pubDate!,
      title: item.title!,
      aetos: item.content,
      text: item.content?.value,
      //  imageUrl: item.content?.images.first,
      //link: feed.items.first.link,
    );
    informationList.add(blogInformation);
  }
  return informationList;
}

class Information {
  RssContent? aetos;
  String? text;
  String title;
  Information({required this.text, required this.title, required this.aetos});
}
*/
