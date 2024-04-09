import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/constant/palette.dart';
import 'package:mxe_mobile/core/services/navigation_service.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/locator.dart';

AppBar customAppBar(String title,
    {bool isLeftAligned = false,
    List<Widget>? actions,
    bool showBackButton = true,
    bool overrideBackButtonAction = false,
    bool showXIcon = false,
    Function? backFunction,
    Color? bgColor}) {
  final navigate = getIt<NavigationService>();
  return AppBar(
    backgroundColor: bgColor ?? white,
    leading: isLeftAligned
        ? null
        : showBackButton
            ? overrideBackButtonAction
                ? showXIcon
                    ? IconButton(
                        onPressed: () => backFunction!(), //navigate.goBack(),
                        icon: Icon(
                          Icons.close,
                          color: textDark,
                        ))
                    : BackButton(
                        color: AppColors.bgContrast,
                        onPressed: () => backFunction!(),
                      )
                : showXIcon
                    ? IconButton(
                        onPressed: () => navigate.goBack(),
                        icon: Icon(
                          Icons.close,
                          color: AppColors.bgContrast,
                        ))
                    : BackButton(
                        color: AppColors.bgContrast,
                      )
            : null,
    elevation: 0,
    centerTitle: !isLeftAligned,
    leadingWidth: isLeftAligned ? 10.w : null,
    title: Text(
      title,
      style: TextStyle(
        color: textDark,
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
      ),
    ),
    actions: actions ?? const [SizedBox.shrink()],
  );
}

Widget actionWidget(String title, Function() action,
        {Color? bgColor, Color? textColor}) =>
    GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: action,
      child: Container(
        height: 20,
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 1.h),
        decoration: BoxDecoration(
            color: bgColor ?? AppColors.subtleAccent,
            borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: textColor ?? AppColors.boldSemantic),
          ),
        ),
      ),
    );
