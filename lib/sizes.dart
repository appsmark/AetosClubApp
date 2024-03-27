import 'package:flutter/material.dart';

class Sizes {
  static final instance = Sizes._internal();
  double buttonBorderWidth = 0;
  double buttonHeight = 0;
  double buttonWidth = 0;
  double screenHeight = 0;
  double screenWidth = 0;
  double sizeFontBeach = 0;
  double sizeFontButton = 0;
  double sizeFontCompetition = 0;
  double sizeFontLogin = 0;
  double sizeFontRanking = 0;
  double sizeFontResults = 0;
  double sizeFontSchedule = 0;
  double sizeFontSelection = 0;
  double sizeFontTitle = 0;
  double spacing = 0;
  double heightToolbar = 0;

  Color colorBackground = const Color(0xFF731816);
  Color colorBeach = const Color(0xFF00AADE);
  Color colorButton = const Color(0xFFF9B234);
  Color colorTitle = const Color(0xFF00AADE);
  Color colorCompetition = const Color(0xFFF9B234);
  Color colorRanking = const Color(0xFFF9B234);
  Color colorResults = const Color(0xFFF9B234);
  Color colorSchedule = const Color(0xFFF9B234);
  Color colorSelection = const Color(0xFFF9B234);

  Sizes._internal();

  setSizes(context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    heightToolbar = 0.1 * screenHeight;
    buttonBorderWidth = 0.005 * screenHeight;
    buttonHeight = 0.1 * screenHeight;
    buttonWidth = 0.8 * screenWidth;
    sizeFontBeach = 0.045 * screenHeight;
    sizeFontButton = 0.045 * screenHeight;
    sizeFontCompetition = 0.035 * screenHeight;
    sizeFontLogin = 0.054 * screenWidth;
    sizeFontRanking = 0.054 * screenWidth;
    sizeFontResults = 0.028 * screenHeight;
    sizeFontSchedule = 0.03 * screenHeight;
    sizeFontSelection = 0.03 * screenHeight;
    sizeFontTitle = 0.045 * screenHeight;
    spacing = 0.1 * screenHeight;
    /*
    colorButton = const Color(0xFFF9B234);
    colorCompetition = const Color(0xFFF9B234);
    colorResults = const Color(0xFF731816);
    colorSchedule = const Color(0xFF731816);
    colorTitle = const Color(0xFF731816);
    colorBackground = const Color(0xFF00AADE);
    */
  }
}
