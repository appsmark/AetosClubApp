class ResultsData {
  static final instance = ResultsData._internal();
  List data = [];

  ResultsData._internal();

  clear() {
    data = [];
  }

  addGame(Map map) {
    data.add(map);
  }

  List getGames() {
    return data;
  }
}
