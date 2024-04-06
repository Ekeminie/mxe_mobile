import 'dart:convert';

import 'package:flutter/cupertino.dart' hide Key;
import 'package:mxe_mobile/constant/constants.dart';
import 'package:mxe_mobile/core/model/on-device-auth-info.dart';
import 'package:mxe_mobile/core/services/app-cache.dart';
import 'package:mxe_mobile/core/services/storage-service.dart';
import 'package:mxe_mobile/locator.dart';

final encryptionService = getIt<EncryptionService>();

class EncryptionService {
  final storageService = getIt<StorageService>();
  String? onDeviceAuthData;

  ValueNotifier<bool> get hasEncryptedData =>
      ValueNotifier(onDeviceAuthData != null && onDeviceAuthData!.isNotEmpty);

  bool? get hasEncryptedPassword =>
      onDeviceAuthData != null && onDeviceAuthData!.isNotEmpty;
  OnDeviceAuthInfo? authInfo;

  initEncryptionService() async {
    // storageService.deleteItem(key: encryptAuthInfo);
    onDeviceAuthData = await storageService.readItem(key: encryptAuthInfo);
    debugPrint("init encryption $onDeviceAuthData");
    if (onDeviceAuthData != null && onDeviceAuthData!.trim().isNotEmpty) {
      try {
        authInfo = OnDeviceAuthInfo.fromMap(jsonDecode(onDeviceAuthData ?? ""));
        getIt<AppCache>().cachedAuthInfo = authInfo;
      } catch (e) {
        storageService.deleteItem(key: encryptAuthInfo);
        return;
      }
    }
  }

  saveAuthInfo({OnDeviceAuthInfo? info}) async {
    print("saving authenticaton info ${info?.toMap().toString()}");
    storageService.storeItem(
        key: encryptAuthInfo, value: jsonEncode(info?.toMap()));
    await initEncryptionService();
  }

  deletePasswordEncryption() {
    storageService.deleteItem(key: encryptAuthInfo);
  }
}
