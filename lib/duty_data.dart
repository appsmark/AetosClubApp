class DutyData {
  static final instance = DutyData._internal();
  List data = [];
  List dataGame = [];

  DutyData._internal();

  clear() {
    data = [];
    dataGame = [];
  }

  add(Map map) {
    data.add(map);
  }

  addGameData(Map map) {
    dataGame.add(map);
  }

  List get() {
    return data;
  }

  List getGameData() {
    return dataGame;
  }
}
