import 'package:flutter/material.dart';
import 'package:mxe_mobile/base.vm.dart';
import 'package:mxe_mobile/core/model/res_model.dart';
import 'package:mxe_mobile/core/services/bills-repository.dart';
import 'package:mxe_mobile/core/services/web-services/beneficiary-api.dart';
import 'package:mxe_mobile/core/services/web-services/transactions-api-service.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/ui/bills/bills-beneficiaries/bills-beneficiaries.ui.dart';
import 'package:mxe_mobile/widgets/toast.dart';

class BillsBeneficiariesViewModel extends BaseViewModel {
  final bills = getIt<BillsRepository>();
  final transactionsApi = getIt<TransactionsApiService>();
  final beneficiaryApi = getIt<BeneficiaryApiService>();
  List<SingleBeneficiary> response = [
    SingleBeneficiary(
        fName: "Kemi",
        lName: "Williams",
        phone: "09011111111",
        provider: "mtn"),
    SingleBeneficiary(
        fName: "John",
        lName: "Johnson",
        phone: "09022222222",
        provider: 'airtel'),
    SingleBeneficiary(
        fName: "Alice", lName: "Smith", phone: "09033333333", provider: 'glo'),
    SingleBeneficiary(
        fName: "Micheal",
        lName: "Olivia",
        phone: "09044444444",
        provider: 'mtn'),
    SingleBeneficiary(
        fName: "Emily", lName: "James", phone: "09055555555", provider: 'glo'),
    SingleBeneficiary(
        fName: "David",
        lName: "Sophia",
        phone: "09066666666",
        provider: 'airtel')
  ];
  late ValueNotifier<List> items = ValueNotifier(List.from(response ?? []));

  SingleBeneficiary? selectedBeneficiary;
  setBeneficiary(SingleBeneficiary item) {
    selectedBeneficiary = item;
    notifyListeners();
  }

  bool _isQueryingUser = false;
  bool get isQueryingUser => _isQueryingUser;

  set isQueryingUser(bool value) {
    _isQueryingUser = value;
    notifyListeners();
  }

  searchBeneficiary(String v) {
    items.value = [];
    if (v.isNotEmpty) {
      for (SingleBeneficiary e in response ?? []) {
        if (e.fName != null &&
                e.fName!.toLowerCase().contains(v.toLowerCase()) ||
            e.lName != null &&
                e.lName!.toLowerCase().contains(v.toLowerCase()) ||
            e.phone != null &&
                e.phone!.toLowerCase().contains(v.toLowerCase())) {
          items.value.add(e);
        }
      }
    } else {
      items.value.addAll(response ?? []);
    }
  }

  getAirtimeAndDataBeneficiary() async {
    dropKeyboard();
    startLoader();

    try {
      ResModel res = await beneficiaryApi.getAirtimeAndDataBeneficiary();
      if (res.success ?? false) {
        stopLoader();
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

  deleteAirtimeAndDataBeneficiary({String? id, bool pop = true}) async {
    dropKeyboard();
    startLoader();

    try {
      ResModel res =
          await beneficiaryApi.deleteAirtimeAndDataBeneficiary(request: id);

      if (res.success ?? false) {
        await getAirtimeAndDataBeneficiary();
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
