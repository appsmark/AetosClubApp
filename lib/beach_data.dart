class BeachData {
  bool enabled = false;
  static final instance = BeachData._internal();
  bool access = false;

  BeachData._internal();

  setAccess(bool value) {
    access = value;
  }
}
