import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mxe_mobile/constant/api-routes.dart';
import 'package:mxe_mobile/core/model/request/mxe-tag-withdrawals.dart';
import 'package:mxe_mobile/core/model/request/transfer-request.dart';
import 'package:mxe_mobile/core/model/res_model.dart';
import 'package:mxe_mobile/core/services/app-cache.dart';
import 'package:mxe_mobile/core/services/auth-repository.dart';
import 'package:mxe_mobile/core/services/storage-service.dart';
import 'package:mxe_mobile/core/services/user.service.dart';
import 'package:mxe_mobile/core/services/web-services/base-api.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/utils/network_exception.dart';
import 'package:mxe_mobile/utils/result-model-isolate.dart';

class TransferApiService {
  final AuthenticationRepository authenticationRepository;
  TransferApiService({required this.authenticationRepository});
  // final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  StorageService storageService = getIt<StorageService>();
  UserService userService = getIt<UserService>();
  AppCache cache = getIt<AppCache>();

  Future withdrawMoneyWithMxeTag(
      {required MxeTagWithdrawalRequest? request}) async {
    try {
      Response response = await connect()
          .post(ApiRoutes.withdrawWithMxeTag, data: request?.toJson());
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

  Future withdrawMoneyRequest({SendMoneyRequest? request}) async {
    try {
      Response response =
          await connect().post(ApiRoutes.withdrawal, data: request?.toJson());
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

  Future resolveAccount(
      {required String? accountNo, required String? bankCode}) async {
    try {
      Map<String, dynamic> queryParams = {
        "accountNumber": accountNo,
        'bankCode': bankCode
      };
      Response response = await connect()
          .get(ApiRoutes.resolveAccount, queryParameters: queryParams);
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

  Future getBanks() async {
    try {
      Response response = await connect().get(ApiRoutes.getBanks);
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
