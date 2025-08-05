class ResultsData {
  static final instance = ResultsData._internal();
  List data = [];

  ResultsData._internal();

  void clear() {
    data = [];
  }

  void addGame(Map map) {
    data.add(map);
  }

  List getGames() {
    return data;
  }
}
