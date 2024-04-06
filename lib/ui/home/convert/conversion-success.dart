import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/home/convert/convert.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';

class ConversionSuccess extends StatefulWidget {
  const ConversionSuccess({Key? key}) : super(key: key);

  @override
  State<ConversionSuccess> createState() => _ConversionSuccessState();
}

class _ConversionSuccessState extends State<ConversionSuccess> {
  @override
  Widget build(BuildContext context) {
    return BaseView<ConvertFundsViewModel>(
      onModelReady: (m) => m.get1(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: customAppBar("", bgColor: AppColors.bgColor),
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: AutoSizeText(
                  "Conversion Successful",
                  style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 24.sp,
                      color: AppColors.bgContrast),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  32.sbH,
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        Animate(
                          effects: const [
                            FadeEffect(
                                duration: Duration(milliseconds: 700),
                                curve: Curves.bounceInOut),
                            ScaleEffect(
                                duration: Duration(milliseconds: 700),
                                curve: Curves.bounceInOut)
                          ],
                          child: SvgPicture.asset('success'.svg),
                        ),
                        32.sbH,
                        AutoSizeText(
                          """You have successfully converted""",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        8.sbH,
                        AutoSizeText(
                          """NGN 5,000.00""",
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 24.sp, fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                        16.sbH,
                        AutoSizeText(
                          """to""",
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 18.sp, color: AppColors.textLight),
                          textAlign: TextAlign.center,
                        ),
                        16.sbH,
                        AutoSizeText(
                          """GBP 3.00""",
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 24.sp, fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                        8.sbH,
                        AutoSizeText(
                          """Funds can be found in you GBP account""",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  24.sbH,
                  UiButton(
                    text: "Continue",
                    onPressed: () => Navigator.pushReplacementNamed(
                        context, Routes.homeRoute),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
