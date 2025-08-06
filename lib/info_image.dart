import 'package:aetos/data_info.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'sizes.dart';

class InfoImage extends StatefulWidget {
  const InfoImage({super.key, required this.index});
  final int index;
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
          dataInfo.data[widget.index]['title'],
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
      body: InteractiveViewer(
          child: Image.network(
        dataInfo.data[widget.index]['file'],
      )),
    );
  }
}
