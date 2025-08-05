class PointsData {
  static final instance = PointsData._internal();
  List data = [];
  List ranking = [0, 4, 5, 1, 2, 6, 3];

  PointsData._internal();

  void clear() {
    data = [];
  }

  void add(Map map) {
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

  List getRanking() {
    ranking = [];
    for (int index = 0; index < data.length; index++) {
      ranking.add([
        data[index]["team"],
        (int.parse(data[index]["need"]) - int.parse(data[index]["points"])) /
            int.parse(data[index]["need"])
      ]);
    }
    for (var i = 0; i < ranking.length; i++) {
      ranking.sort((a, b) {
        return a[1].compareTo(b[1]);
      });
    }
    return ranking;
  }
}
