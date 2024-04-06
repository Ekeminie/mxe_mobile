// import 'dart:convert';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:nicml_mobile/core/services/analytics-services.dart';
// import 'package:nicml_mobile/core/services/firebase-remote-config-service.dart';
// import 'package:nicml_mobile/locator.dart';
// import 'package:nicml_mobile/widgets/update-sheet.dart';
//
// class UpdateService {
//   final firebaseRemoteConfig = getIt<FBRemoteConfigService>();
//
//   Map android = {};
//   Map ios = {};
//   init() {
//     android = jsonDecode(firebaseRemoteConfig.getUpdates())['android'];
//     ios = jsonDecode(firebaseRemoteConfig.getUpdates())['ios'];
//   }
//
//   checkForUpdates({required BuildContext context}) async {
//     init();
//
//     if (Platform.isAndroid && (android['update'] ?? false)) {
//       if (double.parse(analytics.packageInfo.buildNumber) <
//           (double.parse(
//               android['build'] ?? analytics.packageInfo.buildNumber))) {
//         updateBottomSheet(context,
//             force: android['force'],
//             link: android['link'],
//             name: "User ",
//             version: android['version']);
//       }
//     } else if (Platform.isIOS && !(ios['update'])) {
//       if (double.parse(analytics.packageInfo.buildNumber) <
//           (double.parse(ios['build'] ?? analytics.packageInfo.buildNumber))) {
//         updateBottomSheet(context,
//             force: ios['force'],
//             link: ios['link'],
//             name: "User ",
//             version: ios['version']);
//       }
//     }
//   }
// }
