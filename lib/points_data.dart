class PointsData {
  static final instance = PointsData._internal();
  List data = [];

  PointsData._internal();

  clear() {
    data = [];
  }

  add(Map map) {
    data.add(map);
  }

  List get(String team) {
    List result = [];
    for (int index = 0; index < data.length; index++) {
      if (data[index]['team'] == team) {
        result.add(data[index]['date']);
        result.add(data[index]['points']);
        result.add(data[index]['need']);
        if (int.parse(data[index]['points']) >=
            int.parse(data[index]['need'])) {
          result.add(true);
        } else {
          result.add(false);
        }
      }
    }
    return result;
  }
}
