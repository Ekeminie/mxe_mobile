import 'package:flutter/cupertino.dart';
import 'package:mxe_mobile/base.vm.dart';
import 'package:mxe_mobile/core/enum/bills-enum.dart';
import 'package:mxe_mobile/core/services/bills-repository.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/ui/bills/electricity/electricity.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/widgets/toast.dart';

class PayCableViewModel extends BaseViewModel {
  ValueNotifier<EScheduleType?> scheduleType =
      ValueNotifier(EScheduleType.month);

  num currentBalance = 1000;
  final bills = getIt<BillsRepository>();
  final TextEditingController phoneNumberController = TextEditingController();
  String? smartCard;
  String? beneficiaryName;
  num amount = 0;
  ValueNotifier<CableProviderEnum?> provider = ValueNotifier(null);
  ValueNotifier<bool> schedulePayment = ValueNotifier(false);
  void setSmartCardNo(String? p, {bool useController = false}) {
    smartCard = p;
    if (useController) {
      phoneNumberController.text = smartCard!;
    }
    notifyListeners();
  }

  setAmount(String v) {
    amount = num.tryParse(v) ?? 0;
    notifyListeners();
  }

  String? selectedVariation;
  setCableVariation(String v) {
    selectedVariation = "$v Cable Plan";
    notifyListeners();
  }

  setBeneficiaryName(String v) {
    beneficiaryName = v;
    notifyListeners();
  }

  bool get hasSmartCardNo =>
      smartCard.isNotNullNorEmpty && smartCard!.length > 8;
  bool get hasCableProvider => provider.value?.title != null;
  bool get hasCableVariation => selectedVariation.isNotNullNorEmpty;
  bool get isValidInputs => (schedulePayment.value)
      ? hasSmartCardNo &&
          hasCableProvider &&
          hasCableVariation &&
          beneficiaryName.isNotNullNorEmpty
      : hasSmartCardNo && hasCableProvider && hasCableVariation;

  refresh() {
    notifyListeners();
  }

  save() {
    bills.beneficiaryName = beneficiaryName;
    bills.saveBeneficiary = schedulePayment.value;
    bills.smartCardNo = smartCard;
    bills.amount = amount;
    bills.cableProvider = provider.value;
  }

  get() {
    beneficiaryName = bills.beneficiaryName;
    schedulePayment.value = bills.saveBeneficiary ?? false;
    smartCard = bills.smartCardNo;
    amount = bills.amount;
    provider.value = bills.cableProvider!;
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

  setSchedule(EScheduleType v) {
    scheduleType.value = v;
    notifyListeners();
  }
}
