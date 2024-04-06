import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/textstyles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/profile/schedule-payment/schedule-payment.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';

class SchedulePaymentListPage extends StatefulWidget {
  const SchedulePaymentListPage({Key? key}) : super(key: key);

  @override
  State<SchedulePaymentListPage> createState() =>
      _SchedulePaymentListPageState();
}

class _SchedulePaymentListPageState extends State<SchedulePaymentListPage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<SchedulePaymentViewModel>(
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: customAppBar(
          "",
          bgColor: AppColors.bgColor,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header("Scheduled Payment", usePadding: false),
              24.sbH,
              ...{"DSTV": 'dstv', "IKEDC": 'electricity/ekedc'}
                  .entries
                  .map((e) => GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => Navigator.pushNamed(
                            context, Routes.editSchedulePaymentRoute),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 16),
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: Image.asset(
                                  e.value.toString().png,
                                  width: 48,
                                  height: 48,
                                ),
                              ),
                              20.sbW,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AutoSizeText(e.key),
                                  4.sbH,
                                  AutoSizeText(
                                    "Frequency - Every month",
                                    style: AppTextStyle.labelSmRegular
                                        .copyWith(color: AppColors.textLight),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ))
                  .toList(),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    24.sbH,
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
