import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/utils/string%20utils.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/bottomsheet-widgets.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';

class AccountDetailsBottomSheet extends StatelessWidget {
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
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  behavior: HitTestBehavior.opaque,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: SvgPicture.asset('close-icon'.svg)),
                ),
                34.0.sbH,
                const IHeader(
                  title: "Account Details",
                  subTitle:
                      "This is your unique MXE account number used to receive money from local banks in Nigeria.",
                ),
                32.0.sbH,
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: {
                      "Account Number": "12345678",
                      "Account Name": "Test Account",
                      "Bank": "FCMB",
                      "Account Type": "Savings"
                    }
                        .entries
                        .map((e) => Padding(
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    e.key,
                                    style: GoogleFonts.plusJakartaSans(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: AppColors.textLight),
                                  ),
                                  (e.key == "Account Number")
                                      ? Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              (e.value.toString()),
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                              ),
                                            ),
                                            4.sbW,
                                            GestureDetector(
                                                behavior:
                                                    HitTestBehavior.opaque,
                                                onTap: () =>
                                                    copyToClipBoard(e.value),
                                                child: SvgPicture.asset(
                                                    'copy-small'.svg))
                                          ],
                                        )
                                      : Text(
                                          (e.value.toString()),
                                          style: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                          ),
                                        )
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ),
                48.sbH,
                Container(
                  margin: EdgeInsets.symmetric(vertical: 12),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: {
                      "secure": "Your funds are held in a licensed bank.",
                      "local-banks":
                          "You can only transfer for local banks in Nigeria.",
                      "hourglass":
                          "Once the transferring bank approves your transaction, your account will be funded instantly.",
                    }
                        .entries
                        .map((e) => Padding(
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    e.key.svg,
                                  ),
                                  8.sbW,
                                  Flexible(
                                    child: Text(
                                      (e.value.toString()),
                                      style: GoogleFonts.plusJakartaSans(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ),
                10.sbH,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

showAccountDetailBottomSheet(
  BuildContext context,
) {
  showModalBottomSheet(
      enableDrag: true,
      isDismissible: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return AccountDetailsBottomSheet();
      });
}
