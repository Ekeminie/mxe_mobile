import 'package:flutter/cupertino.dart';
import 'package:mxe_mobile/base.vm.dart';
import 'package:mxe_mobile/core/enum/banks.dart';
import 'package:mxe_mobile/core/enum/fundtype-enum.dart';
import 'package:mxe_mobile/core/services/transfer-repository.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';

class ConvertFundsViewModel extends BaseViewModel {
  ValueNotifier<TransferCurrency> currency =
      ValueNotifier(TransferCurrency.ngn);
  ValueNotifier<bool> saveBeneficiary = ValueNotifier(false);
  ValueNotifier<BankList?> banksList = ValueNotifier(null);

  ValueNotifier<TransferCurrency> fromCurrency =
      ValueNotifier(TransferCurrency.ngn);
  ValueNotifier<TransferCurrency> toCurrency =
      ValueNotifier(TransferCurrency.usd);

  num numAmount = 0;
  String? accountNumber;
  String? sortCode;
  String? swiftCode;
  String? receiverName;

  TextEditingController amountController = TextEditingController();
  setAmount(String v) {
    numAmount = num.tryParse(v) ?? 0;
    amountController.text = formatPrice(v).substring(1).replaceAll(".00", "");
    notifyListeners();
  }

  bool get hasBank => banksList.value != null;
  bool get hasAccountNumber =>
      accountNumber.isNotNullNorEmpty && accountNumber!.length > 3;
  bool get hasSortCode => sortCode.isNotNullNorEmpty && sortCode!.length > 3;
  bool get hasSwiftCode => swiftCode.isNotNullNorEmpty && swiftCode!.length > 3;
  bool get hasReceiversName =>
      receiverName.isNotNullNorEmpty && receiverName!.length > 3;
  bool get hasTag => tag.isNotNullNorEmpty && tag!.length > 3;
  bool get hasRef => reference.isNotNullNorEmpty;
  bool get hasAmount => numAmount > 50;
  bool get hasBeneficiaryName => beneficiaryName.isNotNullNorEmpty;
  bool get hasValue => (saveBeneficiary.value)
      ? hasTag && hasRef && hasBeneficiaryName
      : hasTag && hasRef;

  bool get hasTransferDetails => (saveBeneficiary.value)
      ? hasBank &&
          hasAccountNumber &&
          hasSortCode &&
          hasSwiftCode &&
          hasReceiversName &&
          hasBeneficiaryName
      : hasBank &&
          hasAccountNumber &&
          hasSortCode &&
          hasSwiftCode &&
          hasReceiversName;

  String? tag;
  String? reference;
  String? beneficiaryName;
  setToCurrency(TransferCurrency v) {
    toCurrency.value = v;
    notifyListeners();
  }

  setFromCurrency(TransferCurrency v) {
    fromCurrency.value = v;
    notifyListeners();
  }

  setSaveBeneficiary(bool v) {
    saveBeneficiary.value = v;
    notifyListeners();
  }

  setRef(String v) {
    reference = v;
    notifyListeners();
  }

  setBeneficiaryName(String v) {
    beneficiaryName = v;
    notifyListeners();
  }

  final transferRepo = getIt<TransferRepository>();

  save1() {
    transferRepo.toCurrency = toCurrency.value;
    transferRepo.fromCurrency = fromCurrency.value;
    transferRepo.amount = numAmount;
  }

  get1() {
    toCurrency.value != transferRepo.toCurrency;
    fromCurrency.value != transferRepo.fromCurrency;
    numAmount = transferRepo.amount;
    notifyListeners();
  }

  setAccNo(String v) {
    accountNumber = v;
    notifyListeners();
  }

  setSortCode(String v) {
    sortCode = v;
    notifyListeners();
  }

  setSwiftCode(String v) {
    swiftCode = v;
    notifyListeners();
  }

  setReceiverName(String v) {
    receiverName = v;
    print(
        "$hasBank $hasAccountNumber $hasSortCode $hasSwiftCode $hasReceiversName");
    notifyListeners();
  }
}
