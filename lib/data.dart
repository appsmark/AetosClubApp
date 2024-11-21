import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeamInfo {
  List teamsInfo = [
    ["D1", "regio-oost/DPE", "dames/1"],
    ["D2", "regio-oost/D1Q", "dames/2"],
    // ["D3", "regio-oost/D1H", "dames/3"],
    ["D4", "regio-oost/D1S", "dames/4"],
    ["D5", "regio-oost/D1Q", "dames/5"],
    ["D6", "regio-oost/D1R", "dames/6"],
    ["D7", "regio-oost/D2S", "dames/7"],
    ["D8", "regio-oost/D2R", "dames/8"],
    ["D9", "regio-oost/D3P", "dames/9"],
    ["D10", "regio-oost/D3Q", "dames/10"],
    ["D11", "regio-oost/D4D", "dames/11"],
    ["H1", "nationale-competitie/2BH", "heren/1"],
    ["H2", "regio-oost/HPD", "heren/2"],
    ["H3", "regio-oost/HPE", "heren/3"],
    ["H4", "regio-oost/H1H", "heren/4"],
    ["H5", "regio-oost/H1I", "heren/5"],
    ["H6", "regio-oost/H1H", "heren/6"],
    ["H7", "regio-oost/H1I", "heren/7"],
    ["H8", "regio-oost/H2H", "heren/8"],
    //   ["H9", "regio-oost/H2I", "heren/9"],
    ["H10", "regio-oost/H3F", "heren/10"],
    ["JA1", "regio-oost/JAHB1", "jongens-a/1"],
    ["JB1", "regio-oost/JB1F1", "jongens-b/1"],
    ["JB2", "regio-oost/JB1E1", "jongens-b/2"],
    ["JB3", "regio-oost/JB1E1", "jongens-b/3"],
    ["JC1", "regio-oost/JCHA1", "jongens-c/1"],
    ["JC2", "regio-oost/JC2B1", "jongens-c/2"],
    ["JC3", "regio-oost/XC4B1", "jongens-c/3"],
    ["MA1", "regio-oost/MAHB1", "meiden-a/1"],
    ["MA2", "regio-oost/MA1D1", "meiden-a/2"],
    ["MA3", "regio-oost/MA2I1", "meiden-a/3"],
    ["MA4", "regio-oost/MA3D1", "meiden-a/4"],
    ["MB1", "regio-oost/MB1G1", "meiden-b/1"],
    ["MB2", "regio-oost/MB1H1", "meiden-b/2"],
    ["MB3", "regio-oost/MB2H1", "meiden-b/3"],
    ["MB4", "regio-oost/MB2H1", "meiden-b/4"],
    //   ["MB5", "regio-oost/MB2G1", "meiden-b/5"],
    ["MB6", "regio-oost/MB3I1", "meiden-b/6"],
    ["MB7", "regio-oost/MB3F1", "meiden-b/7"],
    ["MB8", "regio-oost/MB3F1", "meiden-b/8"],
    ["MC1", "regio-oost/MC1E1", "meiden-c/1"],
    ["MC2", "regio-oost/MC2N1", "meiden-c/2"],
    ["MC3", "regio-oost/MC2M1", "meiden-c/3"],
    ["MC4", "regio-oost/MC2L1", "meiden-c/4"],
    ["MC5", "regio-oost/MC2M1", "meiden-c/5"],
    ["MC6", "regio-oost/XC4C1", "meiden-c/6"],
    ["MC7", "regio-oost/MC3M1", "meiden-c/7"],
    ["MC8", "regio-oost/MC3I1", "meiden-c/8"],
    [
      "N6-1",
      "regio-oost/eerste-helft-cmv-arnhem-wageningen-1/regio-oost-cn61a1-10",
      "cmv-niveau-6/1"
    ],
    [
      "N6-2",
      "regio-oost/eerste-helft-cmv-arnhem-wageningen-1/regio-oost-cn61b1-8",
      "cmv-niveau-6/2"
    ],
    [
      "N5-1",
      "regio-oost/eerste-helft-cmv-arnhem-wageningen-1/regio-oost-cn51a1-10",
      "cmv-niveau-5/1"
    ],
    [
      "N5-2",
      "regio-oost/eerste-helft-cmv-arnhem-wageningen-1/regio-oost-cn51a1-10",
      "cmv-niveau-5/2"
    ],
  ];

  bool availabe(String target) {
    bool result = false;
    for (int index = 0; index < teamsInfo.length; index++) {
      if (teamsInfo[index][0] == target) {
        result = true;
      }
    }
    return result;
  }

  String getRanking(team) {
    String competition =
        "https://api.nevobo.nl/export/poule/${teamsInfo[1][1]}/stand.rss";
    for (var index = 0; index < teamsInfo.length; index++) {
      if (team == teamsInfo[index][0]) {
        competition =
            "https://api.nevobo.nl/export/poule/${teamsInfo[index][1]}/stand.rss";
        //     debugPrint("poule ${teamsInfo[index][0]}  $competition");
      }
    }
    return competition;
  }

  String getSchedule(team) {
    //   debugPrint("getSchedule for $team");
    String competition =
        "https://api.nevobo.nl/export/team/CNH8Q1U/${teamsInfo[1][2]}/programma.rss";
    for (var index = 0; index < teamsInfo.length; index++) {
      if (team == teamsInfo[index][0]) {
        competition =
            "https://api.nevobo.nl/export/team/CNH8Q1U/${teamsInfo[index][2]}/programma.rss";
        //     debugPrint("poule ${teamsInfo[index][0]}  $competition");
      }
    }

    return competition;
  }

  String getResults(team) {
    String competition =
        "https://api.nevobo.nl/export/team/CNH8Q1U/${teamsInfo[1][2]}/resultaten.rss";
    for (var index = 0; index < teamsInfo.length; index++) {
      if (team == teamsInfo[index][0]) {
        competition =
            "https://api.nevobo.nl/export/team/CNH8Q1U/${teamsInfo[index][2]}/resultaten.rss";
        //     debugPrint("poule ${teamsInfo[index][0]}  $competition");
      }
    }

    return competition;
  }
}

