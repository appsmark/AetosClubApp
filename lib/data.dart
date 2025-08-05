import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeamInfo {
  List teamsInfo = [
    ["D1", "regio-oost/DPD", "dames/1"],
    ["D2", "regio-oost/D1E", "dames/2"],
    ["D3", "regio-oost/D1K", "dames/3"],
    ["D4", "regio-oost/D1J", "dames/4"],
    ["D5", "regio-oost/D1R", "dames/5"],
    ["D6", "regio-oost/D1J", "dames/6"],
    ["D7", "regio-oost/D2J", "dames/7"],
    ["D8", "regio-oost/D2V", "dames/8"],
    ["D9", "regio-oost/D2V", "dames/9"],
    ["D10", "regio-oost/D2J", "dames/10"],
    ["D11", "regio-oost/D3Q", "dames/11"],
    ["D12", "regio-oost/D4F", "dames/12"],
    ["D13", "regio-oost/D4G", "dames/13"],
    ["H1", "regio-oost/3BH", "heren/1"],
    ["H2", "regio-oost/HPC", "heren/2"],
    ["H3", "regio-oost/HPC", "heren/3"],
    ["H4", "regio-oost/H1J", "heren/4"],
    ["H5", "regio-oost/H1I", "heren/5"],
    ["H6", "regio-oost/H1J", "heren/6"],
    ["H7", "regio-oost/H2J", "heren/7"],
    ["H8", "regio-oost/H2J", "heren/8"],
    ["H9", "regio-oost/H3E", "heren/9"],
    ["MA1", "regio-oost/MAHC1", "meiden-a/1"],
    ["MA2", "regio-oost/MA1H1", "meiden-a/2"],
    ["MB1", "regio-oost/MBHC1", "meiden-b/1"],
    ["MB2", "regio-oost/MB1E1", "meiden-b/2"],
    ["MB3", "regio-oost/MB1H1", "meiden-b/3"],
    ["MB4", "regio-oost/MB1G1", "meiden-b/4"],
    ["MB5", "regio-oost/MB2L1", "meiden-b/5"],
    ["MB6", "regio-oost/MB2K1", "meiden-b/6"],
    ["MB7", "regio-oost/MB3F1", "meiden-b/7"],
    ["MB8", "regio-oost/MB3J1", "meiden-b/8"],
    ["MC1", "regio-oost/XCHC1", "meiden-c/1"],
    ["MC2", "regio-oost/XC2K1", "meiden-c/2"],
    ["MC3", "regio-oost/XC2L1", "meiden-c/3"],
    ["MC4", "regio-oost/XC2O1", "meiden-c/4"],
    ["MC5", "regio-oost/XC2F1", "meiden-c/5"],
    ["MC6", "regio-oost/XC2N1", "meiden-c/6"],
    ["MC7", "regio-oost/XC3N1", "meiden-c/7"],
    ["MC8", "regio-oost/XC3M1", "meiden-c/8"],
    ["JA1", "regio-oost/JAHA1", "jongens-a/1"],
    ["JA2", "regio-oost/JA2A1", "jongens-a/2"],
    ["JB1", "regio-oost/JBHA1", "jongens-b/1"],
    ["JB2", "regio-oost/JB2D1", "jongens-b/2"],
    ["JC1", "regio-oost/XCHC1", "jongens-c/1"],
    ["JC2", "regio-oost/XC2M1", "jongens-c/2"],
    ["JC3", "regio-oost/XC4C1", "jongens-c/3"],
    [
      "XZ1",
      "nationale-competitie/zitvolleybal-zitvolleybal-2/nationale-competitie-2zv1-3",
      "mix-zitvolleybal/1"
    ],
    /*
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
    */
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
