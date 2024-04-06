import 'package:flutter/material.dart';
import 'package:mxe_mobile/base.vm.dart';
import 'package:mxe_mobile/core/model/res_model.dart';
import 'package:mxe_mobile/core/services/web-services/transactions-api-service.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/widgets/toast.dart';

class CryptoHomeTabViewModel extends BaseViewModel {
  final userApi = getIt<TransactionsApiService>();
  // CryptoHomeTabViewModel() {
  //   checkIndexCache();
  // }
  checkIndexCache() {
    // selectedIndex = appCache.cryptoHomePageIndex;
    notifyListeners();
  }

  int selectedIndex = 1;

  void onItemTapped(int index) {
    selectedIndex = index;
    if (index == 0) {
      navigationService.navigateToReplace(Routes.homeRoute);
    }
    notifyListeners();
  }

  // User user = User();
  final TextEditingController airtime = TextEditingController();
  final TextEditingController data = TextEditingController();

  void refresh() {
    // user = userService.userCredentials.value;
    notifyListeners();
  }

  getInflowAndOutFlow() async {
    dropKeyboard();
    startLoader();

    try {
      ResModel res = await userApi.getInflowAndOutflow();
      if (res.success ?? false) {
        stopLoader();

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
