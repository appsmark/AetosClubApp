import 'package:flutter/material.dart';

import 'sizes.dart';

class Manual extends StatefulWidget {
  const Manual({super.key});

  @override
  State<Manual> createState() => _ManualState();
}

class _ManualState extends State<Manual> {
  Sizes sizes = Sizes.instance;

  @override
  void initState() {
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
          "OPBERGEN",
          style: TextStyle(
              color: sizes.colorTitle,
              fontSize: sizes.sizeFontTitle,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
          itemCount: 8,
          itemBuilder: (BuildContext ctxt, int index) {
            return Column(
              children: [
                Image.asset('assets/images/Opslag$index.jpg'),
                separator(),
              ],
            );
          }),
    );
  }

  Divider separator() {
    return Divider(
      indent: 0.05 * sizes.screenWidth,
      endIndent: 0.05 * sizes.screenWidth,
      color: sizes.colorTitle,
    );
  }
}
