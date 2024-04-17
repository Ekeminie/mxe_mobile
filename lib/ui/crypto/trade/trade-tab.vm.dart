import 'package:flutter/material.dart';
import 'package:mxe_mobile/base.vm.dart';
import 'package:mxe_mobile/core/services/web-services/transactions-api-service.dart';
import 'package:mxe_mobile/locator.dart';

class TradeHomeViewModel extends BaseViewModel {
  final userApi = getIt<TransactionsApiService>();
  // CryptoHomeTabViewModel() {
  //   checkIndexCache();
  // }
  checkIndexCache() {
    // selectedIndex = appCache.cryptoHomePageIndex;
    notifyListeners();
  }

  int selectedIndex = 0;

  void onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  // User user = User();
  final TextEditingController airtime = TextEditingController();
  final TextEditingController data = TextEditingController();

  void refresh() {
    // user = userService.userCredentials.value;
    notifyListeners();
  }
}
