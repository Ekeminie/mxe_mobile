import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/ui/home/deposit/add-card/share-bottomsheet.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';

class TransactionDetails extends StatelessWidget {
  const TransactionDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: customAppBar(
        "",
        bgColor: AppColors.bgColor,
      ),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          32.sbH,
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Material(
              borderRadius: BorderRadius.circular(12),
              elevation: 2,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    32.sbH,
                    SvgPicture.asset('mxe'.svg),
                    24.sbH,
                    AutoSizeText(
                      "Transaction Amount",
                      style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: AppColors.textLight),
                    ),
                    10.sbH,
                    AutoSizeText(
                      "NGN ${formatPrice("10000").substring(1)}",
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                    ),
                    24.sbH,
                    AutoSizeText(
                      "16 November, 9:41 AM",
                      style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.textLight),
                    ),
                    12.sbH,
                    24.sbH,
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                          color: AppColors.successBg,
                          borderRadius: BorderRadius.circular(12)),
                      child: AutoSizeText(
                        "Successful",
                        style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: AppColors.success),
                      ),
                    ),
                    24.sbH,
                    Container(
                      height: 2,
                      width: double.infinity,
                      color: AppColors.border,
                    ),
                    24.sbH,
                    Row(
                      children: [
                        const TransactionItem(
                            title: "Transaction Type", value: "Wallet Funding"),
                        16.sbW,
                        const TransactionItem(
                            title: "Ref Number", value: "000085752257"),
                      ],
                    ),
                    16.sbH,
                    Row(
                      children: [
                        const TransactionItem(title: "Source", value: "Card"),
                        16.sbW,
                        const TransactionItem(
                            title: "Details", value: "****52343"),
                      ],
                    ),
                    32.sbH,
                  ],
                ),
              ),
            ),
          ),
          32.sbH,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => shareBottomSheet(context),
                child: Column(
                  children: [
                    SvgPicture.asset('share'.svg),
                    4.sbH,
                    AutoSizeText(
                      "Share Receipt",
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
                onTap: () => shareBottomSheet(context),
                child: Column(
                  children: [
                    SvgPicture.asset('report'.svg),
                    4.sbH,
                    AutoSizeText(
                      "Report an Issue",
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class TransactionItem extends StatelessWidget {
  final String title;
  final String value;
  const TransactionItem({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.border, width: 2),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AutoSizeText(
              title,
              style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: AppColors.textLight),
            ),
            8.sbH,
            AutoSizeText(
              value,
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
