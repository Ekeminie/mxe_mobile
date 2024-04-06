import 'package:flutter/cupertino.dart';
import 'package:mxe_mobile/base.vm.dart';
import 'package:mxe_mobile/core/enum/bills-enum.dart';
import 'package:mxe_mobile/core/services/bills-repository.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/widgets/toast.dart';

class BuyDataViewModel extends BaseViewModel {
  num currentBalance = 1000;
  final bills = getIt<BillsRepository>();
  final TextEditingController phoneNumberController = TextEditingController();
  String? phone;
  String? beneficiaryName;
  num amount = 0;
  ValueNotifier<NetworkProviderEnum> network =
      ValueNotifier(NetworkProviderEnum.none);
  ValueNotifier<bool> saveBeneficiary = ValueNotifier(false);
  void setPhone(String? p, {bool useController = false}) {
    phone = p;
    if (useController) {
      phoneNumberController.text = phone!;
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

  bool get hasPhone => phone.isNotNullNorEmpty && phone!.length > 10;
  bool get hasNetwork => network.value.title != null;
  bool get hasDataVariation => selectedVariation.isNotNullNorEmpty;
  bool get isValidInputs => (saveBeneficiary.value)
      ? hasPhone &&
          hasNetwork &&
          hasDataVariation &&
          beneficiaryName.isNotNullNorEmpty
      : hasPhone && hasNetwork && hasDataVariation;

  refresh() {
    notifyListeners();
  }

  save() {
    bills.beneficiaryName = beneficiaryName;
    bills.saveBeneficiary = saveBeneficiary.value;
    bills.phone = phone;
    bills.amount = amount;
    bills.networkProvider = network.value;
  }

  get() {
    beneficiaryName = bills.beneficiaryName;
    saveBeneficiary.value = bills.saveBeneficiary ?? false;
    phone = bills.phone;
    amount = bills.amount;
    network.value = bills.networkProvider!;
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