class Team with ChangeNotifier {
  static final Team _team = Team._internal();
  String currentTeam = "D1";

  factory Team() {
    return _team;
  }

  Team._internal();

  void clear() {
    currentTeam = "";
  }

  Future<void> getStoredTeam() async {
    final prefs = await SharedPreferences.getInstance();
    currentTeam = (prefs.getString('team') ?? "D1");
    if (TeamInfo().availabe(currentTeam)) {
      set(currentTeam);
    } else {
      set("D1");
    }
    // debugPrint("Get stored $currentTeam");
  }

  setStoredTeam(value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('team', value);
  }

  void set(newValue) {
    currentTeam = newValue;
//    notifyListeners();
    setStoredTeam(currentTeam);
  }
}

final team = Team();

class Data with ChangeNotifier {
  static final Data _data = Data._internal();
  final List _games = [];
  final List _teams = [];
  String competition = "";

  factory Data() {
    //  debugPrint("INIT DATA");
    return _data;
  }

  Data._internal();

  void clear() {
    _teams.clear();
    _games.clear();
  }

  void addTeam(name, gamesPlayed, gamesWon) {
    _teams.add(TeamData(name, gamesPlayed, gamesWon));
  }

  void addGame(date) {
    _games.add(GameData(date));
  }

  List getGames() {
    //   notifyListeners();
    return _games;
  }

  List getTeams() {
    notifyListeners();
    return _teams;
  }

  setCompetition(String value) {
    competition = value;
  }
}

final data = Data();

class TeamData {
  int gamesPlayed;
  int gamesWon;
  String name;

  TeamData(this.name, this.gamesPlayed, this.gamesWon);

  String totalgamesWon() {
    return gamesWon.toString();
  }

  String totalgamesPlayed() {
    return gamesPlayed.toString();
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
    name = name.replaceAll(" DS ", " D");
    name = name.replaceAll(" HS ", " H");
    name = name.replaceAll(" JA ", " JA");
    name = name.replaceAll(" JB ", " JB");
    name = name.replaceAll(" JC ", " JC");
    name = name.replaceAll(" MA ", " MA");
    name = name.replaceAll(" MB ", " MB");
    name = name.replaceAll(" MC ", " MC");
    name = name.replaceAll(" MD ", " MD");

    return name;
  }
}

class GameData {
  String date;

  GameData(this.date);

  String gameDate() {
    return date;
  }
}
