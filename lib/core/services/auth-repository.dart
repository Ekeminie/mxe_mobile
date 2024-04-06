import 'package:mxe_mobile/constant/constants.dart';
import 'package:mxe_mobile/core/services/storage-service.dart';

class AuthenticationRepository {
  final StorageService storageService;

  AuthenticationRepository(this.storageService);
  String? phone;
  String? userId;

  saveIdAndToken(Map<String, dynamic> map) async {
    print(map.toString());
    userId = map['userid'];
    String? userToken = map['token'];
    print("saveId:::$userId");
    print("token:::$token");

    storageService.storeItem(key: userID, value: userId);
    storageService.storeItem(key: token, value: userToken);
  }

  saveIdOnly(Map<String, dynamic> map) async {
    print(map.toString());
    userId = map['userid'] ?? map['userId'];
    print("saveId:::$userId");
    storageService.storeItem(key: userID, value: userId);
  }

  Future<String?> getUserId() async {
    userId = await storageService.readItem(key: userID);
    return userId;
  }
}
