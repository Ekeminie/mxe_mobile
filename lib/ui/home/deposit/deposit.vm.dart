import 'package:flutter/cupertino.dart';
import 'package:mxe_mobile/base.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';

class DepositViewModel extends BaseViewModel {
  num numAmount = 0;

  TextEditingController amountController = TextEditingController();
  setAmount(String v) {
    numAmount = num.tryParse(v) ?? 0;
    amountController.text = formatPrice(v).substring(1).replaceAll(".00", "");
    notifyListeners();
  }

  bool get hasAmount => numAmount > 1;
}
