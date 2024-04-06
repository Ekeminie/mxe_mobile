import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/core/services/user.service.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/textstyles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';
import 'package:mxe_mobile/widgets/transaction-pin/bills-pin.dart';
import 'package:mxe_mobile/widgets/transaction-success/transaction-success-widget.dart';

class SaveInUsdConfirmationPage extends StatefulWidget {
  final Map<String, dynamic> map;
  const SaveInUsdConfirmationPage({super.key, required this.map});

  @override
  State<SaveInUsdConfirmationPage> createState() =>
      _SaveInUsdConfirmationPageState();
}

class _SaveInUsdConfirmationPageState extends State<SaveInUsdConfirmationPage> {
  ValueNotifier<bool> show = ValueNotifier(true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        "",
      ),
      body: Container(
        // decoration: const BoxDecoration(color: AppColors.bgColor),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              header("Transaction Summary", usePadding: false),
              32.sbH,
              const AutoSizeText(
                "Payment Method",
                style: AppTextStyle.headingHeading3,
              ),
              12.sbH,
              Row(
                children: [
                  SvgPicture.asset('visa'.svg),
                  16.sbW,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Visa - 3758",
                        style: AppTextStyle.paragraphMd,
                      ),
                      12.sbH,
                      Text(
                        "Debit Card",
                        style: AppTextStyle.paragraphXs
                            .copyWith(color: AppColors.textLight),
                      )
                    ],
                  )
                ],
              ),
              25.sbH,
              const AutoSizeText(
                "Transaction Details",
                style: AppTextStyle.headingHeading3,
              ),
              23.sbH,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Deposit Amount",
                    style: AppTextStyle.labelSmRegular,
                  ),
                  Text(
                    "\$ ${widget.map['amount']}",
                    style: AppTextStyle.labelSmRegular,
                  ),
                ],
              ),
              const Divider(),
              12.sbH,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Rate",
                    style: AppTextStyle.labelSmRegular,
                  ),
                  Text(
                    "${formatPrice("1000")}",
                    style: AppTextStyle.labelSmRegular,
                  ),
                ],
              ),
              24.sbH,
              const Divider(),
              16.sbH,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: AppTextStyle.labelMdBold,
                  ),
                  Text(
                    "${formatPrice("1000")}",
                    style: AppTextStyle.labelMdBold,
                  ),
                ],
              ),
              24.sbH,
              const Divider(),
            ],
          ),
        ),
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: UiButton(
              text: "Continue",
              onPressed: () => showNewTransferPinBottomSheet(context,
                  onCompleted: (c) => uService.transactionPin = c,
                  onDone: () => Navigator.pushNamed(
                      context, Routes.transactionSuccessPageRoute,
                      arguments: SuccessData(
                          amount: widget.map['amount'].toString(),
                          title: "Transaction Successful",
                          transType: "Conversion",
                          recipient: "",
                          subTitle:
                              "You have successfully saved  USD${widget.map['amount'].toString()}"))),
            ),
          ),
          54.sbH,
        ],
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
