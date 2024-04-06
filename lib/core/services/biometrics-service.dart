import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';

final bioMetrics = getIt<BioMetricsService>();

class BioMetricsService {
  final LocalAuthentication auth = LocalAuthentication();
  // ···
  late final bool canAuthenticateWithBiometrics;
  Future<bool> checkSupport() async {
    debugPrint('checkBioMetricsSupport');
    // #docregion CanCheck
    canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    // #enddocregion CanCheck

    print('Can authenticate: $canAuthenticate');
    print('Can authenticate with biometrics: $canAuthenticateWithBiometrics');

    return canAuthenticateWithBiometrics;
  }

  Future<void> authenticateWithBiometrics(
      {required Function function, String? msg}) async {
    try {
      // #docregion AuthBioOnly
      final bool didAuthenticate = await auth.authenticate(
          localizedReason: msg ?? 'Please authenticate to continue',
          options: const AuthenticationOptions(
            // biometricOnly: true,
            stickyAuth: true,
            useErrorDialogs: true,
          ));
      // #enddocregion AuthBioOnly
      if (didAuthenticate) {
        function();
      }
    } on PlatformException {
      "Error Using Biometrics".toast();
    } catch (e) {
      print(e.toString());
      "Error Using Biometrics$e".toast();
    }
  }
}
