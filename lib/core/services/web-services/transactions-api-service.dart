import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mxe_mobile/constant/api-routes.dart';
import 'package:mxe_mobile/constant/constants.dart';
import 'package:mxe_mobile/core/enum/fundtype-enum.dart';
import 'package:mxe_mobile/core/enum/status-enum.dart';
import 'package:mxe_mobile/core/model/card-response.dart';
import 'package:mxe_mobile/core/model/inflow-model.dart';
import 'package:mxe_mobile/core/model/insights-model.dart';
import 'package:mxe_mobile/core/model/request/card-request.dart';
import 'package:mxe_mobile/core/model/request/request-funds-model.dart';
import 'package:mxe_mobile/core/model/res_model.dart';
import 'package:mxe_mobile/core/model/user-response.dart';
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

class TransactionsApiService {
  final AuthenticationRepository authenticationRepository;
  TransactionsApiService({required this.authenticationRepository});
  // final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  StorageService storageService = getIt<StorageService>();
  UserService userService = getIt<UserService>();
  AppCache cache = getIt<AppCache>();

  storeUser(response) async {
    try {
      debugPrint("store user");
      GetUserResponse res = userResModelFromJson(response.data);
      if (!res.success!) return;
      storageService.storeItem(
          key: currentUser, value: jsonEncode(res.data?.toJson()));
      userService.getLocalUser(user: res.data);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future getUser() async {
    debugPrint("getUser");
    try {
      Response response = await connect().get(
          ApiRoutes.getUser(await authenticationRepository.getUserId() ?? ""));
      debugPrint(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        await storeUser(response);
      }
      userService.getLocalUser(user: userResModelFromJson(response.data).data);

      return userResModelFromJson(response.data);
    } on DioError catch (e) {
      return userResModelFromJson(e.response?.data ?? getErrorFromDio(e));
    } catch (e) {
      return GetUserResponse(message: e.toString());
    }
  }

  Future updateUser({required Map? user}) async {
    String? userId = await storageService.readItem(key: userID);
    try {
      Response response =
          await connect().patch(ApiRoutes.updateUser(userId), data: user);
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

  Future addPasswordAfterSignUp({required String? password}) async {
    String? userId = await storageService.readItem(key: userID);
    try {
      Response response = await connect().post(ApiRoutes.addPasswordAfterLogin,
          data: {"userid": userId, "newPassword": password});
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

  Future getMXEUserNameSuggestions({required String? name}) async {
    try {
      Response response = await connect().get(ApiRoutes.generateRandomMxeTags,
          queryParameters: {"count": 7, "firstname": name});
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

  Future requestFundsHistory() async {
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

  Future createCard({CreateCardReq? request}) async {
    try {
      Response response =
          await connect().post(ApiRoutes.createCard, data: request?.toJson());
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

  Future getCards() async {
    try {
      Response response = await connect().get(
        ApiRoutes.getCard(await authenticationRepository.getUserId() ?? ""),
      );
      debugPrint(response.data);
      final parser = ResModelParser(response.data);
      ResModel res = await parser.parseInBackground();
      List<CardModel> cards = [];
      res.data.forEach((e) {
        cards.add(CardModel.fromJson(e));
      });
      if (cards.length != 0) {
        appCache.cardModel?.value = cards[0];
      }
      return resModelFromJson(response.data);
    } on DioError catch (e) {
      return resModelFromJson(
        e.response?.data ?? getErrorFromDio(e),
      );
    } catch (e) {
      return ResModel(message: e.toString(), statusCode: 400);
    }
  }

  Future freezeCard() async {
    try {
      Response response = await connect().patch(
          ApiRoutes.freezeCard(
              await authenticationRepository.getUserId() ?? ""),
          data: {
            "userId": await authenticationRepository.getUserId(),
            "freezeStatus": !(appCache.cardModel?.value.freezeStatus ?? false)
          });

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
