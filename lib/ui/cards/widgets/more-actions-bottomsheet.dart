import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/ui/cards/widgets/freeze-card-sheet.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';

class CardMoreBottomSheet extends StatelessWidget {
  const CardMoreBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      child: Container(
        padding: EdgeInsets.only(
            // right: 20,
            // left: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        // height: 500,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              8.0.sbH,
              24.0.sbH,
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => {
                  Navigator.pop(context),
                  freezeOrDeleteCardBottomSheet(context),
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      SvgPicture.asset('card-freeze'.svg),
                      16.sbW,
                      AutoSizeText(
                        "Freeze",
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              16.sbH,
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => {
                  Navigator.pop(context),
                  freezeOrDeleteCardBottomSheet(context, isDelete: true),
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      SvgPicture.asset('card-delete'.svg),
                      16.sbW,
                      AutoSizeText(
                        "Delete",
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              20.sbH,
              GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => Navigator.pop(context),
                  child: SvgPicture.asset('card-close'.svg)),
              70.sbH,
            ],
          ),
        ),
      ),
    );
  }
}

cardMoreBottomSheet(
  BuildContext context,
) {
  showModalBottomSheet(
      enableDrag: true,
      isDismissible: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return CardMoreBottomSheet();
      });
}
