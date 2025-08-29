import 'package:flutter/material.dart';

import 'constants.dart';
import 'data_info.dart';
import 'info_image.dart';
import 'info_pdf.dart';
import 'persistent.dart';
import 'sizes.dart';

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  DataInfo dataInfo = DataInfo.instance;
  Persistent persistent = Persistent.instance;
  String remotePDFpath = "";
  Sizes sizes = Sizes.instance;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToIndex(persistent.infoListIndex);
    });
  }

  void scrollToIndex(int index) {
    scrollController.animateTo(
      sizes.infoItemHeight * index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
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
                controller: scrollController,
                interactive: true,
                thumbVisibility: true,
                child: ListView.builder(
                    controller: scrollController,
                    itemCount: dataInfo.data.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return SizedBox(
                        height: sizes.infoItemHeight,
                        child: Column(
                          children: [
                            if (dataInfo.data[index]['type'] == 'header')
                              separator(),
                            GestureDetector(
                              onTap: () {
                                persistent.setInfoListIndex(index - 5);
                                if (dataInfo.data[index]['type'] == 'image') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => InfoImage(
                                              title: dataInfo.data[index]
                                                  ['title'],
                                              file: dataInfo.data[index]
                                                  ['file'],
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
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  if (dataInfo.data[index]['type'] == 'header')
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 0.1 * sizes.screenWidth),
                                      child: Text(
                                        dataInfo.data[index]['title'],
                                        style: TextStyle(
                                            color: Constants().colorAetosBlue,
                                            fontSize: sizes.sizeFontSchedule,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  if ((dataInfo.data[index]['type'] ==
                                          'file') ||
                                      (dataInfo.data[index]['type'] == 'image'))
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 0.15 * sizes.screenWidth),
                                      child: Text(
                                        dataInfo.data[index]['title'],
                                        style: TextStyle(
                                            color: Constants().colorAetosAmber,
                                            fontSize: sizes.sizeFontSchedule,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            if (dataInfo.data[index]['type'] == 'header')
                              separator(),
                          ],
                        ),
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
      height: 1,
      color: Constants().colorTitle,
    );
  }
}
