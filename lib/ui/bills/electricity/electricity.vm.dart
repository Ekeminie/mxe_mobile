import 'package:flutter/cupertino.dart';
import 'package:mxe_mobile/base.vm.dart';
import 'package:mxe_mobile/core/enum/bills-enum.dart';
import 'package:mxe_mobile/core/services/bills-repository.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/widgets/toast.dart';

class BuyElectricityViewModel extends BaseViewModel {
  num currentBalance = 1000;
  final bills = getIt<BillsRepository>();
  final TextEditingController phoneNumberController = TextEditingController();
  String? meterNo;
  String? beneficiaryName;
  num amount = 0;
  ValueNotifier<ElectricityProviderEnum?> network = ValueNotifier(null);
  ValueNotifier<EScheduleType?> scheduleType =
      ValueNotifier(EScheduleType.month);
  ValueNotifier<bool> schedulePayment = ValueNotifier(false);
  void setMeterNo(String? p, {bool useController = false}) {
    meterNo = p;
    if (useController) {
      phoneNumberController.text = meterNo!;
    }
    notifyListeners();
  }

  setAmount(String v) {
    amount = num.tryParse(v) ?? 0;
    notifyListeners();
  }

  ElectricityProviderEnum? selectedVariation;
  setElectricityVariation(ElectricityProviderEnum v) {
    selectedVariation = v;
    notifyListeners();
  }

  setElectricitySchedule(EScheduleType v) {
    scheduleType.value = v;
    notifyListeners();
  }

  setBeneficiaryName(String v) {
    beneficiaryName = v;
    notifyListeners();
  }

  bool get hasAmount => amount > 100;
  bool get hasMeterNo => meterNo.isNotNullNorEmpty && meterNo!.length > 10;
  bool get hasElectricityProvider => selectedVariation?.title != null;
  bool get isValidInputs => hasMeterNo && hasElectricityProvider && hasAmount;

  refresh() {
    notifyListeners();
  }

  save() {
    bills.meterNo = meterNo;
    bills.schedulePayment = schedulePayment.value;
    bills.amount = amount;
    bills.electricityProviderEnum = selectedVariation;
  }

  get() {
    meterNo = bills.meterNo;
    schedulePayment.value = bills.schedulePayment!;
    amount = bills.amount;
    selectedVariation = bills.electricityProviderEnum;
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

enum EScheduleType { week, month }
