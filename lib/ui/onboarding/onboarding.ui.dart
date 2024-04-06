import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/constant/constants.dart';
import 'package:mxe_mobile/core/services/navigation_service.dart';
import 'package:mxe_mobile/core/services/storage-service.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/onboarding/onboarding.vm.dart';
import 'package:mxe_mobile/utils/initializer.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int currentIndex = 0;
  late PageController _pageController;
  StorageService storageService = getIt<StorageService>();
  NavigationService navigationService = getIt<NavigationService>();
  List<OnboardModel> screens = <OnboardModel>[
    OnboardModel(text: "", img: 'o1'.svg, title: "Seamless Global Transfers"),
    OnboardModel(text: "", img: 'o2'.svg, title: "Unlock the Crypto Universe"),
    OnboardModel(text: "", img: 'o3'.svg, title: "Virtual Card Redefined"),
    OnboardModel(text: "", img: 'o4'.svg, title: "Save Funds in USD"),
  ];

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
    );
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _storeOnboardInfo() async {
    storageService.storeItem(key: introScreen, value: 'true');
    await getIt<Initializer>().initOnBoardingInfo();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<OnBoardingViewModel>(
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors.grey,
        body: PageView.builder(
            itemCount: screens.length,
            controller: _pageController,
            // physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (_, index) {
              return Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                  SvgPicture.asset(screens[index].img!),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: Text(
                      screens[index].title!,
                      style: GoogleFonts.plusJakartaSans(
                          color: AppColors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          height: 10.0,
                          // width: 50,
                          child: ListView.builder(
                            itemCount: screens.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 3.0),
                                width: currentIndex == index ? 60 : 18,
                                height: currentIndex == index ? 8 : 8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: currentIndex == index
                                      ? AppColors.white
                                      : AppColors.lightGrey.withOpacity(0.3),
                                ),
                              );
                            },
                          ),
                        ),
                        12.sbW,
                        GestureDetector(
                          onTap: index == screens.length - 1
                              ? () {
                                  _storeOnboardInfo();
                                  Navigator.pushReplacementNamed(
                                      context, Routes.phoneAuthPage);
                                }
                              : () {
                                  _pageController.animateToPage(
                                    index + 1,
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeIn,
                                  );
                                },
                          behavior: HitTestBehavior.opaque,
                          child: IntrinsicWidth(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 28.w, vertical: 10.h),
                              decoration: BoxDecoration(
                                color: AppColors.accentColor,
                                borderRadius: BorderRadius.circular(32.r),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "Get Started",
                                    style: GoogleFonts.plusJakartaSans(
                                        color: AppColors.bgContrast,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16.sp),
                                  ),
                                  19.sbW,
                                  SvgPicture.asset('arrow-circle-right'.svg)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  50.sbH,
                  // Expanded(child: Container()),
                ],
              );
            }),
      ),
    );
  }
}

class OnboardModel {
  String? img;
  String? text;
  String? title;

  OnboardModel({this.img, this.text, this.title});
}
