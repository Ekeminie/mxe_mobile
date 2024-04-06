import 'package:flutter/material.dart';
import 'package:mxe_mobile/base.vm.dart';
import 'package:mxe_mobile/core/model/airtime-and-data-beneficiary-response.dart';
import 'package:mxe_mobile/core/model/request/beneficiary.dart';
import 'package:mxe_mobile/core/model/request/bills-request.dart';
import 'package:mxe_mobile/core/model/res_model.dart';
import 'package:mxe_mobile/core/model/withdrawal-beneficiary-response.dart';
import 'package:mxe_mobile/core/services/auth-repository.dart';
import 'package:mxe_mobile/core/services/web-services/beneficiary-api.dart';
import 'package:mxe_mobile/core/services/web-services/transactions-api-service.dart';
import 'package:mxe_mobile/core/services/web-services/transfer-api-service.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/widgets/toast.dart';

class BeneficiariesViewModel extends BaseViewModel {
  WithdrawalBeneficiary? beneficiaryItem;
  AirtimeDataBeneficiaryResponse? airtimeDataBeneficiaryResponse;
  final beneficiaryNameController = TextEditingController();
  final tagController = TextEditingController();
  final accountNo = TextEditingController();
  final transferApi = getIt<TransferApiService>();
  final beneficiaryApi = getIt<BeneficiaryApiService>();
  final authenticationRepo = getIt<AuthenticationRepository>();
  final transactionApi = getIt<TransactionsApiService>();

  final accountNumberController = TextEditingController();
  final accountNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  init(WithdrawalBeneficiary beneficiary) {
    beneficiaryItem = beneficiary;
    phoneNumberController.text = beneficiary.accountNumber.toString();
    accountNameController.text = beneficiary.name.toString();
  }

  initAirtimeAndDataBeneficiary(AirtimeDataBeneficiaryResponse beneficiary) {
    airtimeDataBeneficiaryResponse = beneficiary;
    phoneNumberController.text = beneficiary.phoneNumber.toString();
    accountNameController.text = beneficiary.name.toString();
  }

  saveWithdrawalBeneficiary({bool pop = true}) async {
    dropKeyboard();
    startLoader();

    try {
      ResModel res = await beneficiaryApi.addWithdrawalBeneficiary(
          request: WithdrawalBeneficiaryReq(
              accountNumber: beneficiaryItem?.accountNumber.toString(),
              bankCode: beneficiaryItem?.bankCode,
              userId: authenticationRepo.userId,
              bankName: beneficiaryItem?.bankName,
              name: beneficiaryItem?.name));

      if (res.success ?? false) {
        await getWithdrawalBeneficiaries();
        stopLoader();
        if (pop) {
          navigationService.goBack();
        }
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

  saveAirtimeAndDataBeneficiary({bool pop = true}) async {
    dropKeyboard();
    startLoader();

    try {
      ResModel res = await beneficiaryApi.saveAirtimeAndDataBeneficiary(
          request: AirtimeAndDataBeneficiary(
              phoneNumber:
                  airtimeDataBeneficiaryResponse?.phoneNumber.toString(),
              provider: airtimeDataBeneficiaryResponse?.provider,
              userId: authenticationRepo.userId,
              name: airtimeDataBeneficiaryResponse?.name));

      if (res.success ?? false) {
        await getAirtimeAndDataBeneficiary();
        stopLoader();
        if (pop) {
          navigationService.goBack();
        }
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
        await getWithdrawalBeneficiaries();
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

  getWithdrawalBeneficiaries() async {
    dropKeyboard();
    startLoader();

    try {
      ResModel res = await beneficiaryApi.getWithdrawalBeneficiary();
      if (res.success ?? false) {
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
}
