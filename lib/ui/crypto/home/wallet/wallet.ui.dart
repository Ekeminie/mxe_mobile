import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/services/app-cache.dart';
import 'package:mxe_mobile/core/services/user.service.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/textstyles.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/crypto/home/wallet/wallet.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';

class CryptoWalletPage extends StatefulWidget {
  const CryptoWalletPage({super.key});

  @override
  State<CryptoWalletPage> createState() => _CryptoWalletPageState();
}

class _CryptoWalletPageState extends State<CryptoWalletPage> {
  bool showBackup = true;
  @override
  Widget build(BuildContext context) {
    return BaseView<CryptoWalletViewModel>(
      onModelReady: (m) => m.init(),
      builder: (context, model, child) => SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(color: AppColors.bgColor),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              12.sbH,
              Row(
                children: [
                  SvgPicture.asset('avatar'.svg),
                  8.sbW,
                  ValueListenableBuilder(
                    valueListenable: uService.userCredentials,
                    builder: (context, user, _) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Wallet A ${user.firstName}",
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                            14.sbW,
                            SvgPicture.asset(
                              'chevron-down'.svg,
                              color: AppColors.bgContrast,
                            )
                          ],
                        ),
                        12.sbH,
                        Row(
                          children: [
                            Text(
                              "KH02k*****",
                              style: AppTextStyle.paragraphSm
                                  .copyWith(color: AppColors.bgContrast),
                            ),
                            14.sbW,
                            SvgPicture.asset('copy-small'.svg)
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              12.sbH,
              AutoSizeText(
                "\$0",
                style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w700, fontSize: 32),
              ),
              if (showBackup) 16.sbH,
              if (showBackup) SvgPicture.asset("backup-info".svg),
              24.sbH,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ActionItem(
                        onTap: () => Navigator.pushNamed(
                            context, Routes.requestFundsPageRoute),
                        title: "Sell",
                        icon: "c_sell"),
                    ActionItem(
                        onTap: () => Navigator.pushNamed(
                            context, Routes.saveInUsdPageRoute),
                        title: "Send",
                        icon: "c_send"),
                    ActionItem(
                        onTap: () =>
                            Navigator.pushNamed(context, Routes.billsPageRoute),
                        title: "Receive",
                        icon: "c_receive"),
                    ActionItem(
                        onTap: () => Navigator.pushNamed(
                            context, Routes.convertFundsPageRoute),
                        title: "Swap",
                        icon: "c_swap")
                  ],
                ),
              ),
              16.sbH,
              SvgPicture.asset('empty-watchlist'.svg),
              16.sbH,
              Container(
                height: 150.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'mxe-academy'.png,
                        ),
                        fit: BoxFit.fill)),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      "Understanding Blockchain Technology",
                      style: AppTextStyle.headingHeading4
                          .copyWith(color: AppColors.white),
                    ),
                  ),
                ),
              ),
              24.sbH,
              Row(
                children: [
                  'Investing 101: Investing Strategies',
                  'Decentralized Applications (DApps) - How it works'
                ]
                    .map((e) => Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 22),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColors.subtleAccent),
                            child: Flexible(
                              child: Column(
                                children: [
                                  Text(
                                    e,
                                    style: AppTextStyle.labelXsBold,
                                  ),
                                  24.sbH,
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: AppColors.moderateBlue,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
              12.sbH,
              50.sbH,
            ],
          ),
        ),
      ),
    );
  }
}

class ActionItem extends StatelessWidget {
  final String title;
  final String icon;
  final Function() onTap;
  const ActionItem(
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
            style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w400, fontSize: 12),
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
    return ValueListenableBuilder(
      valueListenable: getIt<AppCache>().inflowAndOutflow,
      builder: (context, data, _) => Column(
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
            inflow
                ? formatPrice((data?.inflow ?? 0).toString())
                : formatPrice((data?.outtflow ?? 0).toString()),
            style: GoogleFonts.plusJakartaSans(
                color: AppColors.white,
                fontWeight: FontWeight.w700,
                fontSize: 16),
          ),
        ],
      ),
    );
  }
}
