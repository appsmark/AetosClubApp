class EasterEgg {
  int count = 0;
  int countMaximum = 3;
  static final instance = EasterEgg._internal();

  EasterEgg._internal();

  void reset() {
    count = 0;
  }

  bool trigger() {
    bool result = false;
    count++;
    if (count >= countMaximum) {
      result = true;
    }
    return result;
  }

  bool triggered() {
    return (count >= countMaximum);
  }
}
