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
import 'package:mxe_mobile/widgets/header-widget.dart';
import 'package:mxe_mobile/widgets/input.dart';
import 'package:mxe_mobile/widgets/square-btn.dart';

class PhoneNumberAuthPage extends StatefulWidget {
  const PhoneNumberAuthPage({Key? key}) : super(key: key);

  @override
  State<PhoneNumberAuthPage> createState() => _PhoneNumberAuthPageState();
}

class _PhoneNumberAuthPageState extends State<PhoneNumberAuthPage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
        builder: (context, model, child) => Scaffold(
            appBar: customAppBar("", actions: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, Routes.signupRoute),
                child: Container(
                  // height: 100,
                  margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                      color: AppColors.subtleAccent,
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Text(
                      "Create Account",
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
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    12.sbH,
                    const IHeader(
                      title: "Welcome Back",
                      subTitle:
                          "Enter your mobile number to link this phone with your account ",
                    ),
                    34.sbH,
                    Input(
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
                    8.sbH,
                    Text(
                      "You will receive an SMS verification that may apply message and data rates.",
                      style: GoogleFonts.plusJakartaSans(
                          color: AppColors.textLight,
                          fontWeight: FontWeight.w400,
                          fontSize: 13.sp),
                    ),
                    100.sbH,
                    Align(
                        alignment: Alignment.centerRight,
                        child: SquareButton(
                          isActive: model.hasPhone,
                          onClick: () => model.login(),
                        )),
                  ],
                ),
              ),
            )));
  }
}
