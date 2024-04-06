// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:nicml_mobile/core/model/user-response.dart';
// import 'package:nicml_mobile/locator.dart';
// import 'package:package_info_plus/package_info_plus.dart';
//
// final analytics = getIt<AnalyticsService>();
//
// class AnalyticsService {
//   final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
//   late PackageInfo packageInfo;
//
//   initPackageInfo() async {
//     packageInfo = await PackageInfo.fromPlatform();
//   }
//
//   FirebaseAnalyticsObserver getAnalyticsObserver() =>
//       FirebaseAnalyticsObserver(analytics: _analytics);
//
//   setUserProps(User? user) {
//     _analytics.setUserId(id: user?.sId);
//     _analytics.setDefaultEventParameters({
//       "appVersion": packageInfo.version,
//     });
//   }
//
//   logLogin({String? method}) {
//     _analytics.logLogin(loginMethod: method ?? "email");
//   }
//
//   logSignUp({String? method}) {
//     _analytics.logSignUp(signUpMethod: method ?? "email");
//   }
//
//   log({required String name, Map<String, dynamic>? params}) {
//     _analytics.logEvent(name: name, parameters: params);
//   }
// }
