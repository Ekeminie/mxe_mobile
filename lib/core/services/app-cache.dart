import 'dart:async';

import 'package:flutter/material.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:mxe_mobile/core/enum/fundtype-enum.dart';
import 'package:mxe_mobile/core/enum/status-enum.dart';
import 'package:mxe_mobile/core/model/airtime-and-data-beneficiary-response.dart';
import 'package:mxe_mobile/core/model/card-response.dart';
import 'package:mxe_mobile/core/model/inflow-model.dart';
import 'package:mxe_mobile/core/model/insights-model.dart';
import 'package:mxe_mobile/core/model/on-device-auth-info.dart';
import 'package:mxe_mobile/locator.dart';

import '../model/withdrawal-beneficiary-response.dart';

final appCache = getIt<AppCache>();

class AppCache extends ChangeNotifier {
  int homePageIndex = 0;
  int cryptoHomePageIndex = 0;
  final sessionStateStream = StreamController<SessionState>.broadcast();
  OnDeviceAuthInfo? cachedAuthInfo;

  ValueNotifier<InflowAndOutflowModel?> inflowAndOutflow = ValueNotifier(null);

  void resetAppCache() {
    inflowAndOutflow = ValueNotifier(null);
  }

  ValueNotifier<InsightsTimeLineEnum> insightTimeline =
      ValueNotifier(InsightsTimeLineEnum.sevenDays);
  TransferCurrency? insightCurrency;
  ValueNotifier<InsightAndStatsModel> insightModel =
      ValueNotifier(InsightAndStatsModel());

  ValueNotifier<List<WithdrawalBeneficiary>> cacheWithdrawalBeneficiaries =
      ValueNotifier([]);

  ValueNotifier<CardModel>? cardModel = ValueNotifier(CardModel());
  ValueNotifier<List<AirtimeDataBeneficiaryResponse>> airtimeDataBeneficiary =
      ValueNotifier([]);
}
