import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/ui/home/notification/notificationListItem.dart';
import 'package:mxe_mobile/utils/string%20utils.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';

class BeneficiariesBottomSheet extends StatelessWidget {
  final NotificationsType type;
  BeneficiariesBottomSheet({Key? key, required this.type}) : super(key: key);

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
        color: Colors.white,
        // height: 500,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              24.sbH,
              SvgPicture.asset((type.icon!.split("-")[2]).svg),
              8.sbH,
              AutoSizeText(
                "16 November, 2023 - 9:41 AM",
                style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w400, fontSize: 14.sp),
              ),
              8.0.sbH,
              24.0.sbH,
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Transaction Type',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      type.title!,
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Status',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      type.icon!.splitMapJoin("-")[2],
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w400,
                        color: type.color,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              if (type == NotificationsType.acceptRequest)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Reference Number',
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "1231321321",
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                          4.sbW,
                          GestureDetector(
                              onTap: () => copyToClipBoard("data"),
                              behavior: HitTestBehavior.opaque,
                              child: SvgPicture.asset('copy-small'.svg))
                        ],
                      ),
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Amount ',
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      formatPrice("1000"),
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              32.sbH,
            ],
          ),
        ),
      ),
    );
  }
}

showNotificationBottomSheet(
    BuildContext context, NotificationsType notification) {
  showModalBottomSheet(
      enableDrag: true,
      isDismissible: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BeneficiariesBottomSheet(type: notification);
      });
}
