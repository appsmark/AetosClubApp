import 'package:new_version_plus/new_version_plus.dart';

import 'configuration.dart';

class Version {
  static final Version instance = Version._internal();
  String version = "";

  Version._internal() {
    basicStatusCheck(newVersion);
  }

  final newVersion = NewVersionPlus(
    iOSId: Configuration().appIdIos,
    iOSAppStoreCountry: 'nl',
    androidId: Configuration().appIdAndroid,
    androidPlayStoreCountry: "",
    androidHtmlReleaseNotes: true, //support country code
  );

  basicStatusCheck(NewVersionPlus newVersion) async {
    final versionApp = await newVersion.getVersionStatus();
    if (versionApp != null) {
      version = versionApp.localVersion;
    }
  }
}
