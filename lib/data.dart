import 'package:flutter/material.dart';

class Data {
  static final Data _data = Data._internal();
  final List _teams = [];
  var currentTeam = "H6";
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

final data = Data(); // NEW

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
