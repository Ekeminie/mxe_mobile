import 'package:flutter/material.dart';
import 'package:mxe_mobile/constant/constants.dart';
import 'package:mxe_mobile/core/model/request/auth.dart';
import 'package:mxe_mobile/core/model/user-response.dart';
import 'package:mxe_mobile/core/services/storage-service.dart';
import 'package:mxe_mobile/locator.dart';

final uService = getIt<UserService>();

class UserService {
  String defaultCurrency = "GBP";
  late Locale myLocale;
  ValueNotifier<User> userCredentials = ValueNotifier(User());

  num get passwordRetries => userCredentials.value.passwordRetries ?? 0;

  StorageService storageService = getIt<StorageService>();
  bool get isLoggedIn => userCredentials.value.id != null;

  String? code;

  //get the user object
  getLocalUser({User? user}) async {
    debugPrint("getLocalUser");
    print("user:::${user.toString()}");
    if (user != null) {
      userCredentials.value = user;
    } else {
      String? userVal = await storageService.readItem(key: currentUser);
      if (userVal != null) {
        User? response = userOnlyModelFromJson(userVal);
        userCredentials.value = response;
      }
    }
  }

  initUserFromLocal() async {
    String? userVal = await storageService.readItem(key: currentUser);
    if (userVal != null) userCredentials.value = userOnlyModelFromJson(userVal);
  }

  resetAllCredentials() {
    storageService.deleteItem(key: currentUser);
    storageService.deleteItem(key: token);
    userCredentials.value = User();
  }

  ///for password reset
  String? authProcessEmail;
  String? authCreatePin;
  String? accountDeletionReason;

  ///for signup process
  SignUpRequest? signUpRequest;

  ///for transactions
  String? transactionPin;
}
