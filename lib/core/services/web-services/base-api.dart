import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mxe_mobile/constant/constants.dart';
import 'package:mxe_mobile/core/services/navigation_service.dart';
import 'package:mxe_mobile/core/services/web-services/nertwork_config.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/widgets/toast.dart';

// import 'package:platform_device_id/platform_device_id.dart';

import '../storage-service.dart';

Dio connect(
    {String? useCustomUrl, ResponseType responseType = ResponseType.plain}) {
  StorageService storageService = getIt<StorageService>();
  BaseOptions options = BaseOptions(
      baseUrl: useCustomUrl ?? NetworkConfig.baseUrl,
      connectTimeout: 350000,
      receiveTimeout: 35000,
      responseType: responseType);
  Dio dio = Dio(options);
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        debugPrint(options.uri.toString());
        debugPrint(options.data.toString());

        // String? id = await PlatformDeviceId.getDeviceId;
        // options.headers['device-id'] = id;
        String? value = await storageService.readItem(key: token);

        if (value != null && value.isNotEmpty) {
          options.headers['Authorization'] = "Bearer $value";
        }

        return handler.next(options);
      },
      onResponse: (response, handler) {
        debugPrint("response");
        return handler.next(response);
      },
      onError: (DioError e, handler) async {
        debugPrint("Error: ${e.response?.statusCode}");
        debugPrint("Error: ${e.response?.data}");
        //handles auto-logout when error message contains session expiry desc.
        if (e.response?.statusCode == 401 &&
            e.response.toString().contains("Authorization code")) {
          getIt<NavigationService>()
              .navigateToAndRemoveUntil(Routes.loginRoute);
          getIt<StorageService>().deleteItem(key: token);
          showCustomToast("Session Expired");
        }
        return handler.next(e);
      },
    ),
  );

  return dio;
}
