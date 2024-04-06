import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/enum/fundtype-enum.dart';
import 'package:mxe_mobile/core/enum/status-enum.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/home/verification/verification.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/select-currency-bottomsheet.dart';

class TransactionSuccessPage extends StatefulWidget {
  final SuccessData data;
  const TransactionSuccessPage({Key? key, required this.data})
      : super(key: key);

  @override
  State<TransactionSuccessPage> createState() => _TransactionSuccessPageState();
}

class _TransactionSuccessPageState extends State<TransactionSuccessPage> {
  ValueNotifier<InsightsTimeLineEnum> timeline =
      ValueNotifier(InsightsTimeLineEnum.sevenDays);

  ValueNotifier<Currency> currency = ValueNotifier(Currency.ngn);
  ValueNotifier<FundType> fundType = ValueNotifier(FundType.cardPayment);

  @override
  Widget build(BuildContext context) {
    return BaseView<VerificationViewModel>(
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors.darkBgColor,
        body: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              38.sbH,
              Animate(
                effects: const [
                  FadeEffect(
                      duration: Duration(milliseconds: 700),
                      curve: Curves.bounceInOut),
                  ScaleEffect(
                      duration: Duration(milliseconds: 700),
                      curve: Curves.bounceInOut)
                ],
                child: SvgPicture.asset('success'.svg),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: AutoSizeText(
                    widget.data.title ??
                        """Your Airtime Purchase was Successful""",
                    style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 32.sp,
                        color: AppColors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    28.sbH,
                    AutoSizeText(
                      widget.data.subTitle ??
                          """You have successfully purchased  NGN 2000 airtime on +2341234567890""",
                      style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: AppColors.white),
                      textAlign: TextAlign.center,
                    ),
                    24.sbH,
                    if (widget.data.token != null)
                      Column(
                        children: [
                          AutoSizeText(
                            """Your electricity token:""",
                            style: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: AppColors.white),
                            textAlign: TextAlign.center,
                          ),
                          6.sbH,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AutoSizeText(
                                widget.data.token ?? """ """,
                                style: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24.sp,
                                    color: AppColors.white),
                                textAlign: TextAlign.center,
                              ),
                              12.sbW,
                              SvgPicture.asset('copy-white'.svg)
                            ],
                          ),
                          24.sbH,
                        ],
                      ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: AppColors.unpaidStatusBg,
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          ValueListenableBuilder(
                            valueListenable: fundType,
                            builder: (context, type, _) => Column(
                                children: {
                              if (widget.data.transType != null)
                                "Transaction Type": widget.data.transType,
                              "Amount": widget.data.amount,
                              if (widget.data.recipient.isNotNullNorEmpty)
                                "Recipient": widget.data.recipient,
                              if (widget.data.meterNo.isNotNullNorEmpty)
                                "Meter No": widget.data.meterNo,
                              if (widget.data.smartCard.isNotNullNorEmpty)
                                "Decoder No": widget.data.smartCard,
                              if (widget.data.userID.isNotNullNorEmpty)
                                "User ID": widget.data.userID,
                            }
                                    .entries
                                    .map(
                                      (e) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            AutoSizeText(
                                              e.key,
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                              ),
                                            ),
                                            16.sbW,
                                            AutoSizeText(
                                              e.value.toString(),
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList()),
                          ),
                        ],
                      ),
                    ),
                    42.sbH,
                    UiButton(
                      color: AppColors.moderateBlue,
                      textColor: AppColors.white,
                      text: "Home",
                      onPressed: () => Navigator.pushNamedAndRemoveUntil(
                          context, Routes.homeRoute, (route) => false),
                    ),
                    16.sbH,
                    UiButton(
                      color: AppColors.subtleAccent,
                      textColor: AppColors.moderateBlue,
                      text: "Share Receipt",
                      onPressed: () => Navigator.pushNamed(context,
                          Routes.fundAccountTransactionsDetailsPageRoute),
                    ),
                    24.sbH,
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget failure() => Scaffold(
      backgroundColor: AppColors.darkBgColor,
      body: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(),
          SvgPicture.asset('failure'.svg),
          Spacer(),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: AutoSizeText(
                """Your Airtime Purchase was not Successful""",
                style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w700,
                    fontSize: 32.sp,
                    color: AppColors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const Spacer(),
          UiButton(
            color: AppColors.moderateBlue,
            textColor: AppColors.white,
            text: "Try Again",
            onPressed: () => {},
          ),
          const Spacer(
            flex: 3,
          ),
        ],
      ),
    );

class SuccessData {
  String? title;
  String? subTitle;
  String? amount;
  String? transType;
  String? recipient;
  String? meterNo;
  String? token;
  String? smartCard;
  String? userID;
  SuccessData(
      {this.title,
      this.subTitle,
      this.amount,
      this.recipient,
      this.transType,
      this.meterNo,
      this.token,
      this.smartCard,
      this.userID});
}
