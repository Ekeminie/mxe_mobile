import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/bottomsheet-widgets.dart';

class ShareBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
              // right: 20,
              // left: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          color: AppColors.bgColor,
          // height: 500,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                8.0.sbH,
                const SheetHandle(),
                36.0.sbH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => {},
                      child: Column(
                        children: [
                          SvgPicture.asset('pdf'.svg),
                          4.sbH,
                          AutoSizeText(
                            "Share as PDF",
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    24.sbW,
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => {},
                      child: Column(
                        children: [
                          SvgPicture.asset('image'.svg),
                          4.sbH,
                          AutoSizeText(
                            "Share as Image",
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                32.sbH,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

shareBottomSheet(
  BuildContext context,
) {
  showModalBottomSheet(
      enableDrag: true,
      isDismissible: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return ShareBottomSheet();
      });
}
