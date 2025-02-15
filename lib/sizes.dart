import 'package:flutter/material.dart';

class Sizes {
  static final instance = Sizes._internal();
  double buttonBorderWidth = 0;
  double buttonHeight = 0;
  double buttonPadding = 0;
  double buttonWidth = 0;
  double screenHeight = 0;
  double screenWidth = 0;
  double sizeFontButton = 0;
  double sizeFontCompetition = 0;
  double sizeFontRanking = 0;
  double sizeFontResults = 0;
  double sizeFontSchedule = 0;
  double sizeFontSelection = 0;
  double sizeFontSelectTeamButton = 0;
  double sizeFontTitle = 0;
  double spacing = 0;
  double spacingButtons = 0;
  double heightToolbar = 0;
  bool tablet = false;

  Color colorBackground = const Color(0xFF731816);
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
    tablet = MediaQuery.of(context).size.shortestSide > 550;

    buttonBorderWidth = 0.005 * screenHeight;
    buttonHeight = 0.1 * screenHeight;
    buttonPadding = 0.01 * screenHeight;
    buttonWidth = 0.8 * screenWidth;
    sizeFontButton = 0.045 * screenHeight;
    sizeFontSelectTeamButton = 0.025 * screenHeight;
    sizeFontCompetition = 0.032 * screenHeight;
    if (tablet) {
      heightToolbar = 0.15 * screenHeight;
      sizeFontRanking = 0.04 * screenWidth;
    } else {
      heightToolbar = 0.1 * screenHeight;
      sizeFontRanking = 0.05 * screenWidth;
    }
    sizeFontResults = 0.025 * screenHeight;
    sizeFontSchedule = 0.025 * screenHeight;
    sizeFontSelection = 0.03 * screenHeight;
    sizeFontTitle = 0.045 * screenHeight;
    spacing = 0.1 * screenHeight;
    spacingButtons = 0.02 * screenHeight;
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
