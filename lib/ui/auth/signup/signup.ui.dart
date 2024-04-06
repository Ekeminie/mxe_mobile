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
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';
import 'package:mxe_mobile/widgets/input.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
        builder: (context, model, child) => Scaffold(
            appBar: customAppBar("", actions: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, Routes.phoneAuthPage),
                child: Container(
                  // height: 80,
                  margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                      color: AppColors.subtleAccent,
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Text(
                      "Login?",
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.boldSemantic),
                    ),
                  ),
                ),
              )
            ]),
            resizeToAvoidBottomInset: true,
            extendBody: true,
            // backgroundColor: Colors.black26,
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  12.sbH,
                  const IHeader(
                    title: "Create your account",
                    subTitle: "Enter your phone number to get started",
                  ),
                  34.sbH,
                  Input(
                    controller: controller,
                    hintText: "Phone Number",
                    prefixWidget: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        16.sbW,
                        SvgPicture.asset('ngn-flag'.svg),
                        5.sbW,
                        const Text("+234"),
                        5.sbW,
                        const Icon(Icons.keyboard_arrow_down_rounded)
                      ],
                    ),
                    readOnly: false,
                    onChanged: (v) => model.setPhoneNo(v),
                  ),
                  16.sbH,
                  UiButton(
                    text: "Get Started",
                    onPressed: model.hasPhone
                        ? () => model.registerPhoneNumber()
                        : null,
                  ),
                  32.sbH,
                  Row(
                    children: [
                      const Expanded(
                          child: Divider(
                        color: AppColors.grey,
                      )),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Text(
                          "OR",
                          style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp,
                              color: AppColors.textLight),
                        ),
                      ),
                      const Expanded(
                          child: Divider(
                        color: AppColors.grey,
                      ))
                    ],
                  ),
                  40.sbH,
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.bgContrast,
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset("apple-social".svg),
                        Expanded(
                          child: Center(
                            child: Text(
                              "Continue with Apple",
                              style: GoogleFonts.plusJakartaSans(
                                  color: AppColors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  16.sbH,
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.white,
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset("google-social".svg),
                        Expanded(
                          child: Center(
                            child: Text(
                              "Continue with Google",
                              style: GoogleFonts.plusJakartaSans(
                                  color: AppColors.bgContrast,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textLight,
                      ),
                      children: [
                        TextSpan(
                          text: "By continuing, you agree to our ",
                          style: GoogleFonts.plusJakartaSans(),
                        ),
                        TextSpan(
                          text: 'Terms of Service',
                          style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w400,
                              color: AppColors.moderateBlue),
                        ),
                        TextSpan(
                          text: ' and ',
                          style: GoogleFonts.plusJakartaSans(),
                        ),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w400,
                              color: AppColors.moderateBlue),
                        ),
                      ],
                    ),
                  ),
                  36.sbH,
                ],
              ),
            )));
  }
}
