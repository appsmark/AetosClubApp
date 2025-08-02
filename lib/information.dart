import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'easter_egg.dart';
import 'information_calendar.dart';
import 'information_contacts.dart';
import 'information_duties.dart';
import 'information_general.dart';
import 'information_points.dart';
import 'manual.dart';
import 'sizes.dart';

class Information extends StatefulWidget {
  const Information({super.key});

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  EasterEgg easterEgg = EasterEgg.instance;
  Sizes sizes = Sizes.instance;

  @override
  void initState() {
    easterEgg.reset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: sizes.colorBackground,
        /*
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
          title: GestureDetector(
            onDoubleTap: () {
              easterEgg.trigger();
              setState(() {});
            },
            child: Text(
              easterEgg.triggered()
                  ? "${easterEgg.result(0)}     ${easterEgg.result(1)}"
                  : "INFORMATIE",
              style: TextStyle(
                  color: sizes.colorTitle,
                  fontSize: sizes.sizeFontTitle,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        */
        body: Column(
          children: [
            Container(height: sizes.spacingButtons),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 100),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return const Manual();
                        }));
              },
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(sizes.buttonWidth, sizes.buttonHeight),
                  shape: const StadiumBorder(),
                  side: BorderSide(
                      color: Colors.black, width: sizes.buttonBorderWidth),
                  backgroundColor: sizes.colorButton),
              child: Padding(
                padding: EdgeInsets.all(sizes.buttonPadding),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    "OPBERGEN\nMATERIAAL ZAAL",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: sizes.sizeFontButton,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Container(height: sizes.spacingButtons),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 100),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return const InformationContacts();
                        }));
              },
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(sizes.buttonWidth, sizes.buttonHeight),
                  shape: const StadiumBorder(),
                  side: BorderSide(
                      color: Colors.black, width: sizes.buttonBorderWidth),
                  backgroundColor: sizes.colorButton),
              child: Padding(
                padding: EdgeInsets.all(sizes.buttonPadding),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    "OVERZICHT\nCONTACTPERSONEN",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: sizes.sizeFontButton,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Container(height: sizes.spacingButtons),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 100),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return const InformationDuties();
                        }));
              },
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(sizes.buttonWidth, sizes.buttonHeight),
                  shape: const StadiumBorder(),
                  side: BorderSide(
                      color: Colors.black, width: sizes.buttonBorderWidth),
                  backgroundColor: sizes.colorButton),
              child: Padding(
                padding: EdgeInsets.all(sizes.buttonPadding),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    "INFORMATIE OVER\nTEL/FLUIT/ZAALDIENST",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: sizes.sizeFontButton,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Container(height: sizes.spacingButtons),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 100),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return const InformationPoints();
                        }));
              },
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(sizes.buttonWidth, sizes.buttonHeight),
                  shape: const StadiumBorder(),
                  side: BorderSide(
                      color: Colors.black, width: sizes.buttonBorderWidth),
                  backgroundColor: sizes.colorButton),
              child: Padding(
                padding: EdgeInsets.all(sizes.buttonPadding),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    "INFORMATIE OVER\nAETOS PUNTEN",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: sizes.sizeFontButton,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Container(height: sizes.spacingButtons),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 100),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return const InformationGeneral();
                        }));
              },
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(sizes.buttonWidth, sizes.buttonHeight),
                  shape: const StadiumBorder(),
                  side: BorderSide(
                      color: Colors.black, width: sizes.buttonBorderWidth),
                  backgroundColor: sizes.colorButton),
              child: Padding(
                padding: EdgeInsets.all(sizes.buttonPadding),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    "ALGEMENE\nINFORMATIE",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: sizes.sizeFontButton,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Container(height: sizes.spacingButtons),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 100),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return const InformationCalendar();
                        }));
              },
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(sizes.buttonWidth, sizes.buttonHeight),
                  shape: const StadiumBorder(),
                  side: BorderSide(
                      color: Colors.black, width: sizes.buttonBorderWidth),
                  backgroundColor: sizes.colorButton),
              child: Padding(
                padding: EdgeInsets.all(sizes.buttonPadding),
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    "KALENDER\n2025",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: sizes.sizeFontButton,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: sizes.spacingButtons,
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                    onTap: () {
                      launchAppsMark();
                    },
                    child: Text(
                      "www.apps-mark.nl",
                      style: TextStyle(fontSize: sizes.sizeFontTitle),
                    )),
              ],
            )),
          ],
        ));
  }

  Divider separator() {
    return Divider(
      indent: 0.05 * sizes.screenWidth,
      endIndent: 0.05 * sizes.screenWidth,
      color: sizes.colorTitle,
    );
  }

  Future<void> launchAppsMark() async {
    final Uri url = Uri(scheme: 'http', host: 'www.apps-mark.nl');

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
