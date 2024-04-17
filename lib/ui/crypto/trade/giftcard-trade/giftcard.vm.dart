import 'package:flutter/material.dart';
import 'package:mxe_mobile/base.vm.dart';
import 'package:mxe_mobile/core/enum/fundtype-enum.dart';
import 'package:mxe_mobile/core/model/banks-response.dart';
import 'package:mxe_mobile/core/model/res_model.dart';
import 'package:mxe_mobile/core/services/transfer-repository.dart';
import 'package:mxe_mobile/core/services/web-services/transfer-api-service.dart';
import 'package:mxe_mobile/core/services/web-services/user-api-service.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/widgets/toast.dart';

class GiftCardViewModel extends BaseViewModel {
  final accountNo = TextEditingController();
  final beneficiaryNameController = TextEditingController();
  final transferRepo = getIt<TransferRepository>();
  final transferApi = getIt<TransferApiService>();

  String? accountNumber;
  String? sortCode;
  String? swiftCode;
  String? receiverName;
  String? searchName;
  String? userTag;

  ValueNotifier<bool> saveBeneficiary_ = ValueNotifier(false);
  ValueNotifier<String?> localBeneficiaryName = ValueNotifier(null);
  ValueNotifier<List<BankModel>?> banksList = ValueNotifier([]);
  ValueNotifier<BankModel?> selectedBank = ValueNotifier(null);

  num? numAmount;
  String? cardNo;

  setCardNo(String v) {
    cardNo = v;
    notifyListeners();
  }

  setAmount(String v) {
    numAmount = num.tryParse(v) ?? 0;
    amountController.text = formatPrice(v).substring(1).replaceAll(".00", "");
    notifyListeners();
  }

  ValueNotifier<GiftCardCurrencyEnum> currency =
      ValueNotifier(GiftCardCurrencyEnum.usd);

  ValueNotifier<bool> show = ValueNotifier(true);
  final userApi = getIt<UserApiService>();

  TextEditingController amountController = TextEditingController();
  TextEditingController cardNoController = TextEditingController();

  bool get hasAmount => numAmount != null && numAmount != 0;
  bool get hasCardNo => cardNo.isNotNullNorEmpty;
  bool get hasValidInputs => hasAmount && hasCardNo;

  get1() {
    currency.value = transferRepo.giftCardCurrency!;
    numAmount = transferRepo.amount;
    getBanks();
    notifyListeners();
  }

  String? reference;
  String? beneficiaryName;
  setBank(BankModel v) {
    selectedBank.value = v;
    notifyListeners();
  }

  getAccNo(String? v) async {
    accountNumber = v!;
    if (accountNumber?.length == 10 && selectedBank.value?.bankName != null) {
      await resoleAccount();
    } else {
      localBeneficiaryName.value = "";
      notifyListeners();
    }
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
    notifyListeners();
  }

  setSaveBeneficiary(bool v) {
    saveBeneficiary_.value = v;
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

  bool get isLocalBankTransfer =>
      transferRepo.sendCurrency == TransferCurrency.ngn;
  bool get hasBank => selectedBank.value != null;
  bool get hasAccountNumber =>
      accountNumber.isNotNullNorEmpty && accountNumber!.length > 3;
  bool get hasSortCode => sortCode.isNotNullNorEmpty && sortCode!.length > 3;
  bool get hasSwiftCode => swiftCode.isNotNullNorEmpty && swiftCode!.length > 3;
  bool get hasReceiversName =>
      receiverName.isNotNullNorEmpty && receiverName!.length > 3;

  bool get isResolved =>
      localBeneficiaryName.value.isNotNullNorEmpty &&
      localBeneficiaryName.value!.length > 3;
  bool get hasRef => reference.isNotNullNorEmpty;
  bool get hasBeneficiaryName => beneficiaryName.isNotNullNorEmpty;
  bool get hasValue =>
      (saveBeneficiary_.value) ? hasRef && hasBeneficiaryName : hasRef;

  bool get hasTransferDetails => (isLocalBankTransfer)
      ? hasBank && hasAccountNumber && isResolved
      : hasBank &&
          hasAccountNumber &&
          hasSortCode &&
          hasSwiftCode &&
          hasReceiversName;

  getBanks() async {
    dropKeyboard();
    startLoader();

    try {
      ResModel res = await transferApi.getBanks();
      if (res.success ?? false) {
        stopLoader();
        res.data.forEach((e) {
          banksList.value?.add(BankModel.fromJson(e));
        });
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

  resoleAccount() async {
    dropKeyboard();
    startLoader();

    try {
      ResModel res = await transferApi.resolveAccount(
          accountNo: accountNumber, bankCode: selectedBank.value?.bankCode);
      if (res.success ?? false) {
        stopLoader();
        localBeneficiaryName.value = res.data['account_name'];
        beneficiaryNameController.text = res.data['account_name'];
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
