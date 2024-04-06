import 'package:flutter/material.dart';
import 'package:mxe_mobile/base.vm.dart';
import 'package:mxe_mobile/ui/profile/statement/statement.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';

class SaveInUsdViewModel extends BaseViewModel {
  ValueNotifier<StatementAccountEnum?> accountType = ValueNotifier(null);

  num numAmount = 0;
  num conversionAmount = 0;

  TextEditingController amountController = TextEditingController();
  setAmount(String v) {
    numAmount = num.tryParse(v) ?? 0;
    amountController.text = formatPrice(v).substring(1).replaceAll(".00", "");
    conversionAmount = num.tryParse(v) ?? 0;
    notifyListeners();
  }

  bool get hasAmount => numAmount > 50;

  refresh() {
    notifyListeners();
  }
}
