import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'flutter_html Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

const htmlData = r"""
<font color="#F9B234">


Abeach start vrij spelen<br>
7 april
<hr style="border: 1px solid #00AADE">
<h1>Abeach start trainingen<br>
7 mei</h1>
<hr style="border: 1px solid #00AADE">
<h1>Abeach Openingstoernooi<br>
31 mei</h1>
<hr style="border: 1px solid #00AADE">
<h1>EINDFEEST 2024-2025<br>
21 juni 20:00 - 01:00</h1>
<hr style="border: 1px solid #00AADE">

</font>
""";

final staticAnchorKey = GlobalKey();

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('flutter_html Example'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_downward),
        onPressed: () {
          final anchorContext =
              AnchorKey.forId(staticAnchorKey, "bottom")?.currentContext;
          if (anchorContext != null) {
            Scrollable.ensureVisible(anchorContext);
          }
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topCenter,
          color: Colors.green,
          height: 400,
          child: Html(
            anchorKey: staticAnchorKey,
            data: htmlData,
            shrinkWrap: true,
          ),
        ),
      ),
    );
  }
}
