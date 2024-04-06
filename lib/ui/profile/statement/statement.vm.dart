import 'package:flutter/foundation.dart';
import 'package:mxe_mobile/base.vm.dart';
import 'package:mxe_mobile/core/model/res_model.dart';
import 'package:mxe_mobile/core/services/web-services/transactions-api-service.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/widgets/toast.dart';

class AccountStatementViewModel extends BaseViewModel {
  final transactionApi = getIt<TransactionsApiService>();
  ValueNotifier<StatementAccountEnum?> accountType = ValueNotifier(null);
  ValueNotifier<ASTimelineEnum?> timelineType = ValueNotifier(null);

  bool get haveValues =>
      accountType.value != null && timelineType.value != null;

  refresh() {
    notifyListeners();
  }

  getStatementOfAccount() async {
    dropKeyboard();
    startLoader();

    try {
      ResModel res = await transactionApi.getStatementOfAccount(
        timeLine: timelineType.value!,
      );
      if (res.success ?? false) {
        stopLoader();
        showCustomToast(
            "You will receive an email with your account statement  shortly",
            success: true);
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

enum ASTimelineEnum {
  sevenDays(title: "Last 7 days"),
  oneMonth(title: "Last 1 Month"),
  threeMonths(title: "Last 3 Month"),
  sixMonths(title: "Last 6 Months"),
  oneYear(title: "Last 1 Year"),
  twoYears(title: "Last 2 Years"),
  fiveYears(title: "Last 5 Years"),
  allTime(title: "All Time");

  final String? title;
  const ASTimelineEnum({this.title});
}

enum StatementAccountEnum {
  ngnWallet(
    title: "NGN Wallet",
    icon: "ngn",
  ),
  gbpWallet(
    title: "GBP Wallet",
    icon: "gbp",
  ),
  virtualCard(
    title: "Virtual Card",
    icon: "vc",
  ),
  allTime(
    title: "All Time",
  );

  final String? title;
  final String? icon;
  const StatementAccountEnum({this.title, this.icon});
}
