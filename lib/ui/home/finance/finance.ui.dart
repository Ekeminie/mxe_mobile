import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/constant/constants.dart';
import 'package:mxe_mobile/core/services/app-cache.dart';
import 'package:mxe_mobile/core/services/user.service.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/home/finance/finance.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/ad-banner.dart';
import 'package:mxe_mobile/widgets/select-currency-bottomsheet.dart';

class FinancePage extends StatefulWidget {
  const FinancePage({super.key});

  @override
  State<FinancePage> createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<FinanceViewModel>(
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
                        Text(
                          "Welcome ${user.firstName}",
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          decoration: BoxDecoration(
                              color: AppColors.border,
                              borderRadius: BorderRadius.circular(12)),
                          child: Text(
                            "${user.MXETag}",
                            style: GoogleFonts.plusJakartaSans(),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              34.sbH,
              ValueListenableBuilder(
                valueListenable: model.show,
                builder: (context, view, _) => ClipRRect(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColors.black,
                        borderRadius: BorderRadius.circular(32)),
                    child: Stack(
                      children: [
                        view
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 3),
                                child: SvgPicture.asset(
                                  'card-bg-design'.svg,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(32),
                                child: SvgPicture.asset(
                                  'layer2'.svg,
                                ),
                              ),
                        Positioned(
                          right: 0,
                          left: 0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              22.sbH,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Available Balance",
                                    style: GoogleFonts.plusJakartaSans(
                                        color: AppColors.textLight,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                  20.sbW,
                                  view
                                      ? GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () => {
                                                model.show.value =
                                                    (!model.show.value),
                                                model.updateUser()
                                              },
                                          child: SvgPicture.asset(
                                              'visible-icon'.svg))
                                      : GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () => {
                                                model.show.value =
                                                    (!model.show.value),
                                                model.updateUser()
                                              },
                                          child: SvgPicture.asset(
                                              'invisible-icon'.svg)),
                                ],
                              ),
                              10.sbH,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ValueListenableBuilder(
                                    valueListenable: uService.userCredentials,
                                    builder: (context, user, _) => AutoSizeText(
                                      view
                                          ? formatPrice(
                                              user.walletBalance.toString())
                                          : "$nairaSign••••••",
                                      style: GoogleFonts.plusJakartaSans(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 32),
                                    ),
                                  ),
                                  20.sbW,
                                  GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () =>
                                          showSelectCurrencyBottomSheet(
                                              context),
                                      child:
                                          SvgPicture.asset('chevron-down'.svg)),
                                ],
                              ),
                              10.sbH,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () => Navigator.pushNamed(
                                            context,
                                            Routes.fundAccountPageRoute),
                                        child: Container(
                                            padding: const EdgeInsets.all(18),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: AppColors.white
                                                      .withOpacity(0.2)),
                                              color: const Color(0xffd193650),
                                            ),
                                            child: SvgPicture.asset(
                                                'deposit-icon'.svg)),
                                      ),
                                      12.sbH,
                                      AutoSizeText(
                                        "Deposit",
                                        style: GoogleFonts.plusJakartaSans(
                                            color: AppColors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  18.sbW,
                                  Column(
                                    children: [
                                      GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () => Navigator.pushNamed(
                                            context,
                                            Routes.sendFundsAccountPageRoute),
                                        child: Container(
                                            padding: const EdgeInsets.all(18),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: AppColors.white
                                                        .withOpacity(0.2)),
                                                color: const Color(0xffd193650)
                                                // AppColors.white.withOpacity(0.2)
                                                ),
                                            child: SvgPicture.asset(
                                                'send-icon'.svg)),
                                      ),
                                      10.sbH,
                                      AutoSizeText(
                                        "Send",
                                        style: GoogleFonts.plusJakartaSans(
                                            color: AppColors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              16.sbH,
                              if (view)
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 16),
                                  decoration: BoxDecoration(
                                      color: AppColors.bgContrast,
                                      borderRadius: BorderRadius.circular(18)),
                                  child: Row(
                                    children: [
                                      const InflowOrOutflow(
                                          inflow: true, amount: "1000000"),
                                      const Spacer(),
                                      Container(
                                        height: 30,
                                        width: 1,
                                        color: AppColors.white,
                                      ),
                                      const Spacer(),
                                      const InflowOrOutflow(
                                          inflow: false, amount: "1000000")
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              24.sbH,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ActionItem(
                        onTap: () => Navigator.pushNamed(
                            context, Routes.requestFundsPageRoute),
                        title: "Request",
                        icon: "request-icon"),
                    ActionItem(
                        onTap: () => Navigator.pushNamed(
                            context, Routes.saveInUsdPageRoute),
                        title: "Save in USD",
                        icon: "save-usd-icon"),
                    ActionItem(
                        onTap: () =>
                            Navigator.pushNamed(context, Routes.billsPageRoute),
                        title: "Pay Bills",
                        icon: "pay-bills-icon"),
                    ActionItem(
                        onTap: () => Navigator.pushNamed(
                            context, Routes.convertFundsPageRoute),
                        title: "Convert",
                        icon: "convert-icon")
                  ],
                ),
              ),
              8.sbH,
              BannerImages(
                banner: ['ad-banner'.png, 'ad-banner'.png],
              ),
              24.sbH,
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                        color: AppColors.moderateBlue, shape: BoxShape.circle),
                  ),
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
                margin: const EdgeInsets.only(bottom: 8),
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
                margin: const EdgeInsets.only(bottom: 8),
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
                margin: const EdgeInsets.only(bottom: 8),
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
                margin: const EdgeInsets.only(bottom: 8),
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
                margin: const EdgeInsets.only(bottom: 8),
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
