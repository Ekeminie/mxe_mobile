import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/constant/palette.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/ui/home/insights/insights.vm.dart';
import 'package:mxe_mobile/ui/home/notification/notification-bottomsheet.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:visibility_detector/visibility_detector.dart';

class BillPaymentBeneficiariesListPage extends StatefulWidget {
  List<dynamic> list;
  String? title;
  BillPaymentBeneficiariesListPage({Key? key, required this.list, this.title})
      : super(key: key);

  @override
  _TransferBeneficiariesListPageState createState() =>
      _TransferBeneficiariesListPageState();
}

class _TransferBeneficiariesListPageState
    extends State<BillPaymentBeneficiariesListPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<InsightsViewModel>(
      builder: (context, model, child) => VisibilityDetector(
        key: const Key('customers'),
        onVisibilityChanged: (visibilityInfo) {
          if (visibilityInfo.visibleFraction == 1) {}
        },
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: white,
            body: widget.list.isEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      54.sbH,
                      Center(child: SvgPicture.asset('empty-icon'.svg)),
                      48.sbH,
                      AutoSizeText(
                        "It's Empty here",
                        style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                            color: AppColors.bgContrast),
                      )
                    ],
                  )
                : Column(
                    children: [
                      24.sbH,
                      ...widget.list
                          .map((e) => GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () => widget.title == 'requests'
                                    ? showNotificationBottomSheet(context, e)
                                    : null,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 20),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(e.icon.toString().svg),
                                      16.sbW,
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AutoSizeText(
                                              e.title,
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w400),
                                            ),
                                            10.sbH,
                                            AutoSizeText(
                                              e.title,
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color:
                                                          AppColors.textLight),
                                            )
                                          ],
                                        ),
                                      ),
                                      if (e.trailing != null)
                                        SvgPicture.asset(
                                            e.trailing.toString().svg)
                                    ],
                                  ),
                                ),
                              ))
                          .toList()
                    ],
                  )),
      ),
    )
        // )
        ;
  }
}
