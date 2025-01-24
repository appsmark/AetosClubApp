class Players {
  static final instance = Players._internal();
  List data = [
    //  {'name': '', 'number': ''}
  ];

  Players._internal() {
    data.add({'name': 'Martin', 'number': 13});
    data.add({'name': 'Jack', 'number': 6});
    data.add({'name': 'Hans', 'number': 7});
    data.add({'name': 'Rohan', 'number': 8});
  }

  clear() {
    data = [];
  }

  addPlayer(Map map) {
    data.add(map);
  }

  List getPlayers() {
    return data;
  }
}
