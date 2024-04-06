import 'dart:core';

import 'package:flutter/material.dart';
import 'package:mxe_mobile/core/services/app-cache.dart';
import 'package:mxe_mobile/core/services/storage-service.dart';
import 'package:mxe_mobile/core/services/user.service.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/utils/debounce.dart';

import '../core/enum/viewState.enum.dart';
import '../core/services/navigation_service.dart';

class BaseViewModel extends ChangeNotifier {
  final debouncer = Debouncer();
  ViewState _viewState = ViewState.idle;
  NavigationService navigationService = getIt<NavigationService>();
  UserService userService = getIt<UserService>();

  StorageService storageService = getIt<StorageService>();
  AppCache appCache = getIt<AppCache>();

  ViewState get viewState => _viewState;

  set viewState(ViewState newState) {
    if (newState == ViewState.busy) {
      hasError = false;
    }
    _viewState = newState;
    notifyListeners();
  }

  bool isLoading = false;
  bool hasError = false;
  clearError() {
    hasError = false;
    errorMessage = null;
    notifyListeners();
  }

  Function? retryFunction;
  String? errorMessage;
  String genericErrorMessage = 'Request Failed. Please try again';

  void showError(Function? function, {String? msg}) {
    if (!hasError) {
      hasError = true;
      retryFunction = function;
      errorMessage = msg ?? "Request Failed, Try again";
      notifyListeners();
      stopLoader();
    }
  }

  void startLoader() {
    if (!isLoading) {
      hasError = false;
      isLoading = true;
      viewState = ViewState.busy;
      notifyListeners();
    }
  }

  void stopLoader() {
    if (isLoading) {
      isLoading = false;
      viewState = ViewState.idle;
      notifyListeners();
    }
  }

  dropKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
