import 'package:flutter/material.dart';
import 'package:mxe_mobile/constant/constants.dart';
import 'package:mxe_mobile/core/services/storage-service.dart';
import 'package:mxe_mobile/locator.dart';

final appSettings = getIt<AppSettings>();

class AppSettings {
  // late PackageInfo packageInfo;
  AppSettings() {
    readAppSettings();
  }

  final storage = getIt<StorageService>();

  readAppSettings() async {
    // packageInfo = await PackageInfo.fromPlatform();
    debugPrint("readAppSettings");
    String? isFingerPrintEnabledValue =
        await storage.readItem(key: toggleBiometrics);
    print("app settings value for fingerprint:$isFingerPrintEnabledValue");

    (isFingerPrintEnabledValue == null || isFingerPrintEnabledValue == "false")
        ? isFingerPrintEnabled = ValueNotifier(false)
        : isFingerPrintEnabled = ValueNotifier(true);
  }

  toggleEnableBiometrics(bool show) async {
    storage.storeItem(key: toggleBiometrics, value: show.toString());
    isFingerPrintEnabled.value = show;
  }

  late ValueNotifier<bool> isFingerPrintEnabled;
}
