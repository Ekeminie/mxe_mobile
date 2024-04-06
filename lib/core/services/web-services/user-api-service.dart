import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mxe_mobile/constant/api-routes.dart';
import 'package:mxe_mobile/constant/constants.dart';
import 'package:mxe_mobile/core/model/notification-reponse.dart';
import 'package:mxe_mobile/core/model/res_model.dart';
import 'package:mxe_mobile/core/model/user-response.dart';
import 'package:mxe_mobile/core/services/app-cache.dart';
import 'package:mxe_mobile/core/services/auth-repository.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/utils/network_exception.dart';
import 'package:mxe_mobile/utils/result-model-isolate.dart';

import '../storage-service.dart';
import '../user.service.dart';
import 'base-api.dart';

class UserApiService {
  final AuthenticationRepository authenticationRepository;
  UserApiService({required this.authenticationRepository});
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
      String user = await storageService.readItem(key: currentUser);
      print("saved user:::$user");
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

  Future updateUser({required Map<String, dynamic>? user}) async {
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
      if (isRead != null) "isRead": isRead,
      if (status != null) "status": status,
      "userId": userId,
      "pageSize": pageSize,
      "pageNumber": pageNumber
    };

    try {
      Response response = await connect()
          .get(ApiRoutes.getNotifications, queryParameters: queryParams);
      debugPrint(response.data);
      return notificationModelFromJson(response.data);
    } on DioError catch (e) {
      return notificationModelFromJson(
        e.response?.data ?? getErrorFromDio(e),
      );
    } catch (e) {
      return NotificationResponse(
        message: e.toString(),
      );
    }
  }

  Future getNotificationById({required String? id}) async {
    try {
      Response response =
          await connect().post(ApiRoutes.getNotificationById(id ?? ""));
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

  Future changePin({required String? pin, required String? otp}) async {
    try {
      Response response = await connect().post(ApiRoutes.changePin,
          data: {"uniqueVerificationCode": otp, "newPassword": pin});
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
