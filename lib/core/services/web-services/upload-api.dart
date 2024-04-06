import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mxe_mobile/constant/api-routes.dart';
import 'package:mxe_mobile/core/model/res_model.dart';
import 'package:mxe_mobile/core/services/app-cache.dart';
import 'package:mxe_mobile/core/services/auth-repository.dart';
import 'package:mxe_mobile/core/services/user.service.dart';
import 'package:mxe_mobile/core/services/web-services/base-api.dart';
import 'package:mxe_mobile/utils/file-type-utils.dart';
import 'package:mxe_mobile/utils/network_exception.dart';
import 'package:mxe_mobile/utils/result-model-isolate.dart';
import 'package:mxe_mobile/utils/string%20utils.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';

class UploadApiService {
  final AuthenticationRepository authenticationRepository;
  UploadApiService(
      {required this.authenticationRepository,
      required this.userService,
      required this.cache});
  final UserService userService;
  final AppCache cache;

  Future uploadFile({required FormData data}) async {
    try {
      Response response = await connect().post(
        ApiRoutes.uploadFiles,
        data: data,
      );
      debugPrint(response.data);
      final parser = ResModelParser(response.data);
      return await parser.parseInBackground();
      // return resModelFromJson(response.data);
    } on DioError catch (e) {
      print(e.response);
      print(e.message);
      printWrapped(e.error);
      return resModelFromJson(
        e.response?.data ?? getErrorFromDio(e),
      );
    } catch (e) {
      printWrapped(e.toString());
      return ResModel(message: e.toString(), statusCode: 400);
    }
  }
}

Future<FormData> getFormData({String? name, String? data}) async {
  var formData = FormData();
  if (data.isNotNullNorEmpty) {
    MediaType mediaType = getMimeType(data!);
    formData.files.add(
      MapEntry(
        'image',
        await MultipartFile.fromFile(data, contentType: mediaType),
      ),
    );
  }
  return formData;
}
