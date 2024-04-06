import 'package:flutter/cupertino.dart';
import 'package:mxe_mobile/base.vm.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';

class CreatePinViewModel extends BaseViewModel {
  TextEditingController pinController = TextEditingController();
  TextEditingController confirmPinController = TextEditingController();
  bool error = false;
  String? errorMessage_ = "";
  String? pin;
  String? confirmPin;

  bool get hasPin => pin.isNotNullNorEmpty && pin?.length == 4;
  bool get hasConfirmPin =>
      confirmPin.isNotNullNorEmpty && confirmPin?.length == 4;
  bool get isPinMatch => pin == confirmPin;
  bool get isValidInputs => hasPin && hasConfirmPin && isPinMatch;

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

  void setPin(String value) {
    pin = value;
    userService.authCreatePin = value;
    notifyListeners();
  }

  void setConfirmPin(String value) {
    confirmPin = value;
    notifyListeners();
  }

  validatePin() {
    if (userService.authCreatePin != confirmPin) {
      setError(err: "Pins do not match, Please retry");
    }
  }
}
