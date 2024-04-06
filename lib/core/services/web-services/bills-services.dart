import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mxe_mobile/constant/api-routes.dart';
import 'package:mxe_mobile/constant/constants.dart';
import 'package:mxe_mobile/core/enum/fundtype-enum.dart';
import 'package:mxe_mobile/core/enum/status-enum.dart';
import 'package:mxe_mobile/core/model/inflow-model.dart';
import 'package:mxe_mobile/core/model/insights-model.dart';
import 'package:mxe_mobile/core/model/request/bills-request.dart';
import 'package:mxe_mobile/core/model/request/request-funds-model.dart';
import 'package:mxe_mobile/core/model/res_model.dart';
import 'package:mxe_mobile/core/services/app-cache.dart';
import 'package:mxe_mobile/core/services/auth-repository.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/ui/profile/statement/statement.vm.dart';
import 'package:mxe_mobile/utils/network_exception.dart';
import 'package:mxe_mobile/utils/result-model-isolate.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';

import '../storage-service.dart';
import '../user.service.dart';
import 'base-api.dart';

class BillsApiService {
  final AuthenticationRepository authenticationRepository;
  BillsApiService({required this.authenticationRepository});
  // final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  StorageService storageService = getIt<StorageService>();
  UserService userService = getIt<UserService>();
  AppCache cache = getIt<AppCache>();

  Future addMxeTag({required String? tag}) async {
    String? userId = await storageService.readItem(key: userID);
    try {
      Response response = await connect().post(ApiRoutes.addMxeTag,
          data: {"userId": userId, "providedMXETag": tag});
      debugPrint(response.data);
      final parser = ResModelParser(response.data);
      return await parser.parseInBackground();
      // return resModelFromJson(response.data);
    } on DioError catch (e) {
      return resModelFromJson(
        e.response?.data ?? getErrorFromDio(e),
      );
    } catch (e) {
      return ResModel(message: e.toString(), statusCode: 400);
    }
  }

  Future getNotifications(
      {bool? isRead,
      bool? status,
      num pageSize = 20,
      num pageNumber = 1}) async {
    String? userId = await storageService.readItem(key: userID);

    Map<String, dynamic> queryParams = {
      "isRead": isRead,
      "status": status,
      "userId": userId,
      "pageSize": pageSize,
      "pageNumber": pageNumber
    };

    try {
      Response response = await connect()
          .get(ApiRoutes.getNotifications, queryParameters: queryParams);
      debugPrint(response.data);
      final parser = ResModelParser(response.data);
      return await parser.parseInBackground();
      // return resModelFromJson(response.data);
    } on DioError catch (e) {
      return resModelFromJson(
        e.response?.data ?? getErrorFromDio(e),
      );
    } catch (e) {
      return ResModel(message: e.toString(), statusCode: 400);
    }
  }

  Future getInflowAndOutflow(
      {TransferCurrency currency = TransferCurrency.ngn,
      InsightsTimeLineEnum timeLine = InsightsTimeLineEnum.allTime}) async {
    String? userId = await storageService.readItem(key: userID);

    Map<String, dynamic> queryParams = {
      "timeframe": timeLine.api,
      "Currency": currency.code,
      "userId": userId,
    };

    try {
      Response response = await connect()
          .get(ApiRoutes.getInflowAndOutFlow, queryParameters: queryParams);
      debugPrint(response.data);
      getIt<AppCache>().inflowAndOutflow.value =
          InflowAndOutflowModel.fromJson(resModelFromJson(response.data).data);
      final parser = ResModelParser(response.data);
      return await parser.parseInBackground();
      // return resModelFromJson(response.data);
    } on DioError catch (e) {
      return resModelFromJson(
        e.response?.data ?? getErrorFromDio(e),
      );
    } catch (e) {
      return ResModel(message: e.toString(), statusCode: 400);
    }
  }

