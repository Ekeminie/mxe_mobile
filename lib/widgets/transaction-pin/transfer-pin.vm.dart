import 'package:flutter/material.dart';
import 'package:mxe_mobile/base.vm.dart';
import 'package:mxe_mobile/core/model/res_model.dart';
import 'package:mxe_mobile/core/services/web-services/user-api-service.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/widgets/toast.dart';

class TransferPinViewModel extends BaseViewModel {
  String? _transactionPin;
  setPin(String v) {
    _transactionPin = v;
  }

  final userApi = getIt<UserApiService>();

  verifyPassword({Function? f}) async {
    startLoader();

    try {
      ResModel res =
          await userApi.getMXEUserNameSuggestions(name: _transactionPin!);

      if (res.isSuccess) {
        if (f != null) {
          f();
        }
      } else {
        stopLoader();
        showCustomToast(res.message ?? "");
      }
    } catch (e) {
      stopLoader();
      showCustomToast(e.toString() ?? "");
    }
  }

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

  TextEditingController pinController = TextEditingController();
}
