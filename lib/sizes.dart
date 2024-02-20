import 'package:flutter/material.dart';

class Sizes {
  static final instance = Sizes._internal();
  double screenHeight = 0;
  double screenWidth = 0;
  double sizeFontButton = 0;
  double sizeFontCompetition = 0;
  double sizeFontRanking = 0;
  double sizeFontSchedule = 0;
  double sizeFontSelection = 0;
  double sizeFontTitle = 0;
  double spacing = 0;

  Color colorBackground = const Color(0xFF731816);
  Color colorButton = const Color(0xFFF9B234);
  Color colorTitle = const Color(0xFF00AADE);
  Color colorCompetition = const Color(0xFFF9B234);
  Color colorRanking = const Color(0xFFF9B234);
  Color colorSchedule = const Color(0xFFF9B234);
  Color colorSelection = const Color(0xFFF9B234);

  Sizes._internal();

  setSizes(context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    sizeFontButton = 0.045 * screenHeight;
    sizeFontCompetition = 0.03 * screenHeight;
    sizeFontRanking = 0.025 * screenHeight;
    sizeFontSchedule = 0.03 * screenHeight;
    sizeFontSelection = 0.03 * screenHeight;
    sizeFontTitle = 0.04 * screenHeight;
    spacing = 0.1 * screenHeight;
    /*
    colorButton = const Color(0xFFF9B234);
    colorCompetition = const Color(0xFFF9B234);
    colorSchedule = const Color(0xFF731816);
    colorTitle = const Color(0xFF731816);
    colorBackground = const Color(0xFF00AADE);
    */
  }
}
