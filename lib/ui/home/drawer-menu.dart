import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/home/finance/finance.ui.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/theme-mode-bottomsheet.dart';

class NavDrawerMenu extends StatefulWidget {
  const NavDrawerMenu({super.key});

  @override
  State<NavDrawerMenu> createState() => _NavDrawerMenuState();
}

class _NavDrawerMenuState extends State<NavDrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 40,
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.close,
            color: AppColors.textLight,
          ),
        ),
        backgroundColor: const Color(0xffF5F5F7),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(color: Color(0xffF5F5F7)),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            32.sbH,
            Text(
              "MXE",
              style: GoogleFonts.plusJakartaSans(
                  color: AppColors.bgContrast,
                  fontWeight: FontWeight.w700,
                  fontSize: 24.sp),
            ),
            16.sbH,
            const Divider(),
            42.sbH,
            Text(
              "Account Management",
              style: GoogleFonts.plusJakartaSans(
                  color: AppColors.bgContrast,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp),
            ),
            18.sbH,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActionItem(
                    title: "My Profile", icon: 'my-profile', onTap: () {}),
                ActionItem(
                    title: "Insights",
                    icon: 'insights',
                    onTap: () => Navigator.pushReplacementNamed(
                        context, Routes.insightsPageRoute)),
                ActionItem(title: "FAQ", icon: 'faq', onTap: () {}),
                ActionItem(
                    title: "Statement of Account",
                    icon: 'account-statement',
                    onTap: () {}),
              ],
            ),
            32.sbH,
            const Divider(),
            24.sbH,
            Text(
              "Connect with us",
              style: GoogleFonts.plusJakartaSans(
                  color: AppColors.bgContrast,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp),
            ),
            16.sbH,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActionItem(title: "Instagram", icon: 'instagram', onTap: () {}),
                ActionItem(title: "Facebook", icon: 'facebook', onTap: () {}),
                ActionItem(title: "Twitter", icon: 'x', onTap: () {}),
                ActionItem(title: "Discord", icon: 'discord', onTap: () {}),
              ],
            ),
            32.sbH,
            const Divider(),
            24.sbH,
            Text(
              "More",
              style: GoogleFonts.plusJakartaSans(
                  color: AppColors.bgContrast,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp),
            ),
            16.sbH,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActionItem(title: "Community", icon: 'more', onTap: () {}),
                ActionItem(title: "About MXE", icon: 'about-mxe', onTap: () {}),
                Visibility(
                    visible: false,
                    maintainSize: true,
                    maintainState: true,
                    maintainAnimation: true,
                    child:
                        ActionItem(title: "Twitter", icon: 'x', onTap: () {})),
                Visibility(
                    visible: false,
                    maintainSize: true,
                    maintainState: true,
                    maintainAnimation: true,
                    child: ActionItem(
                        title: "Discord", icon: 'dicord', onTap: () {})),
              ],
            ),
            32.sbH,
            const Divider(),
            24.sbH,
            ActionItem(title: "Logout", icon: 'logout', onTap: () {}),
            Spacer(),
            Divider(),
            8.sbH,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => showThemeModeBottomSheet(context),
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    children: [
                      SvgPicture.asset('theme-mode'.svg),
                      8.sbW,
                      Text(
                        "Light Mode",
                        style: GoogleFonts.plusJakartaSans(
                            color: AppColors.bgContrast,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Version 1.0.0",
                  style: GoogleFonts.plusJakartaSans(
                      color: AppColors.textLight,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp),
                ),
              ],
            ),
            20.sbH,
          ],
        ),
      ),
    );
  }
}
