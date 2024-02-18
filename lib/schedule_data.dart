class ScheduleData {
  static final instance = ScheduleData._internal();
  List data = [];

  ScheduleData._internal();

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
