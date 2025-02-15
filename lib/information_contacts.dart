import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'sizes.dart';

class InformationContacts extends StatefulWidget {
  const InformationContacts({super.key});

  @override
  State<InformationContacts> createState() => _InformationContactsState();
}

class _InformationContactsState extends State<InformationContacts> {
  List contacts = [];
  Sizes sizes = Sizes.instance;
  List listOfItems = [];

  Future getData() async {
    final response =
        await http.get(Uri.parse("http://apps-mark.nl/aetos/contacts"));
    if (response.statusCode == 200) {
      listOfItems = response.body.split('\n');
      for (int index = 0; index < listOfItems.length; index += 3) {
        contacts.add({
          'function': listOfItems[index],
          'name': listOfItems[index + 1],
          'mail': listOfItems[index + 2]
        });
      }
    } else {
      throw Exception('Failed to load data');
    }
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
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
          "CONTACT\nPERSONEN",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: sizes.colorTitle,
              fontSize: sizes.sizeFontTitle,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return Column(
              children: [
                separator(),
                Text(
                  contacts[index]['function'],
                  style: TextStyle(
                      color: const Color(0xFFF9B234),
                      fontWeight: FontWeight.bold,
                      fontSize: sizes.sizeFontRanking),
                ),
                if (contacts[index]['name'].toString().isNotEmpty)
                  Text(
                    contacts[index]['name'],
                    style: TextStyle(
                        color: const Color(0xFFF9B234),
                        fontWeight: FontWeight.bold,
                        fontSize: sizes.sizeFontRanking),
                  ),
                Text(
                  contacts[index]['mail'],
                  style: TextStyle(
                      color: const Color(0xFF00AADE),
                      fontWeight: FontWeight.bold,
                      //      decoration: TextDecoration.underline,
                      fontSize: sizes.sizeFontRanking),
                ),
              ],
            );
          }),
    );
  }

  Divider separator() {
    return Divider(
      indent: 0.05 * sizes.screenWidth,
      endIndent: 0.05 * sizes.screenWidth,
      color: sizes.colorTitle,
    );
  }
}
