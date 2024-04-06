import 'package:flutter/material.dart';
import 'package:mxe_mobile/base.vm.dart';
import 'package:mxe_mobile/core/model/res_model.dart';
import 'package:mxe_mobile/core/services/auth-repository.dart';
import 'package:mxe_mobile/core/services/web-services/auth.api.dart';
import 'package:mxe_mobile/core/services/web-services/user-api-service.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/widgets/toast.dart';

class ChangePinViewModel extends BaseViewModel {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController pinController = TextEditingController();

  final auth = getIt<AuthenticationApiService>();
  final authRepo = getIt<AuthenticationRepository>();

  bool get hasOTP => otp.isNotNullNorEmpty && otp!.trim().length > 3;
  bool get hasPin => pin.isNotNullNorEmpty && pin!.trim().length > 3;
  bool get hasCPin =>
      confirmPin.isNotNullNorEmpty && confirmPin!.trim().length > 3;
  bool get isValidPins => hasPin && hasCPin && (pin == confirmPin);

  bool error = false;
  String? errorMessage_ = "";
  String? otp;
  String? pin;
  String? confirmPin;

  setPin(String? v) {
    pin = v;
    notifyListeners();
  }

  setConfirmPin(String? v) {
    confirmPin = v;
    notifyListeners();
  }

  num pageIndex = 0;
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

  simulateLoading(String route) async {
    startLoader();
    await Future.delayed(const Duration(seconds: 4));
    stopLoader();
    if (hasOTP) {
      navigationService.navigateTo(route);
    }
  }

  changePageIndex(num v) {
    pageIndex = pageIndex + v;
    notifyListeners();
  }

  sendOTP() async {
    //kill the  keyboard
    dropKeyboard();
    //change  viewState to show  loading indicator
    startLoader();
    //initialize an object to pass sign up data
    //create the  api req for login

    try {
      ResModel res = await auth.login(
          phoneNo: userService.userCredentials.value.phoneNumber);

      if (res.isSuccess) {
        await getIt<UserApiService>().getUser();
        stopLoader();

        return;
      } else {
        //update viewState
        stopLoader();
        //show error message if any
        showCustomToast(res.message!);
      }
    } catch (e) {
      print(e.toString());
      stopLoader();
      //show error message if any
      showCustomToast(genericErrorMessage);
    }
  }

  changePin() async {
    dropKeyboard();
    startLoader();

    try {
      ResModel res =
          await getIt<UserApiService>().changePin(otp: otp, pin: pin);
      if (res.isSuccess) {
        stopLoader();
        navigationService.navigateTo(
          Routes.homeRoute,
        );

        return;
      } else {
        //update viewState
        stopLoader();
        //show error message if any
        showCustomToast(res.message!);
      }
    } catch (e) {
      debugPrint(e.toString());
      stopLoader();
      //show error message if any
      showCustomToast(genericErrorMessage);
    }
  }
}
