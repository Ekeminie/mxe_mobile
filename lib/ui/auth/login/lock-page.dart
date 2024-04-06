import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/services/user.service.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/ui/auth/login/login.vm.dart';
import 'package:mxe_mobile/utils/string%20utils.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';

class LockPage extends StatefulWidget {
  const LockPage({Key? key}) : super(key: key);

  @override
  State<LockPage> createState() => _LockPageState();
}

class _LockPageState extends State<LockPage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
        builder: (context, model, child) => Scaffold(
            appBar: customAppBar("", actions: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => model.logout(),
                child: Container(
                  height: 20,
                  margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                      color: AppColors.subtleAccent,
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: ValueListenableBuilder(
                      valueListenable: uService.userCredentials,
                      builder: (context, user, _) => Text(
                        "Not ${user.firstName?.capitalize()}?",
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.boldSemantic),
                      ),
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
                  const Spacer(),
                  Center(child: SvgPicture.asset('lock-account'.svg)),
                  const Spacer(),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff0D0D0D),
                      ),
                      children: [
                        TextSpan(
                          text:
                              'Your account has been locked for your safety. Please contact us on ',
                          style: GoogleFonts.plusJakartaSans(),
                        ),
                        TextSpan(
                          text: 'support@mxelabs.com',
                          style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w700,
                              color: AppColors.moderateBlue),
                        ),
                        TextSpan(
                          text: ' to unlock your account',
                          style: GoogleFonts.plusJakartaSans(),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            )));
  }
}
