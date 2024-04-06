import 'package:flutter/cupertino.dart';
import 'package:mxe_mobile/base.vm.dart';
import 'package:mxe_mobile/core/enum/fundtype-enum.dart';
import 'package:mxe_mobile/core/model/banks-response.dart';
import 'package:mxe_mobile/core/model/request/beneficiary.dart';
import 'package:mxe_mobile/core/model/request/mxe-tag-withdrawals.dart';
import 'package:mxe_mobile/core/model/request/transfer-request.dart';
import 'package:mxe_mobile/core/model/res_model.dart';
import 'package:mxe_mobile/core/model/withdrawal-beneficiary-response.dart';
import 'package:mxe_mobile/core/services/auth-repository.dart';
import 'package:mxe_mobile/core/services/transfer-repository.dart';
import 'package:mxe_mobile/core/services/web-services/beneficiary-api.dart';
import 'package:mxe_mobile/core/services/web-services/transactions-api-service.dart';
import 'package:mxe_mobile/core/services/web-services/transfer-api-service.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/utils/debounce.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/widgets/toast.dart';
import 'package:mxe_mobile/widgets/transaction-success/transaction-success-widget.dart';

class SendFundsViewModel extends BaseViewModel {
  final beneficiaryNameController = TextEditingController();
  final tagController = TextEditingController();
  final accountNo = TextEditingController();
  final transferApi = getIt<TransferApiService>();
  final beneficiaryApi = getIt<BeneficiaryApiService>();
  final authenticationRepo = getIt<AuthenticationRepository>();
  final transactionApi = getIt<TransactionsApiService>();

  ValueNotifier<List<String>> queryResult = ValueNotifier([]);

  setTag(String v) {
    userTag = v;
    tagController.text = userTag ?? "";
    notifyListeners();
  }

  ValueNotifier<TransferCurrency> currency =
      ValueNotifier(TransferCurrency.ngn);
  ValueNotifier<bool> saveBeneficiary_ = ValueNotifier(false);
  ValueNotifier<String?> localBeneficiaryName = ValueNotifier(null);
  ValueNotifier<List<BankModel>?> banksList = ValueNotifier([]);
  ValueNotifier<BankModel?> selectedBank = ValueNotifier(null);

  ValueNotifier<List<WithdrawalBeneficiary>> withdrawalBeneficiaries =
      ValueNotifier([]);

  num numAmount = 0;
  String? accountNumber;
  String? sortCode;
  String? swiftCode;
  String? receiverName;
  String? searchName;
  String? userTag;

