import 'package:mxe_mobile/utils/encryption-utils.dart';

class OnDeviceAuthInfo {
  final String? email;
  final String? fullName;
  final String? password;

  OnDeviceAuthInfo({this.email, this.fullName, this.password});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'fullName': fullName,
      'password': EncryptionUtils.encryptAES(
        text: password!,
      )
    };
  }

  factory OnDeviceAuthInfo.fromMap(Map<String, dynamic> map) {
    return OnDeviceAuthInfo(
      email: (map['email'] != null) ? map['email'] as String : null,
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      password: map['password'] != null
          ? EncryptionUtils.decryptAES(text: (map['password']) as String)
          : null,
    );
  }

  OnDeviceAuthInfo copyWith({
    String? email,
    String? fullName,
    String? password,
  }) {
    return OnDeviceAuthInfo(
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      password: password ?? this.password,
    );
  }

  @override
  String toString() {
    return 'OnDeviceAuthInfo{email: $email, fullName: $fullName, password: $password}';
  }
}
