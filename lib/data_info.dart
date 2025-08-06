import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class DataInfo {
  static final instance = DataInfo._internal();

  DataInfo._internal();

  void getInfo() {
    for (int index = 0; index < data.length; index++) {
      if (data[index]['type'] == 'file') {
        createFileOfPdfUrl(index).then((f) {
          debugPrint("=== $index remotePDFPath ${f.path}");
          data[index]['internal'] = f.path;
        });
      }
    }
  }

  Future<File> createFileOfPdfUrl(int index) async {
    Completer<File> completer = Completer();
    try {
      final url = data[index]['file'];
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      //    debugPrint("=== Download files");
      //  debugPrint("=== ${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  List data = [
    {
      'type': 'header',
      'title': 'Zaaldienst',
    },
    {
      'type': 'file',
      'title': 'Opruimen Middachtensingel',
      'file': 'http://www.apps-mark.nl/aetos/Opruimen Middachtensingel.pdf',
      'internal': '',
    },
    {
      'type': 'header',
      'title': 'Volley Stars (6-12 jaar)',
    },
    {
      'type': 'file',
      'title': 'Volley Stars bij Aetos',
      'file':
          'http://www.apps-mark.nl/aetos/VolleyStars/Volley_Stars Aetos.pdf',
      'internal': '',
    },
    {
      'type': 'file',
      'title': 'Spelregels',
      'file':
          'http://www.apps-mark.nl/aetos/VolleyStars/Volley-Stars-Achtergronden-en-spelregels.pdf',
      'internal': '',
    },
    {
      'type': 'image',
      'title': 'Shirt',
      'file': 'http://www.apps-mark.nl/aetos/VolleyStars/Shirts.jpg',
      'internal': '',
    },
    {
      'type': 'file',
      'title': 'Informatie ouders',
      'file':
          'http://www.apps-mark.nl/aetos/VolleyStars/Informatiedocument.pdf',
      'internal': '',
    },
    {
      'type': 'image',
      'title': 'Contactouder',
      'file': 'http://www.apps-mark.nl/aetos/VolleyStars/Contactouder.png',
      'internal': '',
    },
    {
      'type': 'header',
      'title': 'Coach',
    },
    {
      'type': 'file',
      'title': 'Coaching tips',
      'file': 'http://www.apps-mark.nl/aetos/Coach/Coaching tips Aetos.pdf',
      'internal': '',
    },
    {
      'type': 'file',
      'title': 'Samenwerking tips',
      'file': 'http://www.apps-mark.nl/aetos/Coach/Samenwerking tips Aetos.pdf',
      'internal': '',
    },
    {
      'type': 'file',
      'title': 'Wedstrijd warming-up',
      'file': 'http://www.apps-mark.nl/aetos/Coach/Wedstrijdwarming-up.pdf',
      'internal': '',
    },
    {
      'type': 'header',
      'title': 'Trainer',
    },
    {
      'type': 'file',
      'title': 'Trainersondersteuning',
      'file':
          'http://www.apps-mark.nl/aetos/Trainer/Aetos Trainersondersteuning.pdf',
      'internal': '',
    },
    {
      'type': 'file',
      'title': 'Communicatie met ouders',
      'file':
          'http://www.apps-mark.nl/aetos/Trainer/Communicatie met ouders.pdf',
      'internal': '',
    },
    {
      'type': 'file',
      'title': 'Samenwerking tips',
      'file':
          'http://www.apps-mark.nl/aetos/Trainer/Samenwerking tips Aetos.pdf',
      'internal': '',
    },
    {
      'type': 'file',
      'title': 'Spelvormen',
      'file': 'http://www.apps-mark.nl/aetos/Trainer/Spelvormen Aetos.pdf',
      'internal': '',
    },
    {
      'type': 'file',
      'title': 'Tips voor de pass',
      'file':
          'http://www.apps-mark.nl/aetos/Trainer/Tips voor de pass bij beginners.pdf',
      'internal': '',
    },
    {
      'type': 'file',
      'title': 'Training tips',
      'file': 'http://www.apps-mark.nl/aetos/Trainer/Training tips Aetos.pdf',
      'internal': '',
    },
    {
      'type': 'file',
      'title': 'Wedstrijdwarming-up',
      'file': 'http://www.apps-mark.nl/aetos/Trainer/Wedstrijdwarming-up.pdf',
      'internal': '',
    },
    {
      'type': 'header',
      'title': 'Scheidsrechter en Teller',
    },
    {
      'type': 'file',
      'title': 'DWF-wedstrijdformulier',
      'file':
          'http://www.apps-mark.nl/aetos/T-F-Z dienst/DWF-wedstrijdformulier-A5-nieuw _2_.pdf',
      'internal': '',
    },
    {
      'type': 'image',
      'title': 'Taakverdeling',
      'file':
          'http://www.apps-mark.nl/aetos/T-F-Z dienst/Taak scheids teller.jpg',
      'internal': '',
    },
    {
      'type': 'header',
      'title': 'Puntensysteem',
    },
    {
      'type': 'header',
      'title': 'Kalender',
    },
    {
      'type': 'image',
      'title': 'Jeugd 2025-2026',
      'file': 'http://www.apps-mark.nl/aetos/Kalender/Jeugd 25-26.png',
      'internal': '',
    },
    {
      'type': 'image',
      'title': 'Volley Stars 2025-2026',
      'file': 'http://www.apps-mark.nl/aetos/Kalender/Volley stars 25-26.png',
      'internal': '',
    },
    {
      'type': 'header',
      'title': 'Jeugd (12-18 jaar)',
    },
    {
      'type': 'image',
      'title': 'Contactouder Jeugd',
      'file':
          'http://www.apps-mark.nl/aetos/Jeugd (12-18 jaar)/Contactouder Jeugd _3_.png',
      'internal': '',
    },
    {
      'type': 'file',
      'title': 'Informatie ouders en leden',
      'file':
          'http://www.apps-mark.nl/aetos/Jeugd (12-18 jaar)/Informatiedocument ouders en leden seizoen 2025-2026.pdf',
      'internal': '',
    },
    {
      'type': 'file',
      'title': 'Youth competition',
      'file':
          'http://www.apps-mark.nl/aetos/Jeugd (12-18 jaar)/Jeugdcompetitie ENG.pdf',
      'internal': '',
    },
    {
      'type': 'file',
      'title': 'Jeugdcompetitie',
      'file':
          'http://www.apps-mark.nl/aetos/Jeugd (12-18 jaar)/Jeugdcompetitie NL.pdf',
      'internal': '',
    },
    {
      'type': 'file',
      'title': 'Teamindelingen',
      'file':
          'http://www.apps-mark.nl/aetos/Jeugd (12-18 jaar)/Teamindelingen.pdf',
      'internal': '',
    },
    {
      'type': 'header',
      'title': 'Gedrag en vertrouwen',
    },
    {
      'type': 'file',
      'title': 'Infographic',
      'file':
          'http://www.apps-mark.nl/aetos/Gedrag en Vertrouwen/infographic Aetos.pdf',
      'internal': '',
    },
    {
      'type': 'header',
      'title': 'Contactpersonen',
    },
    {
      'type': 'header',
      'title': 'Commissies',
    },
    {
      'type': 'file',
      'title': 'A beach Info',
      'file': 'http://www.apps-mark.nl/aetos/Commissies/A beach Info.pdf',
      'internal': '',
    },
    {
      'type': 'file',
      'title': 'TC commissie',
      'file': 'http://www.apps-mark.nl/aetos/Commissies/TC commissie info.pdf',
      'internal': '',
    },
    {
      'type': 'file',
      'title': 'Welzijn commissie',
      'file': 'http://www.apps-mark.nl/aetos/Commissies/Welzijn commissie.pdf',
      'internal': '',
    },
  ];
}
