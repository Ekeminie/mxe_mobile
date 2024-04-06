import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mxe_mobile/constant/api-routes.dart';
import 'package:mxe_mobile/constant/constants.dart';
import 'package:mxe_mobile/core/model/airtime-and-data-beneficiary-response.dart';
import 'package:mxe_mobile/core/model/request/beneficiary.dart';
import 'package:mxe_mobile/core/model/request/bills-request.dart';
import 'package:mxe_mobile/core/model/res_model.dart';
import 'package:mxe_mobile/core/model/withdrawal-beneficiary-response.dart';
import 'package:mxe_mobile/core/services/app-cache.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/utils/network_exception.dart';

import '../storage-service.dart';
import '../user.service.dart';
import 'base-api.dart';

class BeneficiaryApiService {
  StorageService storageService = getIt<StorageService>();
  UserService userService = getIt<UserService>();
  AppCache cache = getIt<AppCache>();

  Future addPasswordAfterSignUp({required String? password}) async {
    String? userId = await storageService.readItem(key: userID);
    try {
      Response response = await connect().post(ApiRoutes.addPasswordAfterLogin,
          data: {"userid": userId, "newPassword": password});
      debugPrint(response.data);
      return resModelFromJson(response.data);
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
      Response response = await connect().get(ApiRoutes.addPasswordAfterLogin,
          queryParameters: {"count": 7, "firstname": name});
      debugPrint(response.data);
      return resModelFromJson(response.data);
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
      return resModelFromJson(response.data);
    } on DioError catch (e) {
      return resModelFromJson(
        e.response?.data ?? getErrorFromDio(e),
      );
    } catch (e) {
      return ResModel(message: e.toString(), statusCode: 400);
    }
  }

  Future addWithdrawalBeneficiary(
      {required WithdrawalBeneficiaryReq? request}) async {
    try {
      Response response = await connect()
          .post(ApiRoutes.createWithdrawalBeneficiary, data: request?.toJson());
      debugPrint(response.data);
      return resModelFromJson(response.data);
    } on DioError catch (e) {
      return resModelFromJson(
        e.response?.data ?? getErrorFromDio(e),
      );
    } catch (e) {
      return ResModel(message: e.toString(), statusCode: 400);
    }
  }

  Future addMXEBeneficiary({required WithdrawalBeneficiaryReq? request}) async {
    try {
      Response response = await connect()
          .post(ApiRoutes.createWithdrawalBeneficiary, data: request?.toJson());
      debugPrint(response.data);
      return resModelFromJson(response.data);
    } on DioError catch (e) {
      return resModelFromJson(
        e.response?.data ?? getErrorFromDio(e),
      );
    } catch (e) {
      return ResModel(message: e.toString(), statusCode: 400);
    }
  }

  Future getWithdrawalBeneficiary() async {
    var id = await storageService.readItem(key: userID);
    try {
      Response response = await connect().get(
        ApiRoutes.getWithdrawalBeneficiary(id!),
      );
      appCache.cacheWithdrawalBeneficiaries.value = [];
      resModelFromJson(response.data).data.forEach((e) {
        appCache.cacheWithdrawalBeneficiaries.value
            .add(WithdrawalBeneficiary.fromJson(e));
      });

      debugPrint(response.data);
      return resModelFromJson(response.data);
    } on DioError catch (e) {
      return resModelFromJson(
        e.response?.data ?? getErrorFromDio(e),
      );
    } catch (e) {
      return ResModel(message: e.toString(), statusCode: 400);
    }
  }

  Future deleteWithdrawalBeneficiaryById({String? id}) async {
    try {
      Response response = await connect().delete(
        ApiRoutes.deleteWithdrawalBeneficiary(id!),
      );

      debugPrint(response.data);
      return resModelFromJson(response.data);
    } on DioError catch (e) {
      return resModelFromJson(
        e.response?.data ?? getErrorFromDio(e),
      );
    } catch (e) {
      return ResModel(message: e.toString(), statusCode: 400);
    }
  }

  Future saveAirtimeAndDataBeneficiary(
      {required AirtimeAndDataBeneficiary? request}) async {
    try {
      Response response = await connect().post(
          ApiRoutes.createAirtimeAndDataBeneficiary,
          data: request?.toJson());
      debugPrint(response.data);
      return resModelFromJson(response.data);
    } on DioError catch (e) {
      return resModelFromJson(
        e.response?.data ?? getErrorFromDio(e),
      );
    } catch (e) {
      return ResModel(message: e.toString(), statusCode: 400);
    }
  }

  Future getAirtimeAndDataBeneficiary() async {
    var id = await storageService.readItem(key: userID);
    try {
      Response response = await connect().get(
        ApiRoutes.getAirtimeAndDataBeneficiary(id ?? ""),
      );
      appCache.airtimeDataBeneficiary.value = [];
      resModelFromJson(response.data).data.forEach((e) {
        appCache.airtimeDataBeneficiary.value
            .add(AirtimeDataBeneficiaryResponse.fromJson(e));
      });

      debugPrint(response.data);
      return resModelFromJson(response.data);
    } on DioError catch (e) {
      return resModelFromJson(
        e.response?.data ?? getErrorFromDio(e),
      );
    } catch (e) {
      return ResModel(message: e.toString(), statusCode: 400);
    }
  }

  Future deleteAirtimeAndDataBeneficiary({required String? request}) async {
    try {
      Response response = await connect().delete(
        ApiRoutes.deleteAirtimeAndDataBeneficiary(request ?? ""),
      );
      debugPrint(response.data);
      return resModelFromJson(response.data);
    } on DioError catch (e) {
      return resModelFromJson(
        e.response?.data ?? getErrorFromDio(e),
      );
    } catch (e) {
      return ResModel(message: e.toString(), statusCode: 400);
    }
  }
}
