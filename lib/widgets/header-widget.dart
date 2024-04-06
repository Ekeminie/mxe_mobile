import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';

class IHeader extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final bool centerAlign;
  const IHeader(
      {super.key, this.title, this.subTitle, this.centerAlign = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          centerAlign ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          title ?? "",
          style: GoogleFonts.plusJakartaSans(
              color: AppColors.bgContrast,
              fontWeight: FontWeight.w700,
              fontSize: 32.sp),
        ),
        10.sbH,
        Text(
          subTitle ?? "",
          style: GoogleFonts.plusJakartaSans(
              color: AppColors.textLight,
              fontWeight: FontWeight.w400,
              fontSize: 16.sp),
          textAlign: centerAlign ? TextAlign.center : TextAlign.left,
        ),
      ],
    );
  }
}

Widget header(String title, {bool usePadding = true}) => Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: usePadding ? 16 : 0.0),
        child: AutoSizeText(
          title,
          style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.w700,
              fontSize: 24.sp,
              color: AppColors.bgContrast),
        ),
      ),
    );
