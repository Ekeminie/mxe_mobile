import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/ui/bills/airtime/airtime.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';
import 'package:mxe_mobile/widgets/transaction-pin/bills-pin.dart';

class ReviewAirtimePage extends StatefulWidget {
  const ReviewAirtimePage({Key? key}) : super(key: key);

  @override
  State<ReviewAirtimePage> createState() => _ReviewAirtimePageState();
}

class _ReviewAirtimePageState extends State<ReviewAirtimePage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<BuyAirtimeViewModel>(
      onModelReady: (m) => m.get(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: customAppBar(
          "",
          bgColor: AppColors.bgColor,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header('Review Transaction'),
              32.sbH,
              Center(
                child: SvgPicture.asset(
                  model.network.value.image.toString().svg,
                  width: 85.w,
                  height: 85.h,
                  fit: BoxFit.fill,
                ),
              ),
              24.sbH,
              Center(
                child: AutoSizeText(
                  "NGN ${model.amount.formatMoney}",
                  style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 24.sp,
                      color: AppColors.bgContrast),
                ),
              ),
              8.sbH,
              Center(
                child: AutoSizeText(
                  "Below is your airtime top up summary",
                  style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: AppColors.textLight),
                ),
              ),
              32.sbH,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AutoSizeText(
                          "Network Provider",
                          style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: AppColors.textLight),
                        ),
                        AutoSizeText(
                          "${model.network.value.title}",
                          style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.sp,
                              color: AppColors.bgContrast),
                        ),
                      ],
                    ),
                    Divider()
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AutoSizeText(
                          "Phone Number",
                          style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: AppColors.textLight),
                        ),
                        AutoSizeText(
                          "${model.phone}",
                          style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.sp,
                              color: AppColors.bgContrast),
                        ),
                      ],
                    ),
                    Divider()
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AutoSizeText(
                          "Status",
                          style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: AppColors.textLight),
                        ),
                        StatusWidget()
                      ],
                    ),
                    Divider()
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AutoSizeText(
                          "Fees",
                          style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: AppColors.textLight),
                        ),
                        AutoSizeText(
                          "NGN ${model.amount.formatMoney}",
                          style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.sp,
                              color: AppColors.bgContrast),
                        ),
                      ],
                    ),
                    Divider()
                  ],
                ),
              ),
              54.sbH,
              UiButton(
                text: "Continue",
                onPressed: () => showNewTransferPinBottomSheet(context,
                    onCompleted: (c) => model.userService.transactionPin = c,
                    onDone: () => model.buyAirtime()
                    // Navigator.pushNamed(
                    // context, Routes.transactionSuccessPageRoute,
                    // arguments: SuccessData(
                    //     amount: model.amount.toString(),
                    //     title: "Your Airtime Purchase was Successful",
                    //     transType: "Airtime Top-up",
                    //     recipient: model.phone.toString(),
                    //     subTitle:
                    //         "You have successfully purchased  NGN ${model.amount} airtime on ${model.phone}"))
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class StatusWidget extends StatelessWidget {
  const StatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
          color: AppColors.unpaidStatusBg,
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(
            height: 12,
            width: 12,
            decoration: BoxDecoration(
                color: AppColors.moderateBlue, shape: BoxShape.circle),
          ),
          8.sbW,
          Text(
            "Unpaid",
            style: GoogleFonts.plusJakartaSans(
                color: AppColors.moderateBlue,
                fontSize: 16,
                fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}