  Future getUserStatisticsInsights(
      {TransferCurrency currency = TransferCurrency.ngn,
      InsightsTimeLineEnum timeLine = InsightsTimeLineEnum.allTime}) async {
    String? userId = await storageService.readItem(key: userID);

    Map<String, dynamic> queryParams = {
      "timeframe": timeLine.api,
      "Currency": currency.code,
      "userId": userId,
    };

    try {
      Response response = await connect().get(
          ApiRoutes.getUserStatisticsAndInsights,
          queryParameters: queryParams);
      appCache.insightModel.value =
          InsightAndStatsModel.fromJson(resModelFromJson(response.data).data);
      debugPrint(response.data);
      final parser = ResModelParser(response.data);
      return await parser.parseInBackground();
      // return resModelFromJson(response.data);
    } on DioError catch (e) {
      return resModelFromJson(
        e.response?.data ?? getErrorFromDio(e),
      );
    } catch (e) {
      return ResModel(message: e.toString(), statusCode: 400);
    }
  }

  Future getStatementOfAccount(
      {ASTimelineEnum timeLine = ASTimelineEnum.allTime}) async {
    String? userId = await storageService.readItem(key: userID);

    Map<String, dynamic> queryParams = {
      "Timeline": timeLine.title?.lowerCaseAndTrimSpaces
    };

    try {
      Response response = await connect().get(
          ApiRoutes.getUserTransactions(userId ?? ""),
          queryParameters: queryParams);
      debugPrint(response.data);

      final parser = ResModelParser(response.data);
      return await parser.parseInBackground();
      // return resModelFromJson(response.data);
    } on DioError catch (e) {
      return resModelFromJson(
        e.response?.data ?? getErrorFromDio(e),
      );
    } catch (e) {
      return ResModel(message: e.toString(), statusCode: 400);
    }
  }

  Future getTransactionReceipt({required String id}) async {
    try {
      Response response =
          await connect().get(ApiRoutes.getTransactionReceipt(id));
      debugPrint(response.data);
      final parser = ResModelParser(response.data);
      return await parser.parseInBackground();
      // return resModelFromJson(response.data);
    } on DioError catch (e) {
      return resModelFromJson(
        e.response?.data ?? getErrorFromDio(e),
      );
    } catch (e) {
      return ResModel(message: e.toString(), statusCode: 400);
    }
  }

  Future getTransactionSoa(
      {InsightsTimeLineEnum timeLine = InsightsTimeLineEnum.allTime}) async {
    Map<String, dynamic> queryParams = {"Timeline": timeLine.api};
    try {
      Response response = await connect().get(
          ApiRoutes.getTransactionSoa(
              await authenticationRepository.getUserId() ?? ""),
          queryParameters: queryParams);
      debugPrint(response.data);
      final parser = ResModelParser(response.data);
      return await parser.parseInBackground();
      // return resModelFromJson(response.data);
    } on DioError catch (e) {
      return resModelFromJson(
        e.response?.data ?? getErrorFromDio(e),
      );
    } catch (e) {
      return ResModel(message: e.toString(), statusCode: 400);
    }
  }

  Future searchUserName({required String? name}) async {
    try {
      Map<String, dynamic> queryParams = {
        "searchTerm": name,
      };
      Response response = await connect()
          .get(ApiRoutes.searchUserName, queryParameters: queryParams);
      debugPrint(response.data);
      final parser = ResModelParser(response.data);
      return await parser.parseInBackground();
      // return resModelFromJson(response.data);
    } on DioError catch (e) {
      return resModelFromJson(
        e.response?.data ?? getErrorFromDio(e),
      );
    } catch (e) {
      return ResModel(message: e.toString(), statusCode: 400);
    }
  }

  Future requestFunds({required RequestFunds? request}) async {
    try {
      Response response =
          await connect().post(ApiRoutes.requestFunds, data: request?.toMap());
      debugPrint(response.data);
      final parser = ResModelParser(response.data);
      return await parser.parseInBackground();
      // return resModelFromJson(response.data);
    } on DioError catch (e) {
      return resModelFromJson(
        e.response?.data ?? getErrorFromDio(e),
      );
    } catch (e) {
      return ResModel(message: e.toString(), statusCode: 400);
    }
  }

  Future buyAirtime({AirtimeRequest? request}) async {
    try {
      Response response = await connect().get(ApiRoutes.requestFundsHistory(
          await authenticationRepository.getUserId() ?? ""));
      debugPrint(response.data);
      final parser = ResModelParser(response.data);
      return await parser.parseInBackground();
      // return resModelFromJson(response.data);
    } on DioError catch (e) {
      return resModelFromJson(
        e.response?.data ?? getErrorFromDio(e),
      );
    } catch (e) {
      return ResModel(message: e.toString(), statusCode: 400);
    }
  }
}
