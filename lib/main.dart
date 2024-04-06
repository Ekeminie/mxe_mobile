import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/constant/constants.dart';
import 'package:mxe_mobile/core/services/navigation_service.dart';
import 'package:mxe_mobile/core/services/storage-service.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/routes/router.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/utils/initializer.dart';
import 'package:mxe_mobile/utils/model-generator.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:oktoast/oktoast.dart';

import 'constant/palette.dart';

String isFirstLaunch = '';
String hasUser = '';
final String dartClass =
    generateDartClass(jsonInput, className: "AirtimeRequest");

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await initPhoneInfo();
  ///===========================================================///
  ///===========================================================///
  ///==========================================================///
  ///==========================================================///

  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  await dotenv.load(fileName: ".env");
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  //setup dependency injector
  dependenciesInjectorSetup();
  await getIt<Initializer>().init();

  isFirstLaunch =
      await getIt<StorageService>().readItem(key: introScreen) ?? "";
  hasUser = await getIt<StorageService>().readItem(key: currentUser) ?? "";

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  final bool? loggedIn;
  MyApp({Key? key, this.loggedIn}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (child, _) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: getIt<NavigationService>().navigatorKey,
              scaffoldMessengerKey: getIt<NavigationService>().snackBarKey,
              theme: ThemeData(
                useMaterial3: false,
                fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                scaffoldBackgroundColor: white,
                textTheme: Theme.of(context).textTheme.apply(
                      bodyColor: primaryDarkColor,
                      displayColor: primaryDarkColor,
                      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                    ),
                colorScheme: ThemeData()
                    .colorScheme
                    .copyWith(primary: AppColors.moderateBlue // primaryColor
                        ),
                primaryColor: primaryColor,
                backgroundColor: white,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              onGenerateRoute: Routers.generateRoute,
              initialRoute: isFirstLaunch.isNotNullNorEmpty
                  ? hasUser.isNotEmpty
                      ? Routes.welcomeRoute
                      : Routes.signupRoute
                  : Routes.onboardingPageRoute);
        },
      ),
    );
  }
}
