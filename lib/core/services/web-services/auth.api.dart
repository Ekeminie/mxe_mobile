import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mxe_mobile/constant/api-routes.dart';
import 'package:mxe_mobile/core/model/request/auth.dart';
import 'package:mxe_mobile/core/services/auth-repository.dart';
import 'package:mxe_mobile/core/services/web-services/user-api-service.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/utils/network_exception.dart';
import 'package:mxe_mobile/utils/result-model-isolate.dart';

import '../../../constant/constants.dart';
import '../../model/res_model.dart';
import '../storage-service.dart';
import '../user.service.dart';
import 'base-api.dart';

class AuthenticationApiService {
  final StorageService storageService;
  final AuthenticationRepository authenticationRepository;
  AuthenticationApiService(this.storageService, this.authenticationRepository);
  UserService userService = getIt<UserService>();
  UserApiService userApiService = getIt<UserApiService>();

  Future registerPhoneNumber({required String? phoneNo}) async {
    try {
      Response response = await connect()
          .post(ApiRoutes.registerPhoneNumber, data: {'phoneNumber': phoneNo});
      debugPrint(response.data);
      authenticationRepository.saveIdAndToken(
          resModelFromJson(response.data).data as Map<String, dynamic>);
      final parser = ResModelParser(response.data);
      return await parser.parseInBackground();
      // return resModelFromJson(response.data);
    } on DioError catch (e) {
      return resModelFromJson(
        e.response?.data ?? getErrorFromDio(e),
      );
    } catch (e) {
      print(e.toString());
      return ResModel(message: e.toString(), statusCode: 400);
    }
  }

