import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import 'constants.dart';
import 'data_info.dart';

class PDFScreen extends StatefulWidget {
  final String path;
  final int index;

  const PDFScreen({super.key, required this.path, required this.index});

  @override
  State<PDFScreen> createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  void initState() {
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
        /*
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.share,
              color: Constants().colorAetosAmber,
            ),
            onPressed: () {},
          ),
        ],*/
      ),
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: false,
            pageFling: true,
            pageSnap: true,
            defaultPage: currentPage!,
            fitPolicy: FitPolicy.BOTH,
            preventLinkNavigation:
                false, // if set to true the link is handled in flutter
            backgroundColor: Color(0xFFFEF7FF),
            onRender: (pagesRender) {
              setState(() {
                pages = pagesRender;
                isReady = true;
              });
            },
            onError: (error) {
              setState(() {
                errorMessage = error.toString();
              });
              debugPrint("=== ${error.toString()}");
            },
            onPageError: (page, error) {
              setState(() {
                errorMessage = '$page: ${error.toString()}';
              });
              debugPrint('=== $page: ${error.toString()}');
            },
            onViewCreated: (PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },
            onLinkHandler: (String? uri) {
              debugPrint('=== goto uri: $uri');
            },
            onPageChanged: (int? page, int? total) {
              debugPrint('=== page change: ${page ?? 0 + 1}/$total');
              setState(() {
                currentPage = page;
              });
            },
          ),
          errorMessage.isEmpty
              ? !isReady
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()
              : Center(
                  child: Text(errorMessage),
                )
        ],
      ),
    );
  }
}
