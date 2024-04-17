import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/textstyles.dart';
import 'package:mxe_mobile/ui/crypto/trade/giftcard-trade/giftcard.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';

class GiftSuccessPage extends StatefulWidget {
  const GiftSuccessPage({super.key});

  @override
  State<GiftSuccessPage> createState() => _GiftSuccessPageState();
}

class _GiftSuccessPageState extends State<GiftSuccessPage> {
  ValueNotifier<int> page = ValueNotifier(0);
  ValueNotifier<int> progress = ValueNotifier(1);
  @override
  Widget build(BuildContext context) {
    return BaseView<GiftCardViewModel>(
      builder: (context, model, child) => Scaffold(
        appBar: customAppBar(
          "",
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: ValueListenableBuilder(
            valueListenable: page,
            builder: (context, index, _) => Builder(
              builder: (context) {
                switch (index) {
                  case 0:
                    return ValueListenableBuilder(
                      valueListenable: progress,
                      builder: (context, position, _) => Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ProgressCircle(index: position),
                          32.sbH,
                          const Text(
                            "Your Gift Card Sale is Pending",
                            style: AppTextStyle.labelLgBold,
                          ),
                          32.sbH,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Confirming Transaction ",
                                style: AppTextStyle.paragraphMd,
                              ),
                              Text(
                                "10:59",
                                style: AppTextStyle.paragraphMd
                                    .copyWith(color: AppColors.moderateBlue),
                              ),
                            ],
                          ),
                          32.sbH,
                          CustomProgressBar(index: position),
                          32.sbH,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "\$",
                                style: GoogleFonts.plusJakartaSans().copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                              4.sbW,
                              Text(
                                formatPrice("40").substring(1),
                                style: AppTextStyle.headingHeading1,
                              ),
                            ],
                          ),
                          16.sbH,
                          Text(
                            "iTunes Gift Card",
                            style: AppTextStyle.paragraphMd
                                .copyWith(color: AppColors.textLight),
                          ),
                          32.sbH,
                          const Center(
                            child: Text(
                              "You can leave here. We will email you once the status of your sale changes",
                              style: AppTextStyle.labelSmRegular,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          40.sbH,
                          UiButton(
                            text: "Done",
                            onPressed: () => page.value = 1,
                          ),
                          40.sbH,
                        ],
                      ),
                    );
                  case 1:
                    return ValueListenableBuilder(
                      valueListenable: progress,
                      builder: (context, position, _) => Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            "Transaction Successful",
                            style: AppTextStyle.labelLgBold,
                          ),
                          32.sbH,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "\$",
                                style: GoogleFonts.plusJakartaSans().copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                              4.sbW,
                              Text(
                                formatPrice("40").substring(1),
                                style: AppTextStyle.headingHeading1,
                              ),
                            ],
                          ),
                          16.sbH,
                          Text(
                            "iTunes Gift Card",
                            style: AppTextStyle.paragraphMd
                                .copyWith(color: AppColors.textLight),
                          ),
                          32.sbH,
                          const Center(
                            child: Text(
                              "Your account has been funded.",
                              style: AppTextStyle.labelSmRegular,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          40.sbH,
                          UiButton(
                            text: "Done",
                            onPressed: () => Navigator.pop(context),
                          ),
                          16.sbH,
                          UiButton(
                            text: "View Transaction",
                            color: AppColors.subtleAccent,
                            textColor: AppColors.moderateBlue,
                            onPressed: () {},
                          ),
                          40.sbH,
                        ],
                      ),
                    );
                  default:
                    return const SizedBox.shrink();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ProgressCircle extends StatelessWidget {
  final int index;

  const ProgressCircle({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: index > 0,
            child: body()),
        8.sbW,
        Visibility(
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: index > 1,
            child: body()),
        8.sbW,
        Visibility(
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: index > 2,
            child: body())
      ],
    );
  }

  Container body() {
    return Container(
      height: 20,
      width: 20,
      decoration: const BoxDecoration(
          shape: BoxShape.circle, color: AppColors.moderateBlue),
    );
  }
}

class CustomProgressBar extends StatelessWidget {
  final int index;

  CustomProgressBar({required this.index});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double progressWidth;
    Color progressColor;

    switch (index) {
      case 1:
        progressWidth = screenWidth / 3;
        progressColor = AppColors.moderateBlue;
        break;
      case 2:
        progressWidth = (screenWidth / 3) * 2;
        progressColor = AppColors.moderateBlue;
        break;
      case 3:
        progressWidth = screenWidth;
        progressColor = AppColors.moderateBlue;
        break;
      default:
        throw Exception("Invalid index value");
    }

    return Container(
      width: screenWidth,
      height: 3,
      decoration: BoxDecoration(
        color: AppColors.subtleAccent,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        children: [
          Container(
            width: progressWidth,
            height: 2,
            decoration: BoxDecoration(
              color: progressColor,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ],
      ),
    );
  }
}