  Future verifyCode({required String? code}) async {
    String? userId = await storageService.readItem(key: userID);
    Vcode vcode = Vcode(uId: userId!, verificationCode: code!);
    try {
      Response response =
          await connect().post(ApiRoutes.verifyCode, data: vcode.toMap());

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

  Future resendCode() async {
    String? userId = await storageService.readItem(key: userID);
    try {
      Response response =
          await connect().get(ApiRoutes.resendOtpCode(userId ?? ""));
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

  Future login({required String? phoneNo}) async {
    try {
      Response response = await connect()
          .post(ApiRoutes.loginRoute, data: {'phoneNumber': phoneNo});
      debugPrint(response.data);
      authenticationRepository.saveIdOnly(resModelFromJson(response.data).data);
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

  Future requestForgotPinOtp({required String? phoneNo}) async {
    try {
      Response response = await connect()
          .get(ApiRoutes.requestForgotPasswordOTP(phoneNo ?? ""));
      debugPrint(response.data);
      // authenticationRepository.saveIdOnly(resModelFromJson(response.data).data);
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

  Future verifyForgotPinOtp({required String? otp}) async {
    try {
      Response response =
          await connect().get(ApiRoutes.verifyForgotPasswordOTP(otp ?? ""));
      debugPrint(response.data);
      // authenticationRepository.saveIdOnly(resModelFromJson(response.data).data);
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

  Future loginWithMailAndPassword(
      {required String? password, required String? email}) async {
    try {
      Response response = await connect().post(ApiRoutes.savedLoginRoute,
          data: {'email': email, 'password': password});
      debugPrint(response.data);
      // await storeToken(response);
      // userService.getLocalUserD(user: resModelFromJson(response.data).userD);
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

  Future signup(SignUpRequest request) async {
    try {
      Response response =
          await connect().post(ApiRoutes.signUpRoute, data: request.toMap());

      if (response.statusCode == 200 || response.statusCode == 201) {
        await storeToken(response);
      }
      print(response.data);

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

  ///request for otp to be sent to users email
  Future requestEmailOTP({String? email}) async {
    try {
      Response response = await connect()
          .post(ApiRoutes.requestEmailOTP, data: {"email": email});
      print(response.data);
      final parser = ResModelParser(response.data);
      return await parser.parseInBackground();
      // return resModelFromJson(response.data);
    } on DioError catch (e) {
      return resModelFromJson(
        e.response?.data ?? getErrorFromDio(e),
      );
    } catch (e) {
      return ResModel(message: e.toString());
    }
  }

  ///verify the otp the user provides
  Future verifyEmailOTP({String? email, String? otp}) async {
    try {
      Response response = await connect()
          .post(ApiRoutes.verifyEmailOTP, data: {"email": email, "otp": otp});
      print(response.data);
      final parser = ResModelParser(response.data);
      return await parser.parseInBackground();
      // return resModelFromJson(response.data);
    } on DioError catch (e) {
      print("error message: ${e.message}");
      print("error message: ${e.type.name}");
      print("error response: ${e.response?.data.toString()}");
      return resModelFromJson(
        e.response?.data ?? getErrorFromDio(e),
      );
    } catch (e) {
      return ResModel(message: e.toString());
    }
  }

  storeToken(response) async {
    // if the request failed then return;
    ResModel res = resModelFromJson(response.data);
    if (res.success == false) return;
    //store token
    String _token = '${res.token}';
    String _refreshToken = '${res.refreshToken}';

    storageService.storeItem(key: token, value: _token);
    storageService.storeItem(key: refreshToken, value: _refreshToken);
  }

  Future requestForgotPasswordOTP({String? phone}) async {
    debugPrint("requestForgotPasswordOTP");
    try {
      Response response =
          await connect().get(ApiRoutes.requestForgotPasswordOTP(phone ?? ""));
      debugPrint(response.data);
      final parser = ResModelParser(response.data);
      return await parser.parseInBackground();
      // return resModelFromJson(response.data);
    } on DioError catch (e) {
      return resModelFromJson(
        e.response?.data ?? getErrorFromDio(e),
      );
    } catch (e) {
      return ResModel(message: e.toString());
    }
  }

  Future verifyForgotPasswordOTP({String? code}) async {
    debugPrint("verifyForgotPasswordOTP");
    try {
      Response response =
          await connect().get(ApiRoutes.verifyForgotPasswordOTP(code ?? ""));
      debugPrint(response.data);
      final parser = ResModelParser(response.data);
      return await parser.parseInBackground();
      // return resModelFromJson(response.data);
    } on DioError catch (e) {
      return resModelFromJson(
        e.response?.data ?? getErrorFromDio(e),
      );
    } catch (e) {
      return ResModel(message: e.toString());
    }
  }

  Future resetPassword({String? code, String? password}) async {
    debugPrint("resetPassword");
    try {
      Response response = await connect().post(ApiRoutes.resetPasswordRoute,
          data: {"uniqueVerificationCode": code, "newPassword": password});
      debugPrint(response.data);
      final parser = ResModelParser(response.data);
      return await parser.parseInBackground();
      // return resModelFromJson(response.data);
    } on DioError catch (e) {
      return resModelFromJson(
        e.response?.data ?? getErrorFromDio(e),
      );
    } catch (e) {
      return ResModel(message: e.toString());
    }
  }

  Future updateForgotPasswordOTP({UpdatePasswordRequest? request}) async {
    try {
      Response response = await connect()
          .post(ApiRoutes.updateForgotPassword, data: request?.toMap());
      if (response.statusCode == 200 || response.statusCode == 201) {
        return resModelFromJson(response.data).copyWith(status: true);
      }
      return resModelFromJson(response.data).copyWith(status: false);
    } on DioError catch (e) {
      return resModelFromJson(
        e.response?.data ?? getErrorFromDio(e),
      );
    } catch (e) {
      return ResModel(message: e.toString());
    }
  }
}

class Vcode {
  final String uId;
  final String verificationCode;
  Vcode({required this.uId, required this.verificationCode});

  Map<String, dynamic> toMap() {
    return {
      'userId': uId,
      'uniqueVerificationCode': verificationCode,
    };
  }

  factory Vcode.fromMap(Map<String, dynamic> map) {
    return Vcode(
      uId: map['uId'] as String,
      verificationCode: map['verificationCode'] as String,
    );
  }
}
