import 'package:flutter/material.dart';
import 'package:mxe_mobile/base.vm.dart';
import 'package:mxe_mobile/core/services/auth-repository.dart';
import 'package:mxe_mobile/core/services/web-services/auth.api.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';

class ResetPinViewModel extends BaseViewModel {
  bool error = false;
  String? errorMessage_ = "";
  String? otp;
  setOtp(String v) {
    otp = v;
    notifyListeners();
  }

  setError({String? err}) {
    if (noOfAttempts != 1) {
      error = true;
      noOfAttempts = noOfAttempts - 1;
      errorMessage_ =
          err ?? "Incorrect PIN. You have $noOfAttempts attempts left";
      notifyListeners();
    } else {
      navigationService.navigateToReplace(Routes.lockPageRoute);
    }
  }

  num noOfAttempts = 5;

  reverseError() {
    error = false;
    pinController.clear();
    notifyListeners();
  }

  final auth = getIt<AuthenticationApiService>();
  final authRepo = getIt<AuthenticationRepository>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController pinController = TextEditingController();

  bool get hasOTP => otp.isNotNullNorEmpty && otp!.trim().length > 3;
}
