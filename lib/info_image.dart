import 'package:aetos/data_info.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'sizes.dart';

class InfoImage extends StatefulWidget {
  const InfoImage({super.key, required this.file, required this.title});
  final String file;
  final String title;

  @override
  State<InfoImage> createState() => _InfoImageState();
}

class _InfoImageState extends State<InfoImage> {
  DataInfo dataInfo = DataInfo.instance;
  Sizes sizes = Sizes.instance;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants().colorBackground,
        title: Text(
          widget.title,
          style: TextStyle(color: Constants().colorAetosAmber),
        ),
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            color: Constants().colorAetosBlue,
            size: 0.04 * sizes.screenHeight,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Constants().colorAetosAmber,
        child: Center(
          child: InteractiveViewer(
            child: Image.network(
              widget.file,
            ),
          ),
        ),
      ),
    );
  }
}
