import 'package:flutter/material.dart';
import 'package:mxe_mobile/base.vm.dart';
import 'package:mxe_mobile/core/model/res_model.dart';
import 'package:mxe_mobile/core/services/auth-repository.dart';
import 'package:mxe_mobile/core/services/web-services/auth.api.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/widgets/toast.dart';

class OtpVerificationViewModel extends BaseViewModel {
  bool error = false;
  String? errorMessage_ = "";
  String? otp;
  setOtp(String v) {
    otp = v;
    notifyListeners();
  }

  setError({String? err}) {
    error = true;
    errorMessage_ =
        err ?? "Incorrect Code. Please check the code and try again";
    notifyListeners();
  }

  reverseError() {
    error = false;
    pinController.clear();
    notifyListeners();
  }

  bool get hasOTP => otp.isNotNullNorEmpty && otp!.trim().length > 3;

  final auth = getIt<AuthenticationApiService>();
  final authRepo = getIt<AuthenticationRepository>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController pinController = TextEditingController();

  verifyOtp(String? route) async {
    dropKeyboard();
    startLoader();

    try {
      ResModel res = await auth.verifyCode(code: otp);
      if (res.isSuccess) {
        stopLoader();
        navigationService.navigateTo(route ?? Routes.notificationHandler,
            argument: Routes.signupDetailsRoute);

        return;
      } else {
        //update viewState
        stopLoader();
        setError(err: res.message);
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

  resendOtp() async {
    dropKeyboard();
    startLoader();

    try {
      ResModel res = await auth.resendCode();
      if (res.isSuccess) {
        stopLoader();

        return;
      } else {
        //update viewState
        stopLoader();
        setError(err: res.message);
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
