import 'package:flutter/cupertino.dart';
import 'package:mxe_mobile/base.vm.dart';
import 'package:mxe_mobile/core/enum/bills-enum.dart';
import 'package:mxe_mobile/core/model/request/bills-request.dart';
import 'package:mxe_mobile/core/model/res_model.dart';
import 'package:mxe_mobile/core/services/auth-repository.dart';
import 'package:mxe_mobile/core/services/bills-repository.dart';
import 'package:mxe_mobile/core/services/web-services/beneficiary-api.dart';
import 'package:mxe_mobile/core/services/web-services/transactions-api-service.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/widgets/toast.dart';
import 'package:mxe_mobile/widgets/transaction-success/transaction-success-widget.dart';

class BuyAirtimeViewModel extends BaseViewModel {
  num currentBalance = 1000;
  final bills = getIt<BillsRepository>();
  final transactionsApi = getIt<TransactionsApiService>();
  final beneficiaryApi = getIt<BeneficiaryApiService>();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController beneficiaryNameController =
      TextEditingController();
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

  setBeneficiaryName(String v) {
    beneficiaryName = v;
    notifyListeners();
  }

  bool get hasPhone => phone.isNotNullNorEmpty && phone!.length > 10;
  bool get hasNetwork => network.value.title != null;
  bool get hasAmount => amount != 0;
  bool get isValidInputs => (saveBeneficiary.value)
      ? hasPhone && hasNetwork && hasAmount && beneficiaryName.isNotNullNorEmpty
      : hasPhone && hasNetwork && hasAmount;

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

  saveAirtimeBeneficiary() async {
    dropKeyboard();
    startLoader();

    try {
      ResModel res = await beneficiaryApi.saveAirtimeAndDataBeneficiary(
          request: AirtimeAndDataBeneficiary(
        userId: await getIt<AuthenticationRepository>().getUserId(),
        name: beneficiaryName,
        provider: network.value.title,
        phoneNumber: phone,
      ));
      if (res.success ?? false) {
        stopLoader();
        showCustomToast("Beneficiary Added", success: true);
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

  buyAirtime() async {
    dropKeyboard();
    startLoader();
    if (saveBeneficiary.value) {
      await saveAirtimeBeneficiary();
    }
    try {
      ResModel res = await beneficiaryApi.saveAirtimeAndDataBeneficiary(
          request: AirtimeAndDataBeneficiary(
        userId: await getIt<AuthenticationRepository>().getUserId(),
        name: beneficiaryName,
        provider: network.value.title,
        phoneNumber: phone,
      ));
      if (res.success ?? false) {
        stopLoader();
        navigationService.navigateToReplace(Routes.transactionSuccessPageRoute,
            argument: SuccessData(
                amount: amount.toString(),
                title: "Your Airtime Purchase was Successful",
                transType: "Airtime Top-up",
                recipient: phone.toString(),
                subTitle:
                    "You have successfully purchased  NGN $amount airtime on $phone"));

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
