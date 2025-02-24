import 'device.dart';
import 'version.dart';

class EasterEgg {
  int count = 0;
  int countMaximum = 3;
  Device device = Device.instance;
  static final instance = EasterEgg._internal();
  Version version = Version.instance;

  EasterEgg._internal();

  void reset() {
    count = 0;
  }

  String result(int type) {
    String value;
    switch (type) {
      case 0: // App version
        value = version.version;
        break;
      case 1: // OS version
        value = device.release;
        break;
      default:
        value = "";
        break;
    }
    return value;
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
