import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import 'constants.dart';
import 'sizes.dart';

class ViewPDFFromUrl extends StatelessWidget {
  ViewPDFFromUrl({super.key, required this.url, required this.title});
  final Sizes sizes = Sizes.instance;
  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants().colorBackground,
        title: Text(
          title,
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
        /*actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.share,
              color: Constants().colorAetosAmber,
            ),
          
            onPressed: () {
              SharePlus.instance.share(
                ShareParams(
                  text:
                      "Aetos document ${DataInfo().data[widget.index]['title']}",
                  subject:
                      'Aetos document ${DataInfo().data[widget.index]['title']}',
                  //    sharePositionOrigin:
                  //      box!.localToGlobal(Offset.zero) & box.size,
                ),
              );
            },
            
          ),
        ],*/
      ),
      body: PDF(
        backgroundColor: Constants().colorAetosAmber,
        swipeHorizontal: true,
        pageFling: true,
        pageSnap: true,
        fitEachPage: true,
        fitPolicy: FitPolicy.BOTH,
        onLinkHandler: (uri) {
          debugPrint("=== $uri");
        },
      ).fromUrl(
        url,
        //   placeholder: (double progress) => Center(child: Text('$progress %')),
        errorWidget: (dynamic error) => Center(
          child: Text(error.toString()),
        ),
      ),
    );
  }
}
