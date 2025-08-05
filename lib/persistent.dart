import 'package:shared_preferences/shared_preferences.dart';

class Persistent {
  static final instance = Persistent._internal();
  int menuIndex = 1;

  Persistent._internal();

  Future<void> getMenuIndex() async {
    final preferences = await SharedPreferences.getInstance();
    menuIndex = (preferences.getInt('menuIndex') ?? 1);
  }

  setMenuIndex(value) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setInt('menuIndex', value);
    menuIndex = value;
  }
}
