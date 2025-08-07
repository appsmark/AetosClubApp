import 'package:flutter/material.dart';
import 'package:flutter_document_viewer/flutter_document_viewer.dart';

import 'constants.dart';
import 'data_info.dart';
import 'sizes.dart';

class InfoDoc extends StatefulWidget {
  const InfoDoc({
    super.key,
    required this.file,
    required this.index,
  });

  final String file;
  final int index;

  @override
  State<InfoDoc> createState() => _InfoDocState();
}

class _InfoDocState extends State<InfoDoc> {
  DataInfo dataInfo = DataInfo.instance;
  Sizes sizes = Sizes.instance;
  final String pptxUrl =
      //     'https://www.unm.edu/~unmvclib/powerpoint/pptexamples.ppt';
      //'http://www.apps-mark.nl/aetos/Puntensysteem/Aetos puntensysteem opzet _v3_.docx';
      //'http://www.apps-mark.nl/aetos/Commissies/Jeugcommissie  info.docx';
      // 'http://www.apps-mark.nl/aetos/T-F-Z dienst/DWF-wedstrijdformulier-A5-nieuw _2_.pdf';
      'http://www.apps-mark.nl/aetos/VolleyStars/Volley-Stars-Achtergronden-en-spelregels.pdf';
  // Controller for the document viewer
  late final FlutterDocumentViewerController _controller;

  @override
  initState() {
    _controller = FlutterDocumentViewerController(
      onReady: () {
        //      ScaffoldMessenger.of(context).showSnackBar(
        //      const SnackBar(content: Text('Document viewer is ready')),
        //  );
      },
      onPageChanged: (currentPage, totalPages) {
        debugPrint('Page changed to $currentPage of $totalPages');
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants().colorBackground,
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
      body: Expanded(
        child: FlutterDocumentViewer(
          url: dataInfo.data[widget.index]['file'],
          controller: _controller,
          showControls: false,
          onPageChanged: (currentPage, totalPages) {
            debugPrint(
                '=== Page changed callback: $currentPage of $totalPages');
          },
        ),
      ),
    );
  }
}
