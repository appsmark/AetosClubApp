import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import 'constants.dart';
import 'data_contact.dart';
import 'sizes.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  DataContact dataContact = DataContact.instance;
  String remotePDFpath = "";
  Sizes sizes = Sizes.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants().colorBackground,
      body: Center(child: Builder(
        builder: (BuildContext context) {
          return Column(
            children: [
              Expanded(
                  child: Scrollbar(
                interactive: true,
                thumbVisibility: true,
                child: ListView.builder(
                    itemCount: dataContact.data.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Column(
                        children: [
                          if (dataContact.data[index]['type'] == 'header')
                            separator(),
                          GestureDetector(
                            onTap: () {
                              if (dataContact.data[index]['type'] == 'mail') {
                                sendEmail(dataContact.data[index]['mail']);
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if (dataContact.data[index]['type'] == 'header')
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 0.1 * sizes.screenWidth),
                                    child: Text(
                                      dataContact.data[index]['title'],
                                      style: TextStyle(
                                          color: Constants().colorAetosBlue,
                                          fontSize: sizes.sizeFontSchedule,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                if (dataContact.data[index]['type'] == 'mail')
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 0.15 * sizes.screenWidth),
                                    child: Text(
                                      dataContact.data[index]['title'],
                                      style: TextStyle(
                                          color: Constants().colorAetosAmber,
                                          fontSize: sizes.sizeFontSchedule,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
              )),
            ],
          );
        },
      )),
    );
  }

  Divider separator() {
    return Divider(
      indent: 0.05 * sizes.screenWidth,
      endIndent: 0.05 * sizes.screenWidth,
      color: Constants().colorTitle,
    );
  }

  void sendEmail(String address) async {
    final Email email = Email(
      body: 'Beste Aetos vrijwilliger,',
      subject: 'Bericht vanuit Aetos app',
      recipients: [address],
      //  cc: ['cc@example.com'],
      //  bcc: ['bcc@example.com'],
      //  attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }
}
