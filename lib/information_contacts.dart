import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants.dart';
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

  launchMailto(String address) async {
    final mailtoLink = Mailto(
      to: [address],
      subject: 'Mail vanuit Aetos app',
      body: 'Beste lezer,',
    );
    await launchUrl(Uri.parse('$mailtoLink'));
  }

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
      backgroundColor: Constants().colorBackground,
      appBar: AppBar(
        toolbarHeight: sizes.heightToolbar,
        backgroundColor: Constants().colorBackground,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            size: 0.05 * sizes.screenHeight,
            color: Constants().colorTitle,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          sizes.tablet ? "CONTACT PERSONEN" : "CONTACT\nPERSONEN",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Constants().colorTitle,
              fontSize: sizes.tablet
                  ? sizes.sizeFontTitle
                  : 0.8 * sizes.sizeFontTitle,
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
                GestureDetector(
                  onTap: () {
                    launchMailto(contacts[index]['mail']);
                  },
                  child: Text(
                    contacts[index]['mail'],
                    style: TextStyle(
                        color: const Color(0xFF00AADE),
                        fontWeight: FontWeight.bold,
                        fontSize: sizes.sizeFontRanking),
                  ),
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
      color: Constants().colorTitle,
    );
  }
}
