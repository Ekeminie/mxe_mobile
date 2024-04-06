import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/textstyles.dart';
import 'package:mxe_mobile/ui/bills/electricity/schedule-payment-type.dart';
import 'package:mxe_mobile/ui/profile/schedule-payment/schedule-payment.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/dual-action-sheet.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';

class EditSchedulePaymentPage extends StatefulWidget {
  const EditSchedulePaymentPage({Key? key}) : super(key: key);

  @override
  State<EditSchedulePaymentPage> createState() =>
      _EditSchedulePaymentPageState();
}

class _EditSchedulePaymentPageState extends State<EditSchedulePaymentPage> {
  ValueNotifier<bool> faceId = ValueNotifier(true);
  @override
  Widget build(BuildContext context) {
    return BaseView<SchedulePaymentViewModel>(
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: customAppBar("", bgColor: AppColors.bgColor, actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: GestureDetector(
              onTap: () => dualActionSheets(context,
                  title: "Stop this scheduled payment",
                  subTitle:
                      "Your recurring payment for this bill will be stopped. You will have to manually pay if you stop this schedule",
                  actionTitle: "Stop",
                  icon: "stop".svg,
                  onTap: () => Navigator.pop(context)),
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                    color: AppColors.errorCode,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    AutoSizeText(
                      "Stop Schedule",
                      style: AppTextStyle.labelMdBold
                          .copyWith(color: AppColors.white),
                    ),
                    8.sbW,
                    SvgPicture.asset('t_delete'.svg)
                  ],
                ),
              ),
            ),
          ),
          16.sbW,
        ]),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(
                "Scheduled Payment",
                usePadding: false,
              ),
              24.sbH,
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    24.sbH,
                    Center(
                      child: Image.asset('dstv'.png),
                    ),
                    24.sbH,
                    GestureDetector(
                      onTap: () => showElectricityScheduleBottomSheet(context,
                          onTap: (v) => model.setSchedule(v),
                          old: model.scheduleType.value),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.border,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            model.scheduleType.value != null
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText(
                                        "      Schedule Frequency",
                                        style: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.sp,
                                            color: AppColors.textLight),
                                      ),
                                      2.sbH,
                                      Text(
                                        "    Every ${model.scheduleType.value!.name.toCapitalized()}",
                                        style: GoogleFonts.plusJakartaSans(
                                            color: AppColors.bgContrast,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.sp),
                                      ),
                                    ],
                                  )
                                : AutoSizeText(
                                    "      Schedule Frequency",
                                    style: GoogleFonts.plusJakartaSans(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.sp,
                                        color: AppColors.bgContrast),
                                  ),
                          ],
                        ),
                      ),
                    ),
                    16.sbH,
                    Row(
                      children: [
                        ValueListenableBuilder(
                          valueListenable: faceId,
                          builder: (context, show, _) => CupertinoSwitch(
                              value: show,
                              onChanged: (v) => faceId.value = v,
                              activeColor: AppColors.moderateBlue),
                        ),
                        16.sbW,
                        const AutoSizeText(
                          "Set Reminder",
                          style: AppTextStyle.paragraphMd,
                        )
                      ],
                    )
                  ],
                ),
              ),
              16.sbH,
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: const AutoSizeText(
                        "Next Payments",
                        style: AppTextStyle.paragraphMd,
                      ),
                    ),
                    16.sbH,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: model.formattedDates
                          .map((e) => Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 8),
                                decoration: BoxDecoration(
                                    color: AppColors.subtleAccent,
                                    borderRadius: BorderRadius.circular(12)),
                                child: AutoSizeText(
                                  e,
                                  style: AppTextStyle.labelXsBold
                                      .copyWith(color: AppColors.moderateBlue),
                                ),
                              ))
                          .toList(),
                    )
                  ],
                ),
              ),
              24.sbH,
              const Align(
                alignment: Alignment.centerLeft,
                child: AutoSizeText(
                  "   Recent Payments",
                  style: AppTextStyle.headingHeading4,
                ),
              ),
              24.sbH,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    SvgPicture.asset('reload'.svg),
                    16.sbW,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AutoSizeText(
                          "Compact Plus",
                          style: AppTextStyle.labelMdRegular,
                        ),
                        8.sbH,
                        AutoSizeText(
                          "24 October - 12:00 AM",
                          style: AppTextStyle.labelSmRegular
                              .copyWith(color: AppColors.textLight),
                        )
                      ],
                    ),
                    Spacer(),
                    AutoSizeText(
                      "NGN 12,500",
                      style: AppTextStyle.labelMdRegular
                          .copyWith(color: Colors.greenAccent),
                    )
                  ],
                ),
              ),
              24.sbH,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    SvgPicture.asset('reload'.svg),
                    16.sbW,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AutoSizeText(
                          "Compact Plus",
                          style: AppTextStyle.labelMdRegular,
                        ),
                        8.sbH,
                        AutoSizeText(
                          "24 October - 12:00 AM",
                          style: AppTextStyle.labelSmRegular
                              .copyWith(color: AppColors.textLight),
                        )
                      ],
                    ),
                    const Spacer(),
                    AutoSizeText(
                      "NGN 12,500",
                      style: AppTextStyle.labelMdRegular
                          .copyWith(color: Colors.greenAccent),
                    )
                  ],
                ),
              ),
              24.sbH,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    SvgPicture.asset('reload'.svg),
                    16.sbW,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AutoSizeText(
                          "Compact Plus",
                          style: AppTextStyle.labelMdRegular,
                        ),
                        8.sbH,
                        AutoSizeText(
                          "24 October - 12:00 AM",
                          style: AppTextStyle.labelSmRegular
                              .copyWith(color: AppColors.textLight),
                        )
                      ],
                    ),
                    Spacer(),
                    AutoSizeText(
                      "NGN 12,500",
                      style: AppTextStyle.labelMdRegular
                          .copyWith(color: Colors.greenAccent),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
