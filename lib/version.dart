import 'package:new_version_plus/new_version_plus.dart';

import 'configuration.dart';

class Version {
  static final Version instance = Version._internal();
  String release = "";
  String version = "";

  Version._internal();

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
      release = versionApp.releaseNotes ?? "";
    }
  }

  updateDialog(context) async {
    final status = await newVersion.getVersionStatus();
    if (status != null) {
      if (status.canUpdate) {
        newVersion.showUpdateDialog(
          context: context,
          dialogTitle: 'Update available',
          dialogText: '${status.releaseNotes}',
          dismissButtonText: 'Later',
          launchModeVersion: LaunchModeVersion.external,
          versionStatus: status,
        );
      }
    }
  }
}
