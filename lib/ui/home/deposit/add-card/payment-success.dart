import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/enum/status-enum.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/home/deposit/add-card/card.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/select-currency-bottomsheet.dart';

class FundPaymentSuccess extends StatefulWidget {
  const FundPaymentSuccess({Key? key}) : super(key: key);

  @override
  State<FundPaymentSuccess> createState() => _FundPaymentSuccessState();
}

class _FundPaymentSuccessState extends State<FundPaymentSuccess> {
  ValueNotifier<InsightsTimeLineEnum> timeline =
      ValueNotifier(InsightsTimeLineEnum.sevenDays);

  ValueNotifier<Currency> currency = ValueNotifier(Currency.ngn);
  ValueNotifier<bool> saveCard = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return BaseView<AddCardViewModel>(
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: customAppBar(
          "",
          bgColor: AppColors.bgColor,
        ),
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: AutoSizeText(
                  "Payment Successful",
                  style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 24.sp,
                      color: AppColors.bgContrast),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  32.sbH,
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        250.sbH,
                        AutoSizeText(
                          "Your account has been funded with",
                          style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: AppColors.textLight),
                        ),
                        8.sbH,
                        AutoSizeText(
                          "NGN ${formatPrice("10000").substring(1)}",
                          style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                          ),
                        ),
                        16.sbH,
                        UiButton(
                          text: "Continue",
                          onPressed: () => {},
                        ),
                        16.sbH,
                        UiButton(
                          color: AppColors.accentColor,
                          text: "View Transaction Details",
                          onPressed: () => Navigator.pushNamed(context,
                              Routes.fundAccountTransactionsDetailsPageRoute),
                          textColor: AppColors.moderateBlue,
                        )
                      ],
                    ),
                  ),
                  24.sbH,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
