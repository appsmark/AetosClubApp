import 'package:shared_preferences/shared_preferences.dart';

class VersionSwitch {
  static final instance = VersionSwitch._internal();
  bool newVersion = false;

  VersionSwitch._internal();

  get() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    newVersion = preferences.getBool('new_version') ?? false;
  }

  set(bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('new_version', value);
  }

  switchState() {
    newVersion = !newVersion;
    set(newVersion);
  }
}
