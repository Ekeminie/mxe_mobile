import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/constant/palette.dart';
import 'package:mxe_mobile/core/enum/fundtype-enum.dart';
import 'package:mxe_mobile/core/enum/status-enum.dart';
import 'package:mxe_mobile/core/model/insights-model.dart';
import 'package:mxe_mobile/core/services/app-cache.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/ui/home/insights/insights.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/doghnut-chart.dart';
import 'package:visibility_detector/visibility_detector.dart';

class InsightsItem extends StatefulWidget {
  List<dynamic> list;
  TransferCurrency? currency;
  InsightsItem({Key? key, required this.list, this.currency}) : super(key: key);

  @override
  _InsightsItemState createState() => _InsightsItemState();
}

class _InsightsItemState extends State<InsightsItem> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<InsightsViewModel>(
      onModelReady: (m) => m.getInsights(widget.currency!),
      builder: (context, model, child) => VisibilityDetector(
        key: const Key('customers'),
        onVisibilityChanged: (visibilityInfo) {
          if (visibilityInfo.visibleFraction == 1) {}
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: white,
          body:
              // ? Column(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       54.sbH,
              //       Center(child: SvgPicture.asset('empty-icon'.svg)),
              //       48.sbH,
              //       AutoSizeText(
              //         "It's Empty here",
              //         style: GoogleFonts.plusJakartaSans(
              //             fontWeight: FontWeight.w700,
              //             fontSize: 16.sp,
              //             color: AppColors.bgContrast),
              //       )
              //     ],
              //   )
              Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Container(
                    padding: EdgeInsets.all(16.r),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 300,
                          width: 500,
                          child: ValueListenableBuilder(
                            valueListenable: appCache.insightModel,
                            builder: (context, insights, _) => ChartsPage(
                                key: Key(widget.currency!.code!),
                                data: InsightsEnum.values
                                    .map((e) => ChartData(
                                        e.title!,
                                        (getAmount(e.code!, insights!)
                                            .toDouble())))
                                    .toList()),
                          ),
                        ),
                        ...InsightsEnum.values.map((e) => Column(
                              children: [
                                12.sbH,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: 12.h,
                                          width: 12.w,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: e.color),
                                        ),
                                        6.sbW,
                                        AutoSizeText(
                                          e.title!,
                                          style: GoogleFonts.plusJakartaSans(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.sp,
                                              color: AppColors.bgContrast),
                                        )
                                      ],
                                    ),
                                    ValueListenableBuilder(
                                      valueListenable: appCache.insightModel,
                                      builder: (context, insights, _) =>
                                          AutoSizeText(
                                        "${getCurrencySign(widget.currency?.code ?? "")} ${getAmount(e.code!, insights!)}",
                                        style: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14.sp,
                                            color: AppColors.bgContrast),
                                      ),
                                    )
                                  ],
                                ),
                                12.sbH,
                                const Divider(),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    )
        // )
        ;
  }

  int getAmount(String code, InsightAndStatsModel model) {
    switch (code) {
      case "income":
        return model.income ?? 0;
      case "bill_payments":
        return model.billPayments ?? 0;
      case "Withdrawals":
        return 1000; //model.withdrawals ?? 0;
      default:
        return model.income ?? 0;
    }
  }
}
