import 'package:flutter/cupertino.dart';
import 'package:mxe_mobile/base.vm.dart';
import 'package:mxe_mobile/core/enum/bills-enum.dart';
import 'package:mxe_mobile/core/services/bills-repository.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/widgets/toast.dart';

class PayBettingViewModel extends BaseViewModel {
  num currentBalance = 1000;
  final bills = getIt<BillsRepository>();
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  String? userID;
  String? beneficiaryName;
  num amount = 0;
  ValueNotifier<BettingProviderEnum?> provider = ValueNotifier(null);
  ValueNotifier<bool> saveBeneficiary = ValueNotifier(false);
  void setUserID(String? p, {bool useController = false}) {
    userID = p;
    if (useController) {
      userIdController.text = userID!;
    }
    notifyListeners();
  }

  setAmount(String v) {
    amount = num.tryParse(v) ?? 0;
    notifyListeners();
  }

  String? selectedVariation;
  setDataVariation(String v) {
    selectedVariation = "$v GB Data Plan";
    notifyListeners();
  }

  setBeneficiaryName(String v) {
    beneficiaryName = v;
    notifyListeners();
  }

  bool get hasUserID => userID.isNotNullNorEmpty && userID!.length > 8;
  bool get hasProvider => provider.value?.title != null;
  bool get hasAmount => amount != 0;
  bool get isValidInputs => (saveBeneficiary.value)
      ? hasUserID &&
          hasProvider &&
          beneficiaryName.isNotNullNorEmpty &&
          hasAmount
      : hasUserID && hasProvider && hasAmount;

  refresh() {
    notifyListeners();
  }

  save() {
    bills.beneficiaryName = beneficiaryName;
    bills.saveBeneficiary = saveBeneficiary.value;
    bills.betUserID = userID;
    bills.amount = amount;
    bills.bettingProvider = provider.value;
  }

  get() {
    beneficiaryName = bills.beneficiaryName;
    saveBeneficiary.value = bills.saveBeneficiary ?? false;
    userID = bills.betUserID;
    amount = bills.amount;
    provider.value = bills.bettingProvider!;
    notifyListeners();
  }

  hasSufficientBalance() {
    if (amount < currentBalance) {
      return null;
    } else {
      showCustomToast(
          "Sorry you do not have sufficient balance to complete this transaction");
      return " ";
    }
  }
}
