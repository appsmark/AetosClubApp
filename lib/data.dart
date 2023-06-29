import 'package:flutter/material.dart';

class Data {
  static final Data _data = Data._internal();
  final List _teams = [];

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
}

class TeamData {
  String name;
  int points;

  TeamData(this.name, this.points);

  @override
  String toString() {
    name = name.replaceAll("Vallei Accountants ", "");
    return '{ $name, $points }';
  }
}
