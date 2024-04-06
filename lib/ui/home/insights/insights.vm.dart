import 'package:flutter/foundation.dart';
import 'package:mxe_mobile/base.vm.dart';
import 'package:mxe_mobile/core/enum/fundtype-enum.dart';
import 'package:mxe_mobile/core/enum/status-enum.dart';
import 'package:mxe_mobile/core/model/res_model.dart';
import 'package:mxe_mobile/core/services/app-cache.dart';
import 'package:mxe_mobile/core/services/web-services/transactions-api-service.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/widgets/toast.dart';

class InsightsViewModel extends BaseViewModel {
  final userApi = getIt<TransactionsApiService>();
  getInsights(TransferCurrency currency) async {
    appCache.insightCurrency = currency;
    dropKeyboard();
    startLoader();

    try {
      ResModel res = await userApi.getUserStatisticsInsights(
          timeLine: appCache.insightTimeline.value, currency: currency);
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

  sortTimeFrame(InsightsTimeLineEnum c) async {
    appCache.insightTimeline.value = c;
    await getInsights(appCache.insightCurrency!);
  }
}
