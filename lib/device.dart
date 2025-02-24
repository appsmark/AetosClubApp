import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class Device {
  static final Device instance = Device._internal();
  String release = "";

  Device._internal() {
    getInfo();
  }

  getInfo() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      release = androidInfo.version.release;
    }

    if (Platform.isIOS) {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      release = iosInfo.systemVersion;
    }
  }
}
