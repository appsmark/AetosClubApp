import 'dart:async';
import 'dart:io';

import 'package:aetos/info_image.dart';
import 'package:aetos/pdfscreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'constants.dart';
import 'data_info.dart';
import 'sizes.dart';

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  List listOfItems = [
    {'type': '', 'title': '', 'file': ''}
  ];
  String remotePDFpath = "";
  Sizes sizes = Sizes.instance;

  @override
  void initState() {
    listOfItems = DataInfo().data;
    for (int index = 0; index < listOfItems.length; index++) {
      if (listOfItems[index]['type'] == 'file') {
        createFileOfPdfUrl(index).then((f) {
          debugPrint("=== $index remotePDFPath ${f.path}");
          listOfItems[index]['internal'] = f.path;
        });
      }
    }
    super.initState();
  }

  void create(int index, BuildContext context) {
    createFileOfPdfUrl(index).then((f) {
      remotePDFpath = f.path;
      debugPrint("=== remotePDFPath $remotePDFpath");
      if (mounted) {
        Navigator.push(
            mounted ? context : context,
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
                  return PDFScreen(path: remotePDFpath, index: index);
                }));
      }
    });
  }

  Future<File> createFileOfPdfUrl(int index) async {
    Completer<File> completer = Completer();
    try {
      final url = DataInfo().data[index]['file'];
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      //    debugPrint("=== Download files");
      //  debugPrint("=== ${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants().colorBackground,
      body: Center(child: Builder(
        builder: (BuildContext context) {
          return Column(
            children: [
              separator(),
              Expanded(
                  child: Scrollbar(
                thumbVisibility: true,
                child: ListView.builder(
                    itemCount: listOfItems.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Column(
                        children: [
                          if (listOfItems[index]['type'] == 'header')
                            separator(),
                          GestureDetector(
                            onTap: () {
                              //        create(index, context);
                              if (listOfItems[index]['type'] == 'image') {
                                Navigator.push(
                                    mounted
                                        ? context
                                        : context, /////////////////
                                    PageRouteBuilder(
                                        transitionDuration:
                                            const Duration(milliseconds: 100),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          return FadeTransition(
                                            opacity: animation,
                                            child: child,
                                          );
                                        },
                                        pageBuilder: (context, animation,
                                            secondaryAnimation) {
                                          return InfoImage(index: index);
                                        }));
                              }
                              if (listOfItems[index]['type'] == 'file') {
                                Navigator.push(
                                    mounted
                                        ? context
                                        : context, /////////////////
                                    PageRouteBuilder(
                                        transitionDuration:
                                            const Duration(milliseconds: 100),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          return FadeTransition(
                                            opacity: animation,
                                            child: child,
                                          );
                                        },
                                        pageBuilder: (context, animation,
                                            secondaryAnimation) {
                                          return PDFScreen(
                                              path: listOfItems[index]
                                                  ['internal'],
                                              index: index);
                                        }));
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left:
                                          listOfItems[index]['type'] == 'header'
                                              ? 0.05 * sizes.screenWidth
                                              : 0.1 * sizes.screenWidth),
                                  child: Text(
                                    listOfItems[index]['title'],
                                    style: TextStyle(
                                        color: listOfItems[index]['type'] ==
                                                'header'
                                            ? Constants().colorAetosBlue
                                            : Constants().colorAetosAmber,
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
              ))
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
}
