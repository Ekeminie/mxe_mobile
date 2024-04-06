import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mxe_mobile/constant/constants.dart';
import 'package:mxe_mobile/core/services/app-settings.dart';
import 'package:mxe_mobile/core/services/biometrics-service.dart';
import 'package:mxe_mobile/core/services/encryption-service.dart';
import 'package:mxe_mobile/core/services/web-services/user-api-service.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/utils/network_exception.dart';

import '../core/services/storage-service.dart';
import '../core/services/user.service.dart';

class Initializer extends ChangeNotifier {
  UserService userService = getIt<UserService>();
  StorageService storageService = getIt<StorageService>();
  UserApiService userApi = getIt<UserApiService>();

  initOnBoardingInfo() async {
    hasOpenedAppBefore = await storageService.readItem(key: introScreen);
    notifyListeners();
  }

  init() async {
    try {
      await Future.wait(<Future>[
        bioMetrics.checkSupport(),
        encryptionService.initEncryptionService(),
        appSettings.readAppSettings(),
        checkForCachedUserData(),
      ]);
    } catch (e) {
      print(e);
    }
  }

  checkForCachedUserData() async {
    String? value = await storageService.readItem(key: currentUser);
    if (value != null && value.isNotEmpty) {
      await getIt<UserService>().initUserFromLocal();
    }
  }

  String? hasOpenedAppBefore;
  bool get hasSeenOnBoarding =>
      hasOpenedAppBefore != null && hasOpenedAppBefore!.isNotEmpty;

  Future initialCalls() async {
    try {
      String? value = await storageService.readItem(key: token);
      if (value != null && value.isNotEmpty) {
        await Future.wait(<Future>[
          await userService.getLocalUser(),
          userApi.getUser(),
          getUserCalls(),
        ]);
      }
    } on DioError catch (e) {
      return e.response.toString();
    } catch (e) {
      return e.toString();
    }
  }

  getUserCalls() async {
    await userService.getLocalUser();
  }

  Future getRemoteUserData() async {
    try {
      Future getUser = userApi.getUser();
      FutureGroup futureGroup = FutureGroup();

      futureGroup.add(getUser);
      futureGroup.close();
      futureGroup.future;
    } on DioError catch (e) {
      return getErrorFromDio(e);
    } catch (e) {
      return e.toString();
    }
  }
}
