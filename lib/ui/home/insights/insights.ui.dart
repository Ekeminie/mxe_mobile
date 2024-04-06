import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/enum/fundtype-enum.dart';
import 'package:mxe_mobile/core/services/app-cache.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/ui/home/insights/InsightsItem.dart';
import 'package:mxe_mobile/ui/home/insights/insights.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/insights-timeline-sheet.dart';

class InsightsTabPage extends StatefulWidget {
  const InsightsTabPage({Key? key}) : super(key: key);

  @override
  State<InsightsTabPage> createState() => _InsightsTabPageState();
}

class _InsightsTabPageState extends State<InsightsTabPage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<InsightsViewModel>(
      onModelReady: (m) => m.getInsights(TransferCurrency.ngn),
      builder: (context, model, child) => DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: customAppBar(
              "",
            ),
            body: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: AutoSizeText(
                      "Insights",
                      style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 24.sp,
                          color: AppColors.bgContrast),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => showSelectInsightTimelineSheet(context,
                        onSelected: (c) => model.sortTimeFrame(c),
                        old: appCache.insightTimeline.value),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(24)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset('sort-insights'.svg),
                          6.sbW,
                          ValueListenableBuilder(
                            valueListenable: appCache.insightTimeline,
                            builder: (context, time, _) => AutoSizeText(
                              time.title ?? "",
                              style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.sp,
                                  color: AppColors.bgContrast),
                            ),
                          ),
                          2.sbW,
                          SvgPicture.asset('chevron-down'.svg),
                          16.sbW
                        ],
                      ),
                    ),
                  ),
                ),
                28.sbH,
                TabBar(
                  onTap: (v) => print(v),
                  enableFeedback: false,
                  automaticIndicatorColorAdjustment: false,
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: MaterialStateProperty.resolveWith(
                    (Set states) {
                      return states.contains(MaterialState.focused)
                          ? null
                          : Colors.transparent;
                    },
                  ),
                  // indicatorWeight: 0,
                  indicatorSize: TabBarIndicatorSize.tab,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  indicatorPadding: const EdgeInsets.all(2),
                  labelPadding: EdgeInsets.zero,
                  labelColor: AppColors.moderateBlue,

                  unselectedLabelColor: AppColors.textLight,
                  tabs: [
                    Tab(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        child: const SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'NGN',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        child: const SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'USD',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        child: const SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'GBP',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      InsightsItem(
                        key: const Key('ngn'),
                        list: const [],
                        currency: TransferCurrency.ngn,
                      ),
                      InsightsItem(
                        key: const Key('usd'),
                        list: const [],
                        currency: TransferCurrency.usd,
                      ),
                      InsightsItem(
                        key: const Key('gbp'),
                        list: const [],
                        currency: TransferCurrency.gbp,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
