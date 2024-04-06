import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/constant/palette.dart';
import 'package:mxe_mobile/core/enum/fundtype-enum.dart';
import 'package:mxe_mobile/core/enum/status-enum.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/cards/card.vm.dart';
import 'package:mxe_mobile/ui/cards/widgets/more-actions-bottomsheet.dart';
import 'package:mxe_mobile/ui/cards/widgets/new-card-widget.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/dual-action-sheet.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';
import 'package:mxe_mobile/widgets/select-currency-bottomsheet.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  ValueNotifier<InsightsTimeLineEnum> timeline =
      ValueNotifier(InsightsTimeLineEnum.sevenDays);

  ValueNotifier<Currency> currency = ValueNotifier(Currency.ngn);
  ValueNotifier<FundType> fundType = ValueNotifier(FundType.cardPayment);

  bool newUser = true;
  bool verified = true;

  @override
  Widget build(BuildContext context) {
    return BaseView<CardViewModel>(
        onModelReady: (m) => m.getCards(),
        builder: (context, model, child) => ValueListenableBuilder(
            valueListenable: model.appCache.cardModel!,
            builder: (context, card, _) => card.userId.isNotNullNorEmpty
                ? ManageCardPage()
                : const NewCardWidget())); //ManageCardPage();
  }
}

class ManageCardPage extends StatelessWidget {
  ManageCardPage({
    super.key,
  });

  ValueNotifier<Color> color = ValueNotifier(Color(0xff0D0D0D));
  ValueNotifier<String?> text = ValueNotifier(null);
  ValueNotifier<bool> visibility = ValueNotifier(false);
  ValueNotifier<FundType> fundType = ValueNotifier(FundType.cardPayment);

  @override
  Widget build(BuildContext context) {
    return BaseView<CardViewModel>(
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar:
            customAppBar("", bgColor: AppColors.bgColor, showBackButton: false),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header("Virtual Card", usePadding: false),
              32.sbH,
              ValueListenableBuilder(
                  valueListenable: model.appCache.cardModel!,
                  builder: (context, card, _) => Stack(
                        children: [
                          SvgPicture.asset(
                            'test-card'.svg,
                            color: Color(int.parse(card.cardColor ?? "")),
                          ),
                          Blur(
                            blur: card.freezeStatus ?? false,
                            child: Center(
                              child: SvgPicture.asset(
                                'cardmap'.svg,
                                color: white.withOpacity(0.35),
                              ),
                            ),
                          ),
                          Positioned(
                              right: 20,
                              bottom: 10,
                              child: Blur(
                                  blur: card.freezeStatus ?? false,
                                  child:
                                      SvgPicture.asset('mastercard-logo'.svg))),
                          Positioned(
                            left: 20,
                            bottom: 30,
                            child: ValueListenableBuilder(
                              valueListenable: text,
                              builder: (context, name, _) => Blur(
                                blur: card.freezeStatus ?? false,
                                child: AutoSizeText(
                                  card.nameOncard ?? "",
                                  style: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18.sp,
                                      color: AppColors.white),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 20,
                            top: 95,
                            child: ValueListenableBuilder(
                              valueListenable: visibility,
                              builder: (context, show, _) => GestureDetector(
                                onTap: () =>
                                    visibility.value = !visibility.value,
                                child: Blur(
                                  blur: card.freezeStatus ?? false,
                                  child: SvgPicture.asset(
                                      (show ? 'visible-icon' : 'invisible-icon')
                                          .svg),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 20,
                            top: 30,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Blur(
                                  blur: card.freezeStatus ?? false,
                                  child: AutoSizeText(
                                    "\$${0 ?? ""}",
                                    style: GoogleFonts.plusJakartaSans(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 32.sp,
                                        color: AppColors.white),
                                  ),
                                ),
                                30.sbH,
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ValueListenableBuilder(
                                      valueListenable: visibility,
                                      builder: (context, show, _) => Blur(
                                        blur: card.freezeStatus ?? false,
                                        child: AutoSizeText(
                                          show
                                              ? "1234 1234 1234 1234"
                                              : "1234 •••• •••• ••••",
                                          style: GoogleFonts.plusJakartaSans(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18.sp,
                                              color: AppColors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                20.sbH,
                                Blur(
                                  blur: card.freezeStatus ?? false,
                                  child: AutoSizeText(
                                    "Exp 03/24",
                                    style: GoogleFonts.plusJakartaSans(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18.sp,
                                        color: AppColors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (card.freezeStatus ?? false)
                            Positioned(
                                left: 0,
                                right: 0,
                                top: 0,
                                bottom: 0,
                                child: Container(
                                    alignment: Alignment.center,
                                    child: GestureDetector(
                                      onTap: () => dualActionSheets(
                                        context,
                                        onTap: () =>
                                            model.freezeCard(pop: false),
                                        title: "Unfreeze Card ? ",
                                        actionTitle: "Unfreeze",
                                        subTitle:
                                            "Do you want to unfreeze this card?",
                                      ),
                                      child: Container(
                                        width: 100,
                                        height: 50,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 16),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            color: AppColors.subtleAccent),
                                        child: Text(
                                          'Unfreeze',
                                          style: GoogleFonts.plusJakartaSans(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16.sp,
                                              color: AppColors.moderateBlue),
                                        ),
                                      ),
                                    ))),
                        ],
                      )),
              16.sbH,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CardActionWidget(
                      title: "Topup",
                      icon: 'card-topup',
                      onTap: () => Navigator.pushNamed(
                          context, Routes.fundVirtualCardPageRoute)),
                  CardActionWidget(
                      title: "Withdraw",
                      icon: 'card-withdraw',
                      onTap: () => Navigator.pushNamed(
                          context, Routes.withdrawFromVirtualCardPageRoute)),
                  CardActionWidget(
                      title: "More",
                      icon: 'card-more',
                      onTap: () => cardMoreBottomSheet(context))
                ],
              ),
              16.sbH,
              AutoSizeText(
                "Transactions",
                style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 18.sp,
                    color: AppColors.bgContrast),
              ),
              Spacer(),
              Center(
                child: AutoSizeText(
                  "No transactions",
                  style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: AppColors.bgContrast),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class CardActionWidget extends StatelessWidget {
  final String title;
  final String icon;
  final Function() onTap;
  const CardActionWidget(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
              color: AppColors.subtleAccent,
              borderRadius: BorderRadius.circular(24)),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              SvgPicture.asset(icon.svg),
              8.sbW,
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w700, fontSize: 16),
              )
            ],
          )),
    );
  }
}

class Blur extends StatelessWidget {
  final Widget child;
  final bool blur;
  const Blur({super.key, required this.child, this.blur = false});

  @override
  Widget build(BuildContext context) {
    return blur
        ? ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            child: child,
          )
        : child;
  }
}
