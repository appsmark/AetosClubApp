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
          DataInfo().data[widget.index]['title'],
          style: TextStyle(color: Constants().colorAetosAmber),
        ),
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            color: Constants().colorAetosAmber,
          ),
          onTap: () {
            Navigator.pop(context);
            /*
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
                      return Info();
                    }));*/
          },
        ),
      ),
      body: Center(
        child: InteractiveViewer(
            child: Image.network(DataInfo().data[widget.index]['file'])),
      ),
    );
  }
}
