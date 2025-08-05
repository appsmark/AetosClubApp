class ScheduleData {
  static final instance = ScheduleData._internal();
  List data = [
    //  {'date': '', 'time': '', 'game': '', 'hall': '', 'street': '', 'postal': ''}
  ];

  ScheduleData._internal();

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
