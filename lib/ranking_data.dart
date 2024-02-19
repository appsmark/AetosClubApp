class RankingData {
  static final instance = RankingData._internal();
  String competition = "";
  List data = [];

  RankingData._internal();

  clear() {
    data = [];
  }

  addTeam(Map map) {
    data.add(map);
  }

  List getTeams() {
    return data;
  }
}
