class DutyData {
  static final instance = DutyData._internal();
  List data = [];

  DutyData._internal();

  clear() {
    data = [];
  }

  add(Map map) {
    data.add(map);
  }

  List get() {
    return data;
  }
}
