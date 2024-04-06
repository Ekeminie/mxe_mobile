import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mxe_mobile/base.vm.dart';
import 'package:mxe_mobile/core/model/request/auth.dart';
import 'package:mxe_mobile/core/model/res_model.dart';
import 'package:mxe_mobile/core/model/user-model.dart';
import 'package:mxe_mobile/core/services/web-services/auth.api.dart';
import 'package:mxe_mobile/core/services/web-services/user-api-service.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/widgets/toast.dart';

class SignupViewModel extends BaseViewModel {
  final authApi = getIt<AuthenticationApiService>();
  final userApi = getIt<UserApiService>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  ValueNotifier<List<String>> mxeNames = ValueNotifier([]);

  bool? _termsAndConditions = false;
  bool get termsAndConditions => _termsAndConditions!;
  set termsAndConditions(bool v) {
    _termsAndConditions = v;
    notifyListeners();
  }

  String? _firstName;
  String? _lastName;
  String? _email;
  String? _phone;
  String? _password;
  String? _confirmPassword;

  bool get hasFName => fName.isNotNullNorEmpty;
  bool get hasLName => lName.isNotNullNorEmpty;
  bool get hasNames => hasFName && hasLName;
  bool get hasEmail => _email.hasValue;
  bool get hasPin => pin.isNotNullNorEmpty && (pin?.length ?? 0) >= 4;
  bool get hasConfirmPin => confirmPin.isNotNullNorEmpty;
  bool get isPinMatch => pin == confirmPin;
  bool get isValidPins => hasPin && hasConfirmPin && isPinMatch;
  bool get hasMxeTag => mxeTag.isNotNullNorEmpty;

  ///TODO: add a way to verify mxe tag before proceeding
  bool get isValidInputs =>
      hasFName && hasLName && hasEmail && isValidPins && hasMxeTag;

  showValidationMessage() {
    switch (pageIndex) {
      case 0:
        if (!hasFName) {
          "Please enter a valid first name".toast();
        } else if (!hasLName) {
          "Please enter a valid last name".toast();
        }
        break;
      case 1:
        if (!hasEmail) {
          "Please enter a valid email".toast();
        }
        break;
      case 2:
        if (!hasPin) {
          "Please enter a valid pin".toast();
        }
        break;
      case 3:
        if (!hasConfirmPin) {
          "Please enter a valid confirm pin".toast();
        } else if (!isPinMatch) {
          "Pin and Confirm Pin do not match".toast();
        }
        break;
      case 4:
        if (!hasMxeTag) {
          "Please enter a valid mxe tag".toast();
        }
        break;
      default:
        break;
    }
  }

  SignUpRequest get request => SignUpRequest(
        email: _email!.trim(),
        password: _password!.trim(),
        lastName: _lastName,
        firstName: _firstName,
        phone: _phone,
      );

  proceed() async {
    userService.signUpRequest = request;
    navigationService.navigateTo(Routes.emailVerificationRoute);
  }

  signUp({String? method}) async {
    //kill the  keyboard
    dropKeyboard();
    //change  viewState to show  loading indicator
    startLoader();
    //initialize an object to pass sign up data
    //create the  api req for login

    try {
      ResModel res = await authApi.signup(request);

      if (res.isSuccess) {
        stopLoader();
        userService.signUpRequest = request;
        navigationService.navigateToReplace(Routes.emailVerificationRoute);
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

  set firstName(String v) {
    _firstName = v;
    notifyListeners();
  }

  set lastName(String v) {
    _lastName = v;
    notifyListeners();
  }

  set email(String v) {
    _email = v;
    notifyListeners();
  }

  set phone(String v) {
    _phone = v;
    notifyListeners();
  }

  set password(String v) {
    _password = v;
    notifyListeners();
  }

  set confirmPassword(String v) {
    _confirmPassword = v;
    notifyListeners();
  }

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  toggleObscurePassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  toggleObscureConfirmPassword() {
    obscureConfirmPassword = !obscureConfirmPassword;
    notifyListeners();
  }

  String? fName;
  String? lName;
  String? pin;
  String? confirmPin;
  String? mxeTag;

  setFName(String v) {
    fName = v;
    notifyListeners();
  }

  setLName(String v) {
    lName = v;
    notifyListeners();
  }

  setEmail(String v) {
    email = v;
    notifyListeners();
  }

  setPin(String v) {
    pin = v;
    notifyListeners();
  }

  setConfirmPin(String v) {
    confirmPin = v;
    notifyListeners();
  }

  setMXETag(String v, {bool useController = false}) {
    if (useController) {
      mxeUserNameController.text = v;
    }
    mxeTag = v;
    notifyListeners();
  }

  num pageIndex = 0;
  goForward() {
    if (pageIndex != 4) {
      pageIndex = pageIndex + 1;
      notifyListeners();
    }
  }

  goBack() {
    if (pageIndex != 0) {
      pageIndex = pageIndex - 1;
      notifyListeners();
    }
  }

  TextEditingController pinController = TextEditingController();
  TextEditingController mxeUserNameController = TextEditingController();
  TextEditingController confirmPinController = TextEditingController();
  bool error = false;
  String? errorMessage_ = "";
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

  updateNameAndEmail() async {
    await updateUser(
        user: UserData(email: _email, firstName: fName, lastName: lName),
        goHome: false);
  }

  updatePassword() async {
    await getMxeUserNameSuggestions(goHome: false);
    await updateUserPassword(goHome: false);
  }

  updateMxeTag() async {
    await addMxeRag();
  }

  updateUser({UserData? user, bool goHome = false}) async {
    dropKeyboard();
    startLoader();

    try {
      ResModel res = await userApi.updateUser(user: user?.toJson());
      if (res.isSuccess) {
        stopLoader();
        if (goHome) {
          navigationService.navigateTo(
            Routes.homeRoute,
          );
        } else {
          goForward();
        }

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

  updateUserPassword({bool goHome = false}) async {
    dropKeyboard();
    startLoader();

    try {
      ResModel res = await userApi.addPasswordAfterSignUp(password: pin);
      if (res.isSuccess) {
        stopLoader();
        if (goHome) {
          navigationService.navigateTo(
            Routes.homeRoute,
          );
        } else {
          goForward();
        }

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

  getMxeUserNameSuggestions({bool goHome = false}) async {
    dropKeyboard();
    startLoader();

    try {
      ResModel res = await userApi.getMXEUserNameSuggestions(name: fName);
      if (res.isSuccess) {
        stopLoader();
        mxeNames.value = res.data.cast<String>();
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

  addMxeRag({bool goHome = false}) async {
    dropKeyboard();
    startLoader();

    try {
      ResModel res = await userApi.addMxeTag(tag: mxeTag);
      if (res.isSuccess) {
        await getIt<UserApiService>().getUser();
        stopLoader();

        navigationService.navigateTo(Routes.homeRoute);

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
