import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/enum/bills-enum.dart';
import 'package:mxe_mobile/core/enum/fundtype-enum.dart';
import 'package:mxe_mobile/core/enum/status-enum.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/ui/bills/bills.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';
import 'package:mxe_mobile/widgets/select-currency-bottomsheet.dart';

class BillsPage extends StatefulWidget {
  const BillsPage({Key? key}) : super(key: key);

  @override
  State<BillsPage> createState() => _BillsPageState();
}

class _BillsPageState extends State<BillsPage> {
  ValueNotifier<InsightsTimeLineEnum> timeline =
      ValueNotifier(InsightsTimeLineEnum.sevenDays);

  ValueNotifier<Currency> currency = ValueNotifier(Currency.ngn);
  ValueNotifier<FundType> fundType = ValueNotifier(FundType.cardPayment);

  bool newUser = true;
  bool verified = true;

  @override
  Widget build(BuildContext context) {
    return BaseView<BillsViewModel>(
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: customAppBar("", bgColor: AppColors.bgColor),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const IHeader(
                title: "Pay Bills",
                subTitle: "What bill do you want to pay?",
              ),
              32.sbH,
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    ...BillsEnum.values.map((e) => GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => Navigator.pushNamed(context,
                              "/${e.code.toString().toLowerCase()}PageRoute"),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Row(
                              children: [
                                SvgPicture.asset(e.image.toString().svg),
                                16.sbW,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        e.title!,
                                        style: GoogleFonts.plusJakartaSans(
                                            color: AppColors.bgContrast,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.sp),
                                      ),
                                      10.sbH,
                                      Text(
                                        e.sub!,
                                        style: GoogleFonts.plusJakartaSans(
                                            color: AppColors.textLight,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.sp),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.keyboard_arrow_right)
                              ],
                            ),
                          ),
                        ))
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
