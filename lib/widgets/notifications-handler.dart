import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/auth/login/login.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';

class NotificationWidgetHandler extends StatefulWidget {
  final String destinationRoute;
  const NotificationWidgetHandler({Key? key, required this.destinationRoute})
      : super(key: key);

  @override
  State<NotificationWidgetHandler> createState() =>
      _NotificationWidgetHandlerState();
}

class _NotificationWidgetHandlerState extends State<NotificationWidgetHandler> {
  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
        builder: (context, model, child) => Scaffold(
            resizeToAvoidBottomInset: true,
            extendBody: true,
            backgroundColor: AppColors.bgContrast,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                12.sbH,
                OurProductBottomSheet(
                  destinationRoute: Routes.signupDetailsRoute,
                )
              ],
            )));
  }
}

class OurProductBottomSheet extends StatelessWidget {
  final String destinationRoute;
  OurProductBottomSheet({Key? key, required this.destinationRoute})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32), topRight: Radius.circular(32)),
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF082078),
            Color.fromRGBO(8, 32, 120, 0),
          ],
          stops: [0.0002, 0.596],
        )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    40.sbH,
                    SvgPicture.asset('notification-demo2'.svg),
                    40.sbH,
                    Center(
                      child: Text(
                        "Get notified",
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white),
                      ),
                    ),
                    24.sbH,
                    ...{
                      "transaction-notification":
                          "Get notifications when you make a transaction or receive one.",
                      "market-alerts":
                          "Get updates about market trends to help make investment decisions.",
                      "reminders":
                          "Never miss a payment. Get reminders for scheduled payments,"
                    }
                        .entries
                        .toList()
                        .map((e) => Container(
                              padding: const EdgeInsets.only(bottom: 24),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(e.key.svg),
                                  8.sbW,
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          e.key
                                              .replaceAll("-", " ")
                                              .capitalizeFirstOfEach,
                                          style: GoogleFonts.plusJakartaSans(
                                              color: AppColors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18),
                                        ),
                                        8.sbH,
                                        Text(e.value,
                                            style: GoogleFonts.plusJakartaSans(
                                                color: AppColors.textLight,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ))
                        .toList(),
                  ],
                ),
                32.sbH,
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, destinationRoute),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xffE7ECFD),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "Enable Notification",
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.moderateBlue),
                      ),
                    ),
                  ),
                ),
                16.sbH,
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, destinationRoute),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.moderateBlue),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "Not Now",
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white),
                      ),
                    ),
                  ),
                ),
                56.sbH
              ],
            ),
          ),
        ),
      ),
    );
  }
}
