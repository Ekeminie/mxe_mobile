// import 'dart:developer';
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_remote_config/firebase_remote_config.dart';
//
// class FBRemoteConfigService {
//   final FirebaseRemoteConfig firebaseRemoteConfig =
//       FirebaseRemoteConfig.instance;
//
//   Future<void> init() async {
//     try {
//       await firebaseRemoteConfig.ensureInitialized();
//       await firebaseRemoteConfig.setConfigSettings(
//         RemoteConfigSettings(
//           fetchTimeout: const Duration(seconds: 10),
//           minimumFetchInterval: const Duration(hours: 12),
//         ),
//       );
//       await firebaseRemoteConfig.fetchAndActivate();
//       print("remote-config:::${getUpdates()}");
//     } on FirebaseException catch (e, st) {
//       log(
//         'Unable to initialize Firebase Remote Config',
//         error: e,
//         stackTrace: st,
//       );
//     }
//   }
//
//   String getUpdates() => firebaseRemoteConfig.getString('update');
// }
