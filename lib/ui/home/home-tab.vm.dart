import 'package:flutter/material.dart';
import 'package:mxe_mobile/base.vm.dart';
import 'package:mxe_mobile/core/model/res_model.dart';
import 'package:mxe_mobile/core/services/web-services/transactions-api-service.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/widgets/toast.dart';

class HomeTabViewModel extends BaseViewModel {
  final userApi = getIt<TransactionsApiService>();
  HomeTabViewModel() {
    checkIndexCache();
  }
  checkIndexCache() {
    selectedIndex = appCache.homePageIndex;
    notifyListeners();
  }

  late int selectedIndex;

  void onItemTapped(int index) {
    selectedIndex = index;
    appCache.homePageIndex = index;
    if (index == 1) {
      appCache.homePageIndex = 0;
      navigationService.navigateTo(Routes.cryptoOnboarding);
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
