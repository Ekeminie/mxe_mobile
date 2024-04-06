import 'package:flutter/material.dart';
import 'package:mxe_mobile/base.vm.dart';
import 'package:mxe_mobile/core/model/on-device-auth-info.dart';
import 'package:mxe_mobile/core/model/res_model.dart';
import 'package:mxe_mobile/core/model/user-response.dart';
import 'package:mxe_mobile/core/services/auth-repository.dart';
import 'package:mxe_mobile/core/services/encryption-service.dart';
import 'package:mxe_mobile/core/services/web-services/auth.api.dart';
import 'package:mxe_mobile/core/services/web-services/user-api-service.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/widgets/toast.dart';

import '../../../core/model/request/auth.dart';

class LoginViewModel extends BaseViewModel {
  bool error = false;
  String? errorMessage_ = "";
  String? otp;
  setOtp(String v) {
    otp = v;
    notifyListeners();
  }

  setError({String? err}) {
    if ((userService.passwordRetries) != 1) {
      error = true;

      errorMessage_ = err ??
          "Incorrect PIN. You have ${userService.passwordRetries} attempts left";
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

  LoginViewModel() {
    emailController.text = appCache.cachedAuthInfo?.email ?? "";
    email = appCache.cachedAuthInfo?.email ?? "";
  }
  bool obscurePassword = true;

  String? get password => _password;

  set password(String? value) {
    _password = value;
    notifyListeners();
  }

  String? phoneNo;
  setPhoneNo(String? value) {
    phoneNo = value;
    authRepo.phone = value;
    notifyListeners();
  }

  bool get hasEmail => _email != null && _email!.isNotEmpty;
  bool get hasOTP => otp.isNotNullNorEmpty && otp!.trim().length > 3;
  bool get hasPhone => phoneNo.isNotNullNorEmpty && phoneNo!.trim().length > 10;
  bool get hasPassword => _password != null && _password!.isNotEmpty;
  bool get isValidInput => hasEmail && hasPassword;

  showValidationMessage() {
    if (!hasEmail) {
      "Please enter a valid email".toast();
    } else {
      "Please enter a valid password".toast();
    }
  }

  String? _password;

  String? _email;

  togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  String? get email => _email;

  set email(String? value) {
    _email = value;
    notifyListeners();
  }

  LoginRequest get request =>
      LoginRequest(email: _email!.trim(), password: _password!.trim());

  login() async {
    //kill the  keyboard
    dropKeyboard();
    //change  viewState to show  loading indicator
    startLoader();
    //initialize an object to pass sign up data
    //create the  api req for login

    try {
      ResModel res = await auth.login(phoneNo: phoneNo);

      if (res.isSuccess) {
        await getIt<UserApiService>().getUser();
        stopLoader();
        navigationService.navigateTo(Routes.oTPPageRoute,
            argument: Routes.homeRoute);
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

  emailAndPasswordLogin() async {
    //kill the  keyboard
    dropKeyboard();
    //change  viewState to show  loading indicator
    startLoader();
    //initialize an object to pass sign up data
    //create the  api req for login

    try {
      ResModel res = await auth.loginWithMailAndPassword(
          email: userService.userCredentials.value.email, password: password);

      if (res.isSuccess) {
        await getIt<UserApiService>().getUser();
        navigationService.navigateTo(Routes.homeRoute);
        return;
      } else {
        //update viewState
        stopLoader();
        setError();
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

  biometricAuth() async {
    FocusManager.instance.primaryFocus?.unfocus();
    startLoader();
    try {
      ResModel res = await auth.login(phoneNo: "");

      debugPrint(res.toString());

      if (res.isSuccess) {
        await getIt<UserApiService>().getUser();
        saveAuthInfo();
        stopLoader();
        navigationService.navigateToReplace(Routes.homeRoute);
      } else {
        await init();
        stopLoader();
        (res.message ?? "").toast();
      }
    } catch (e) {
      stopLoader();
      (e.toString()).toast();
    }
    stopLoader();
  }

  saveAuthInfo() {
    encryptionService.authInfo = OnDeviceAuthInfo(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      fullName: userService.userCredentials.value.fullName,
    );
    encryptionService.saveAuthInfo(info: encryptionService.authInfo);
  }

  prefillDetails(LoginRequest? request) {
    if (request != null) {
      emailController.text = request.email ?? "";
      email = request.email ?? "";
      passwordController.text == request.password;
      password = request.password;
    }
  }

  logout() {
    navigationService.navigateToReplace(Routes.phoneAuthPage);
  }

  simulateLoading(String route) async {
    startLoader();
    await Future.delayed(const Duration(seconds: 4));
    stopLoader();
    if (hasOTP) {
      navigationService.navigateTo(route);
    }
  }

  registerPhoneNumber() async {
    dropKeyboard();
    startLoader();

    try {
      ResModel res = await auth.registerPhoneNumber(phoneNo: phoneNo);
      if (res.isSuccess) {
        stopLoader();
        navigationService.navigateTo(Routes.oTPPageRoute,
            argument: Routes.notificationHandler);

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

  verifyOtp() async {
    dropKeyboard();
    startLoader();

    try {
      ResModel res = await auth.verifyCode(code: phoneNo);
      if (res.isSuccess) {
        stopLoader();
        navigationService.navigateTo(Routes.oTPPageRoute,
            argument: Routes.notificationHandler);

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

  init() async {
    dropKeyboard();
    startLoader();

    try {
      GetUserResponse res = await getIt<UserApiService>().getUser();
      if (res.success ?? false) {
        stopLoader();
        if ((userService.passwordRetries) == 1) {
          navigationService.navigateToReplace(Routes.lockPageRoute);
          return;
        }

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
}
