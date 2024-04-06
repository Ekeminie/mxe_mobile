import 'package:encrypt/encrypt.dart';
import 'package:flutter/cupertino.dart' hide Key;
import 'package:mxe_mobile/constant/constants.dart';

class EncryptionUtils {
  static String encryptAES({required String text}) {
    // pwdEncryptionKey is the encryption key in the .env file'
    final key = Key.fromUtf8(pwdEncryptionKey);
    final iv = IV.fromUtf8(pwdEncryptionKey);
    final encryptor = Encrypter(AES(
      key,
      mode: AESMode.ecb,
      padding: 'PKCS7',
    ));
    Encrypted encrypted = encryptor.encrypt(
      text,
      iv: iv,
    );
    debugPrint(encrypted.base64);
    return encrypted.base64;
  }

  static String decryptAES({required String text}) {
    final key = Key.fromUtf8(pwdEncryptionKey);
    final iv = IV.fromUtf8(pwdEncryptionKey);
    final encryptor = Encrypter(AES(
      key,
      mode: AESMode.ecb,
      padding: 'PKCS7',
    ));
    var decrypted = encryptor.decrypt(Encrypted.fromBase64(text), iv: iv);
    debugPrint(decrypted);
    return decrypted;
  }
}
