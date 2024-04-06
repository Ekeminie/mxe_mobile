import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mxe_mobile/base.vm.dart';

class HomeViewModel extends BaseViewModel {
  String? ref;
  String? id;

  HomeViewModel() {
    // user = userService.userCredentials.value;
    // notifyListeners();
  }

  int selectedIndex = 0;
  void onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  // User user = User();
  final TextEditingController airtime = TextEditingController();
  final TextEditingController data = TextEditingController();

  // void refresh() {
  //   user = userService.userCredentials.value;
  //   notifyListeners();
  // }

  int pageIndex = 0;

  updatePageIndex({int? index}) {
    pageIndex = index!;
    notifyListeners();
  }
}
