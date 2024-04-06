import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/enum/status-enum.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/ui/beneficiary/transfer-beneficiary.dart';
import 'package:mxe_mobile/ui/bills/bills-beneficiaries/bills-beneficiaries.ui.dart';
import 'package:mxe_mobile/ui/home/notification/notification.vm.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';

class BeneficiariesTabPage extends StatefulWidget {
  const BeneficiariesTabPage({Key? key}) : super(key: key);

  @override
  State<BeneficiariesTabPage> createState() => _BeneficiariesTabPageState();
}

class _BeneficiariesTabPageState extends State<BeneficiariesTabPage> {
  ValueNotifier<InsightsTimeLineEnum> timeline =
      ValueNotifier(InsightsTimeLineEnum.sevenDays);
  bool empty = false;
  @override
  Widget build(BuildContext context) {
    return BaseView<NotificationsViewModel>(
      builder: (context, model, child) => DefaultTabController(
          length: 2,
          child: Scaffold(
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
                      "Beneficiaries",
                      style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 24.sp,
                          color: AppColors.bgContrast),
                    ),
                  ),
                ),
                28.sbH,
                TabBar(
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
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(18.0)),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  indicatorPadding: const EdgeInsets.all(2),
                  labelPadding: EdgeInsets.zero,
                  labelColor: AppColors.bgContrast,
                  unselectedLabelColor: AppColors.textLight,
                  tabs: [
                    Tab(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 2.h),
                        child: const SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'Transfers',
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
                              'Bill Payments',
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
                      TransferBeneficiaries(
                        showAppbar: false,
                      ),
                      // TransferBeneficiariesListPage(
                      //   key: const Key('tranfer'),
                      //   list: const ["Abel Amos", "Tasha Ben", "Vicky Traore"],
                      // ),
                      BillsBeneficiaries(
                        showAppbar: false,
                      )
                      // NotificationsListPage(
                      //     key: const Key('requests'),
                      //     title: 'requests',
                      //     list: const []
                      //     // : const [
                      //     //     NotificationsType.fundRequest,
                      //     //     NotificationsType.declineRequest,
                      //     //     NotificationsType.acceptRequest,
                      //     //   ],
                      //     ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
