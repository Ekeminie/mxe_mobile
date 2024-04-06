import 'package:flutter/material.dart';
import 'package:mxe_mobile/base.vm.dart';
import 'package:mxe_mobile/core/model/request/request-funds-model.dart';
import 'package:mxe_mobile/core/model/res_model.dart';
import 'package:mxe_mobile/core/services/auth-repository.dart';
import 'package:mxe_mobile/core/services/transfer-repository.dart';
import 'package:mxe_mobile/core/services/web-services/transactions-api-service.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/bills/bills-beneficiaries/bills-beneficiaries.ui.dart';
import 'package:mxe_mobile/utils/debounce.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/widgets/toast.dart';
import 'package:mxe_mobile/widgets/transaction-success/transaction-success-widget.dart';

class RequestViewModel extends BaseViewModel {
  final transactionApi = getIt<TransactionsApiService>();
  String? narration;

  String? searchName;
  ValueNotifier<List<String>> queryResult = ValueNotifier([]);
  List<SingleBeneficiary> response = [
    SingleBeneficiary(
        fName: "Kemi",
        lName: "Williams",
        phone: "09011111111",
        userName: "kemiwills",
        provider: "mtn"),
    SingleBeneficiary(
        fName: "John",
        lName: "Johnson",
        phone: "09022222222",
        userName: "johnjohn",
        provider: 'airtel'),
    SingleBeneficiary(
        fName: "Alice", lName: "Smith", phone: "09033333333", provider: 'glo'),
    SingleBeneficiary(
        fName: "Micheal",
        lName: "Olivia",
        phone: "09044444444",
        userName: "michealo",
        provider: 'mtn'),
    SingleBeneficiary(
        fName: "Emily", lName: "James", phone: "09055555555", provider: 'glo'),
    SingleBeneficiary(
        fName: "David",
        lName: "Sophia",
        phone: "09066666666",
        userName: "davidsoph",
        provider: 'airtel')
  ];
  late ValueNotifier<List> items = ValueNotifier(List.from(response ?? []));

  SingleBeneficiary? selectedBeneficiary;
  String? selectedBeneficiaryUserName;

  num numAmount = 0;

  TextEditingController amountController = TextEditingController();
  setAmount(String v) {
    numAmount = num.tryParse(v) ?? 0;
    amountController.text = formatPrice(v).substring(1).replaceAll(".00", "");
    notifyListeners();
  }

  bool get hasAmount => numAmount > 50;

  final transferRepo = getIt<TransferRepository>();

  save1() {
    transferRepo.requestBeneficiary = selectedBeneficiary;
  }

  saveUser(String e) {
    transferRepo.requestBeneficiaryUserName = e;
  }

  get1() {
    selectedBeneficiary = transferRepo.requestBeneficiary;
    selectedBeneficiaryUserName = transferRepo.requestBeneficiaryUserName;
    notifyListeners();
  }

  searchBeneficiary(String v) {
    items.value = [];
    selectedBeneficiary = null;
    notifyListeners();
    if (v.isNotEmpty) {
      for (SingleBeneficiary e in response ?? []) {
        if (e.userName!.toLowerCase() == v.toLowerCase()
            // || e.lName!.toLowerCase() == v.toLowerCase() || e.phone!.toLowerCase() == v.toLowerCase()
            ) {
          selectedBeneficiary = e;
          notifyListeners();
        }
      }
    } else {
      items.value.addAll(response ?? []);
    }
    notifyListeners();
  }

  search(String q) async {
    queryResult.value = [];
    if (q.isNotEmpty) {
      searchName = q;
      debounceThis(() async {
        await getUserNames();
      });
    }
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

  setNarration(String v) {
    if (v.isNotNullNorEmpty) {
      narration = v;
    }
    notifyListeners();
  }

  requestFunds() async {
    dropKeyboard();
    startLoader();

    try {
      ResModel res = await transactionApi.requestFunds(
          request: RequestFunds(
              senderId: await getIt<AuthenticationRepository>().getUserId(),
              amount: numAmount,
              receiverMxeTag: selectedBeneficiaryUserName));
      if (res.success ?? false) {
        stopLoader();
        notifyListeners();
        navigationService.navigateToReplace(Routes.transactionSuccessPageRoute,
            argument: SuccessData(
                amount: numAmount.toString(),
                title: "Your Funds Conversion was Successful",
                transType: "Conversion",
                recipient: "",
                subTitle:
                    "You have successfully requested Funds from $selectedBeneficiaryUserName"));
        return;
      } else {
        stopLoader();
        showCustomToast(res.message!);
      }
    } catch (e) {
      debugPrint(e.toString());
      stopLoader();
      showCustomToast(genericErrorMessage);
    }
  }
}
