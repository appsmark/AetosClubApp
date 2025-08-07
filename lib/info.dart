import 'package:aetos/info_doc.dart';
import 'package:aetos/info_image.dart';
//import 'package:aetos/pdfscreen.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'data_info.dart';
import 'info_pdf.dart';
import 'sizes.dart';

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  DataInfo dataInfo = DataInfo.instance;
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
                thumbVisibility: true,
                child: ListView.builder(
                    itemCount: dataInfo.data.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Column(
                        children: [
                          if (dataInfo.data[index]['type'] == 'header')
                            separator(),
                          GestureDetector(
                            onTap: () {
                              if (dataInfo.data[index]['type'] == 'image') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InfoImage(
                                            title: dataInfo.data[index]
                                                ['title'],
                                            file: dataInfo.data[index]['file'],
                                          )),
                                );
                              }
                              if (dataInfo.data[index]['type'] == 'file') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewPDFFromUrl(
                                            url: dataInfo.data[index]['file'],
                                            title: dataInfo.data[index]
                                                ['title'],
                                          )),
                                );
                              }
                              if (dataInfo.data[index]['type'] == 'doc') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InfoDoc(
                                          file: dataInfo.data[index]['file'],
                                          index: index)),
                                );
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: dataInfo.data[index]['type'] ==
                                              'header'
                                          ? 0.05 * sizes.screenWidth
                                          : 0.1 * sizes.screenWidth),
                                  child: Text(
                                    dataInfo.data[index]['title'],
                                    style: TextStyle(
                                        color: dataInfo.data[index]['type'] ==
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
                          //                 separator(),
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
}
