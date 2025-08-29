import 'package:shared_preferences/shared_preferences.dart';

class Persistent {
  static final instance = Persistent._internal();
  int infoListIndex = 0;
  int menuIndex = 4;

  Persistent._internal() {
    getInfoListIndex();
  }

  Future<void> getInfoListIndex() async {
    final preferences = await SharedPreferences.getInstance();
    infoListIndex = (preferences.getInt('infoListIndex') ?? 0);
  }

  Future<void> setInfoListIndex(int value) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setInt('infoListIndex', value);
    infoListIndex = value;
  }

  Future<void> getMenuIndex() async {
    final preferences = await SharedPreferences.getInstance();
    menuIndex = (preferences.getInt('menuIndex') ?? 4);
  }

  Future<void> setMenuIndex(int value) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setInt('menuIndex', value);
    menuIndex = value;
  }
}
