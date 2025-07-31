import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'data_info.dart';
import 'pdfscreen.dart';

class PDFviewing extends StatefulWidget {
  const PDFviewing({super.key});

  @override
  State<PDFviewing> createState() => _PDFviewingState();
}

class _PDFviewingState extends State<PDFviewing> {
  String pathPDF = "";
  String remotePDFpath = "";

  @override
  void initState() {
    super.initState();

    createFileOfPdfUrl().then((f) {
      setState(() {
        remotePDFpath = f.path;
      });
    });
  }

  Future<File> createFileOfPdfUrl() async {
    Completer<File> completer = Completer();
    try {
      final url = DataInfo().data[1][1];
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
    return MaterialApp(
      title: 'Flutter PDF View',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("INFO PAGINA'S")),
        body: Center(child: Builder(
          builder: (BuildContext context) {
            return Column(
              children: <Widget>[
                pageItem(0, context),
                pageItem(1, context),
                pageItem(2, context),
              ],
            );
          },
        )),
      ),
    );
  }

  TextButton pageItem(int index, BuildContext context) {
    return TextButton(
      child: Text(DataInfo().data[index][0]),
      onPressed: () {
        if (remotePDFpath.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PDFScreen(path: DataInfo().data[index][2]),
//              builder: (context) => PDFScreen(path: remotePDFpath),
            ),
          );
        }
      },
    );
  }
}
