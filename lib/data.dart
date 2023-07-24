import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentTeam with ChangeNotifier {
  String value = "";

  void set(newValue) {
    value = newValue;
    notifyListeners();
  }

  String get() {
    return value;
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringValue = prefs.getString('team');
    return stringValue;
  }
}

class Data with ChangeNotifier {
  static final Data _data = Data._internal();
  final List _teams = [];
  final List _teamsInfo = [
    ["D1", "regio-oost/DPD", "dames/1"],
    ["D2", "regio-oost/D1M", "dames/2"],
    ["D3", "regio-oost/D1L", "dames/3"],
    ["D4", "regio-oost/D1M", "dames/4"],
    ["D5", "regio-oost/D1L", "dames/5"],
    ["D6", "regio-oost/D2N", "dames/6"],
    ["D7", "regio-oost/D3O", "dames/7"],
    ["D8", "regio-oost/D3P", "dames/8"],
    ["D9", "regio-oost/D3O", "dames/9"],
    ["D10", "regio-oost/D4I", "dames/10"],
    ["H1", "nationale-competitie/2BH", "heren/1"],
    ["H2", "regio-oost/HPD", "heren/2"],
    ["H3", "regio-oost/HPD", "heren/3"],
    ["H4", "regio-oost/H1G", "heren/4"],
    ["H5", "regio-oost/H1G", "heren/5"],
    ["H6", "regio-oost/H3E", "heren/6"],
    ["H7", "regio-oost/H3E", "heren/7"],
    ["JA1", "regio-oost/JATA2", "jongens-a/1"],
    ["JA2", "regio-oost/JAHA2", "jongens-a/2"],
    ["JB1", "regio-oost/JB1A2", "jongens-b/1"],
    ["JC1", "regio-oost/JCHB2", "jongens-c/1"],
    ["JC2", "regio-oost/JC1C2", "jongens-c/2"],
    ["JC3", "regio-oost/JC2B2", "jongens-c/3"],
    ["JC4", "regio-oost/JC2B2", "jongens-c/4"],
    ["MA1", "regio-oost/MA1F2", "meisjes-a/1"],
    ["MA2", "regio-oost/MA2G2", "meisjes-a/2"],
    ["MB1", "regio-oost/MBHD2", "meisjes-b/1"],
    ["MB2", "regio-oost/MB1G2", "meisjes-b/2"],
    ["MB3", "regio-oost/MB1H2", "meisjes-b/3"],
    ["MB4", "regio-oost/MB2J2", "meisjes-b/4"],
    ["MB5", "regio-oost/MB3F2", "meisjes-b/5"],
    ["MB6", "regio-oost/MB3F2", "meisjes-b/6"],
    ["MC1", "regio-oost/MC1F2", "meisjes-c/1"],
    ["MC2", "regio-oost/MC2K2", "meisjes-c/2"],
    ["MC3", "regio-oost/MC2J2", "meisjes-c/3"],
    ["MC4", "regio-oost/MC2J2", "meisjes-c/4"],
    ["MC5", "regio-oost/MC3J2", "meisjes-c/5"],
    ["MC6", "regio-oost/MC3J2", "meisjes-c/6"],
  ];

  List listOfTeams = [
    'D1',
    'D2',
    'D3',
    'D4',
    'D5',
    'D6',
    'D7',
    'D8',
    'D9',
    'D10',
    'H1',
    'H2',
    'H3',
    'H4',
    'H5',
    'H6',
    'H7',
    'H8',
    'H9',
  ];

  factory Data() {
    return _data;
  }

  Data._internal();

  void addTeam(name, points) {
    _teams.add(TeamData(name, points));
    if (_teams.length > 10) {
      debugPrint("${_teams[0]} ${_teams[1]} ${_teams[10]}");
    }
  }

  List getAllTeams() {
    return listOfTeams;
  }

  List getTeams() {
    return _teams;
  }
}

final data = Data();

class TeamData {
  String name;
  int points;

  TeamData(this.name, this.points);

  String pointsPro() {
    return points.toString();
  }

  String team() {
    name = name.replaceAll("Vallei Accountants ", "");
    return name;
  }
}
