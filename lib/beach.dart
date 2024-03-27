import 'package:flutter/material.dart';

import 'beach_data.dart';
import 'sizes.dart';

class Beach extends StatefulWidget {
  const Beach({super.key});

  @override
  State<Beach> createState() => _BeachState();
}

class _BeachState extends State<Beach> {
  BeachData beachData = BeachData.instance;
  List listOfItems = [];
  Sizes sizes = Sizes.instance;

  @override
  initState() {
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
            "RESERVERINGEN",
            style: TextStyle(
                color: sizes.colorTitle,
                fontSize: sizes.sizeFontTitle,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            separator(),
            Expanded(
                child: ListView.builder(
                    itemCount: listOfItems.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                listOfItems[index]['date'],
                                style: TextStyle(
                                    color: sizes.colorBeach,
                                    fontSize: sizes.sizeFontBeach,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                listOfItems[index]['time'],
                                style: TextStyle(
                                    color: sizes.colorBeach,
                                    fontSize: sizes.sizeFontBeach,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Text(
                            listOfItems[index]['game'],
                            style: TextStyle(
                                color: sizes.colorBeach,
                                fontSize: sizes.sizeFontBeach,
                                fontWeight: FontWeight.bold),
                          ),
                          separator(),
                        ],
                      );
                    }))
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
}
