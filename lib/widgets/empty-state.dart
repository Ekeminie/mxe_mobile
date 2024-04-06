import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        54.sbH,
        Center(child: SvgPicture.asset('empty-icon'.svg)),
        48.sbH,
        AutoSizeText(
          "It's Empty here",
          style: GoogleFonts.plusJakartaSans(
              fontWeight: FontWeight.w700,
              fontSize: 16.sp,
              color: AppColors.bgContrast),
        )
      ],
    );
  }
}
