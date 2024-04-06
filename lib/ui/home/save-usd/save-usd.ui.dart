import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/textstyles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';

class SaveInUsdPage extends StatefulWidget {
  const SaveInUsdPage({super.key});

  @override
  State<SaveInUsdPage> createState() => _SaveInUsdPageState();
}

class _SaveInUsdPageState extends State<SaveInUsdPage> {
  ValueNotifier<bool> show = ValueNotifier(true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("", bgColor: AppColors.bgColor),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(color: AppColors.bgColor),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header("Save in USD", usePadding: false),
              34.sbH,
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(32)),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: SvgPicture.asset(
                        'usd-bg'.svg,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      left: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            22.sbH,
                            Text(
                              "Balance",
                              style: AppTextStyle.paragraphSm.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                            10.sbH,
                            AutoSizeText(
                              "${getCurrencySign("usd")}${formatPrice("100000").substring(1)}",
                              style: GoogleFonts.plusJakartaSans(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 32),
                            ),
                            20.sbH,
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () => Navigator.pushNamed(
                                  context, Routes.depositSaveInUsdPageRoute),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.subtleAccent),
                                child: Text(
                                  "Save",
                                  style: AppTextStyle.labelXsBold
                                      .copyWith(color: AppColors.moderateBlue),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              24.sbH,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ActionItem1(
                        onTap: () => Navigator.pushNamed(
                            context, Routes.depositSaveInUsdPageRoute),
                        title: "Deposit USD",
                        icon: "usd-deposit"),
                    ActionItem1(
                        onTap: () => Navigator.pushNamed(
                            context, Routes.withdrawSaveInUsdPageRoute),
                        title: "Withdraw",
                        icon: "usd-deposit"),
                  ],
                ),
              ),
              32.sbH,
              Row(
                children: [
                  4.sbW,
                  AutoSizeText(
                    "Recent Activities",
                    style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                ],
              ),
              12.sbH,
              Container(
                margin: EdgeInsets.only(bottom: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(
                      "Top up",
                      style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                    AutoSizeText(
                      "+NGN ${formatPrice("1000").substring(1).replaceAll(".00", "")}",
                      style: GoogleFonts.plusJakartaSans(
                          color: Colors.green,
                          fontWeight: FontWeight.w700,
                          fontSize: 14),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(
                      "Top up",
                      style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                    AutoSizeText(
                      "+NGN ${formatPrice("1000").substring(1).replaceAll(".00", "")}",
                      style: GoogleFonts.plusJakartaSans(
                          color: Colors.green,
                          fontWeight: FontWeight.w700,
                          fontSize: 14),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(
                      "Top up",
                      style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                    AutoSizeText(
                      "+NGN ${formatPrice("1000").substring(1).replaceAll(".00", "")}",
                      style: GoogleFonts.plusJakartaSans(
                          color: Colors.green,
                          fontWeight: FontWeight.w700,
                          fontSize: 14),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(
                      "Top up",
                      style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                    AutoSizeText(
                      "+NGN ${formatPrice("1000").substring(1).replaceAll(".00", "")}",
                      style: GoogleFonts.plusJakartaSans(
                          color: Colors.green,
                          fontWeight: FontWeight.w700,
                          fontSize: 14),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(
                      "Top up",
                      style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                    AutoSizeText(
                      "+NGN ${formatPrice("1000").substring(1).replaceAll(".00", "")}",
                      style: GoogleFonts.plusJakartaSans(
                          color: Colors.green,
                          fontWeight: FontWeight.w700,
                          fontSize: 14),
                    ),
                  ],
                ),
              ),
              50.sbH,
            ],
          ),
        ),
      ),
    );
  }
}

class ActionItem1 extends StatelessWidget {
  final String title;
  final String icon;
  final Function() onTap;
  const ActionItem1(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(icon.svg),
          4.sbH,
          AutoSizeText(
            title,
            style: AppTextStyle.paragraphXs.copyWith(
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }
}

class InflowOrOutflow extends StatelessWidget {
  final bool inflow;
  final String amount;
  const InflowOrOutflow(
      {super.key, required this.inflow, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: inflow ? Colors.green : Colors.red),
            ),
            4.sbW,
            AutoSizeText(
              inflow ? "Inflow" : "Outflow",
              style: GoogleFonts.plusJakartaSans(
                  color: AppColors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 12),
            ),
          ],
        ),
        AutoSizeText(
          formatPrice(amount),
          style: GoogleFonts.plusJakartaSans(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
              fontSize: 16),
        ),
      ],
    );
  }
}
