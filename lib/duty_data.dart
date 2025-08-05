class DutyData {
  static final instance = DutyData._internal();
  List data = [];
  List dataGame = [];

  DutyData._internal();

  void clear() {
    data = [];
    dataGame = [];
  }

  void add(Map map) {
    data.add(map);
  }

  void addGameData(Map map) {
    dataGame.add(map);
  }

  List get() {
    return data;
  }

  List getGameData() {
    return dataGame;
  }
}
