import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/core/model/notification-reponse.dart';
import 'package:mxe_mobile/ui/home/notification/notificationListItem.dart';
import 'package:mxe_mobile/utils/string%20utils.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';

class NotificationBottomSheet extends StatelessWidget {
  final NotificationModel type;
  NotificationBottomSheet({Key? key, required this.type}) : super(key: key);

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
              SvgPicture.asset("topup".svg),
              8.sbH,
              Text(
                "${type.creationDate!.formatDateTime} ",
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
                      type.subject ?? "",
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
                      type.status ?? "",
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w400,
                        color: getColor(type.status!),
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
                      formatPrice(type.amount!.toString()),
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
    BuildContext context, NotificationModel notificationModel) {
  showModalBottomSheet(
      enableDrag: true,
      isDismissible: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return NotificationBottomSheet(type: notificationModel);
      });
}

Color getColor(String c) {
  switch (c) {
    case "pending":
      return Color(0xFFE6BF00);
    default:
      return Color(0xFFE6BF00);
  }
}
