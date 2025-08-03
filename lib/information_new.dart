import 'dart:async';
import 'dart:io';

import 'package:aetos/pdfscreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'constants.dart';
import 'data_info.dart';
import 'sizes.dart';

class InformationNew extends StatefulWidget {
  const InformationNew({super.key});

  @override
  State<InformationNew> createState() => _InformationNewState();
}

class _InformationNewState extends State<InformationNew> {
  List listOfItems = [
    {'type': '', 'title': '', 'file': ''}
  ];
  String remotePDFpath = "";
  Sizes sizes = Sizes.instance;

  @override
  void initState() {
    listOfItems = DataInfo().data;
    //  create(0);
    super.initState();
  }

  void create(int index, BuildContext context) {
    createFileOfPdfUrl(index).then((f) {
      //     setState(() {
      remotePDFpath = f.path;
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
    // });
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
      debugPrint("=== Download files");
      debugPrint("=== ${dir.path}/$filename");
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
      //      appBar: AppBar(title: const Text("INFO PAGINA'S")),
      body: Center(child: Builder(
        builder: (BuildContext context) {
          return Column(
            children: [
              separator(),
              Expanded(
                  child: ListView.builder(
                      itemCount: listOfItems.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                create(index, context);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    listOfItems[index]['title'],
                                    style: TextStyle(
                                        color: Constants().colorSchedule,
                                        fontSize: sizes.sizeFontSchedule,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                            separator(),
                          ],
                        );
                      }))
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
