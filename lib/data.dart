import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeamInfo {
  List teamsInfo = [
    ["D1", "regio-oost/DPC", "dames/1"],
    ["D2", "regio-oost/D1L", "dames/2"],
    ["D3", "regio-oost/D1L", "dames/3"],
    ["D4", "regio-oost/D1M", "dames/4"],
    ["D5", "regio-oost/D1M", "dames/5"],
    ["D6", "regio-oost/D2I", "dames/6"],
    ["D7", "regio-oost/D2N", "dames/7"],
    ["D8", "regio-oost/D3J", "dames/8"],
    ["D9", "regio-oost/D3M", "dames/9"],
    ["D10", "regio-oost/D3M", "dames/10"],
    ["D11", "regio-oost/D4F", "dames/11"],
    ["H1", "nationale-competitie/2BH", "heren/1"],
    ["H2", "regio-oost/HPD", "heren/2"],
    ["H3", "regio-oost/HPD", "heren/3"],
    ["H4", "regio-oost/H1G", "heren/4"],
    ["H5", "regio-oost/H1H", "heren/5"],
    ["H6", "regio-oost/H2G", "heren/6"],
    ["H7", "regio-oost/H2J", "heren/7"],
    ["H8", "regio-oost/H3E", "heren/8"],
    ["H9", "regio-oost/H3F", "heren/9"],
    ["JA1", "regio-oost/JAHA1", "jongens-a/1"],
    ["JA2", "regio-oost/JA1C1", "jongens-a/2"],
    ["JB1", "regio-oost/JBHA1", "jongens-b/1"],
    ["JB2", "regio-oost/JB2D1", "jongens-b/2"],
    ["JC1", "regio-oost/JCHB1", "jongens-c/1"],
    ["JC2", "regio-oost/JC2C1", "jongens-c/2"],
    ["JC3", "regio-oost/JC2C1", "jongens-c/3"],
    ["MA1", "regio-oost/MA1H1", "meisjes-a/1"],
    ["MA2", "regio-oost/MA1G1", "meisjes-a/2"],
    ["MA3", "regio-oost/MA1G1", "meisjes-a/3"],
    ["MA4", "regio-oost/MA1H1", "meisjes-a/4"],
    ["MA5", "regio-oost/MA3D1", "meisjes-a/5"],
    ["MB1", "regio-oost/MBHC1", "meisjes-b/1"],
    ["MB2", "regio-oost/MB1H1", "meisjes-b/2"],
    ["MB3", "regio-oost/MB2K1", "meisjes-b/3"],
    ["MB4", "regio-oost/MB3I1", "meisjes-b/4"],
    ["MB5", "regio-oost/MB3I1", "meisjes-b/5"],
    ["MC1", "regio-oost/MC1E1", "meisjes-c/1"],
    ["MC2", "regio-oost/MC1E1", "meisjes-c/2"],
    ["MC3", "regio-oost/MC2K1", "meisjes-c/3"],
    ["MC4", "regio-oost/MC2K1", "meisjes-c/4"],
    ["MC5", "regio-oost/MC3N1", "meisjes-c/5"],
    ["MC6", "regio-oost/MC3M1", "meisjes-c/6"],
    ["MC7", "regio-oost/MC3M1", "meisjes-c/7"],
  ];

  String getRanking(team) {
    debugPrint("getRanking for $team");
    String competition =
        "https://api.nevobo.nl/export/poule/${teamsInfo[1][1]}/stand.rss";
    for (var index = 0; index < teamsInfo.length; index++) {
      if (team == teamsInfo[index][0]) {
        competition =
            "https://api.nevobo.nl/export/poule/${teamsInfo[index][1]}/stand.rss";
        debugPrint("poule ${teamsInfo[index][0]}  $competition");
      }
    }

    return competition;
  }
}

class Team with ChangeNotifier {
  static final Team _team = Team._internal();
  String currentTeam = "H9";

  factory Team() {
    debugPrint("INITIALIZING");
    return _team;
  }

  Team._internal();

  void clear() {
    currentTeam = "";
  }

  Future<void> getStoredTeam() async {
    final prefs = await SharedPreferences.getInstance();
    currentTeam = (prefs.getString('team') ?? "H9");
    set(currentTeam);
    debugPrint("Get stored $currentTeam");
  }

/*
  getStoredTeam() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentTeam = (prefs.getString('team') ?? "H9");
    set(currentTeam);
    debugPrint("Get stored $currentTeam");
  }
*/
  setStoredTeam(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('team', value);
  }

  void set(newValue) {
    currentTeam = newValue;
//    notifyListeners();
    setStoredTeam(currentTeam);
  }

  String get() {
    debugPrint("request '$currentTeam'");
    getStoredTeam();
    return currentTeam;
  }
}

final team = Team();

class Data with ChangeNotifier {
  static final Data _data = Data._internal();
  final List _teams = [];

  factory Data() {
    debugPrint("INIT DATA");
    return _data;
  }

  Data._internal();

  void clear() {
    _teams.clear();
  }

  void addTeam(name, points) {
    _teams.add(TeamData(name, points));
    if (_teams.length > 10) {
      debugPrint("${_teams[0]} ${_teams[1]} ${_teams[10]}");
    }
  }

  List getTeams() {
    notifyListeners();
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
    name = name.replaceAll("Volleybalvereniging ", "");
    name = name.replaceAll("/HEC", "");
    name = name.replaceAll("Vallei Accountants ", "");
    name = name.replaceAll(" VC", "");
    name = name.replaceAll("SV ", "");
    name = name.replaceAll("Rabobank Orion Volleybal Doetinchem ", "Orion ");
    name = name.replaceAll(" Apeldoorn", "");
    name = name.replaceAll("Rebo Woningmakelaars ", "");
    name = name.replaceAll("Rensa Family ", "");
    name = name.replaceAll("Weghorst Makelaardij ", "");
    name = name.replaceAll("Jumbo Van Andel-", "");
    name = name.replaceAll("ROOT ", "");
    name = name.replaceAll("Sportclub W", "W");
    name = name.replaceAll("'Topklimaat in Volleybal'", "");
    name = name.replaceAll("HevaV", "Heva VCV");
    name = name.replaceAll("Steenderen ", "");
    name = name.replaceAll("Dros-", "");
    name = name.replaceAll("Bultman-Hartholt ", "");

    return name;
  }
}