  TextEditingController amountController = TextEditingController();
  setAmount(String v) {
    numAmount = num.tryParse(v) ?? 0;
    amountController.text = formatPrice(v).substring(1).replaceAll(".00", "");
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
  bool get hasTag => queryResult.value.length != 0;
  bool get hasRef => reference.isNotNullNorEmpty;
  bool get hasAmount => numAmount > 50;
  bool get hasBeneficiaryName => beneficiaryName.isNotNullNorEmpty;
  bool get hasValue => (saveBeneficiary_.value)
      ? hasTag && hasRef && hasBeneficiaryName
      : hasTag && hasRef;

  bool get hasTransferDetails => (isLocalBankTransfer)
      ? hasBank && hasAccountNumber && isResolved
      : hasBank &&
          hasAccountNumber &&
          hasSortCode &&
          hasSwiftCode &&
          hasReceiversName;

  String? reference;
  String? beneficiaryName;

  setBank(BankModel v) {
    selectedBank.value = v;
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

  final transferRepo = getIt<TransferRepository>();

  save1() {
    transferRepo.sendCurrency = currency.value;
    transferRepo.amount = numAmount;
  }

  get1() {
    currency.value = transferRepo.sendCurrency!;
    numAmount = transferRepo.amount;
    getBanks();
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
    debugPrint(
        "$hasBank $hasAccountNumber $hasSortCode $hasSwiftCode $hasReceiversName");
    notifyListeners();
  }

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

  transferToBank() async {
    dropKeyboard();
    startLoader();
    try {
      ResModel res = await transferApi.withdrawMoneyRequest(
          request: SendMoneyRequest(
              amount: transferRepo.amount,
              bankName: selectedBank.value?.bankName,
              userId: getIt<AuthenticationRepository>().userId,
              accountNumber: accountNumber,
              bankCode: selectedBank.value?.bankCode,
              transactionPin: userService.transactionPin));
      if (res.success ?? false) {
        if (saveBeneficiary_.value) {
          await saveBeneficiary();
        }
        stopLoader();
        navigationService.navigateToReplace(Routes.transactionSuccessPageRoute,
            argument: SuccessData(
                amount: "",
                title: "Your Funds Transfer was Successful",
                transType: "Transfer",
                recipient: "",
                subTitle:
                    "You have successfully transferred  ${currency.value.code} ${formatPrice(numAmount.toString()).substring(1)} to ${localBeneficiaryName.value} ($accountNumber) "));
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

  transferToMXeUser() async {
    dropKeyboard();
    startLoader();
    try {
      ResModel res = await transferApi.withdrawMoneyWithMxeTag(
          request: MxeTagWithdrawalRequest(
              amount: transferRepo.amount,
              mxetag: userTag,
              userId: getIt<AuthenticationRepository>().userId,
              transactionPin: userService.transactionPin));
      if (res.success ?? false) {
        if (saveBeneficiary_.value) {
          await saveBeneficiary();
        }
        stopLoader();

        navigationService.navigateToReplace(Routes.transactionSuccessPageRoute,
            argument: SuccessData(
                amount: "",
                title: "Your Funds Transfer was Successful",
                transType: "Transfer",
                recipient: "",
                subTitle:
                    "You have successfully transferred  ${currency.value.code} ${formatPrice(numAmount.toString()).substring(1)} to ($userTag) "));
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

  saveBeneficiary() async {
    dropKeyboard();
    startLoader();

    try {
      ResModel res = await beneficiaryApi.addWithdrawalBeneficiary(
          request: WithdrawalBeneficiaryReq(
              accountNumber: accountNumber,
              bankCode: selectedBank.value?.bankCode,
              userId: authenticationRepo.userId,
              bankName: selectedBank.value?.bankName,
              name: localBeneficiaryName.value));

      if (res.success ?? false) {
        stopLoader();
        return;
      } else {
        //update viewState
        stopLoader();
        //show error message if any
        showCustomToast(res.message ?? "");
      }
    } catch (e) {
      debugPrint(e.toString());
      stopLoader();
      //show error message if any
      showCustomToast(genericErrorMessage);
    }
  }

  getBeneficiaries() async {
    dropKeyboard();
    startLoader();

    try {
      ResModel res = await beneficiaryApi.getWithdrawalBeneficiary();
      if (res.success ?? false) {
        withdrawalBeneficiaries.value =
            appCache.cacheWithdrawalBeneficiaries.value;
        stopLoader();
        notifyListeners();
        return;
      } else {
        //update viewState
        stopLoader();
        //show error message if any
        showCustomToast(res.message ?? "");
      }
    } catch (e) {
      debugPrint(e.toString());
      stopLoader();
      //show error message if any
      showCustomToast(genericErrorMessage);
    }
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

  bool _isQueryingUser = false;
  bool get isQueryingUser => _isQueryingUser;

  set isQueryingUser(bool value) {
    _isQueryingUser = value;
    notifyListeners();
  }

  searchBeneficiary(String v) {
    withdrawalBeneficiaries.value = [];

    if (v.isNotEmpty) {
      for (WithdrawalBeneficiary e
          in appCache.cacheWithdrawalBeneficiaries.value ?? []) {
        if (e.bankName != null &&
                e.bankName!.toLowerCase().contains(v.toLowerCase()) ||
            e.name != null && e.name!.toLowerCase().contains(v.toLowerCase()) ||
            e.accountNumber != null &&
                e.accountNumber!
                    .toString()
                    .toLowerCase()
                    .contains(v.toLowerCase())) {
          withdrawalBeneficiaries.value.add(e);
        }
      }
    } else {
      withdrawalBeneficiaries.value
          .addAll(appCache.cacheWithdrawalBeneficiaries.value);
    }
  }

  void setBeneficiary(WithdrawalBeneficiary result) {
    selectedBank.value = banksList.value
        ?.firstWhere((element) => element.bankCode == result.bankCode);
    localBeneficiaryName.value = result.name;
    accountNumber = result.accountNumber.toString();
    accountNo.text = accountNumber ?? "";
    notifyListeners();
  }

  search(String q) async {
    isLoading = true;
    queryResult.value = [];
    if (q.isNotEmpty) {
      userTag = q;
      searchName = q;
      debounceThis(() async {
        await getUserNames();
      });
    }
    isLoading = false;
  }

  getUserNames() async {
    dropKeyboard();
    isLoading = true;

    try {
      ResModel res = await transactionApi.searchUserName(name: searchName);
      if (res.success ?? false) {
        res.data.forEach((v) {
          queryResult.value.add(v.toString());
        });
        isLoading = false;
        notifyListeners();
        // stopLoader();
        return;
      } else {
        isLoading = false;
        showCustomToast(res.message!);
      }
    } catch (e) {
      debugPrint(e.toString());
      isLoading = false;
      showCustomToast(genericErrorMessage);
    }
  }

  saveMXEBeneficiary() async {
    dropKeyboard();
    startLoader();

    try {
      ResModel res = await beneficiaryApi.addWithdrawalBeneficiary(
          request: WithdrawalBeneficiaryReq(
              accountNumber: accountNumber,
              bankCode: selectedBank.value?.bankCode,
              userId: authenticationRepo.userId,
              bankName: selectedBank.value?.bankName,
              name: localBeneficiaryName.value));

      if (res.success ?? false) {
        stopLoader();
        return;
      } else {
        //update viewState
        stopLoader();
        //show error message if any
        showCustomToast(res.message ?? "");
      }
    } catch (e) {
      debugPrint(e.toString());
      stopLoader();
      //show error message if any
      showCustomToast(genericErrorMessage);
    }
  }

  deleteWithdrawalBeneficiary({String? id, bool pop = true}) async {
    dropKeyboard();
    startLoader();

    try {
      ResModel res =
          await beneficiaryApi.deleteWithdrawalBeneficiaryById(id: id);

      if (res.success ?? false) {
        await getBeneficiaries();
        stopLoader();
        if (pop) {
          navigationService.goBack();
        }
        showCustomToast("Beneficiary Deleted Successfully", success: true);
        return;
      } else {
        //update viewState
        stopLoader();
        //show error message if any
        showCustomToast(res.message ?? "");
      }
    } catch (e) {
      debugPrint(e.toString());
      stopLoader();
      //show error message if any
      showCustomToast(genericErrorMessage);
    }
  }
}
