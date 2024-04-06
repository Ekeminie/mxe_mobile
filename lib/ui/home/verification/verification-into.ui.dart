import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/enum/fundtype-enum.dart';
import 'package:mxe_mobile/core/enum/status-enum.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/ui/home/verification/verification.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/select-currency-bottomsheet.dart';

class VerificationIntroPage extends StatefulWidget {
  const VerificationIntroPage({Key? key}) : super(key: key);

  @override
  State<VerificationIntroPage> createState() => _VerificationIntroPageState();
}

class _VerificationIntroPageState extends State<VerificationIntroPage> {
  ValueNotifier<InsightsTimeLineEnum> timeline =
      ValueNotifier(InsightsTimeLineEnum.sevenDays);

  ValueNotifier<Currency> currency = ValueNotifier(Currency.ngn);
  ValueNotifier<FundType> fundType = ValueNotifier(FundType.cardPayment);

  @override
  Widget build(BuildContext context) {
    return BaseView<VerificationViewModel>(
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors.darkBgColor,
        appBar: AppBar(
          leading: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.white,
            ),
          ),
          backgroundColor: AppColors.darkBgColor,
          elevation: 0,
        ),
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: AutoSizeText(
                  """Almost there!
We know you are Odafe.
We just need to be
sure it’s really you.""",
                  style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 32.sp,
                      color: AppColors.white),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  38.sbH,
                  AutoSizeText(
                    """MXE is required by law to verify your identity before you can make transactions.

To verify you, we need;

      •   Picture of your ID (National ID, International 
            Passport or Driver’s License.
      •   Your BVN
      •   A Selfie\n""",
                    style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: AppColors.white),
                  ),
                  24.sbH,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      "MAKE SURE THAT:\n",
                      style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.white),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: AppColors.accentColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        ValueListenableBuilder(
                          valueListenable: fundType,
                          builder: (context, type, _) => Column(
                              children: [
                            "Your ID hasn’t expired",
                            "It’s entirely in the frame",
                            "All details can be seen",
                          ]
                                  .map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2.0),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset('tick'.svg),
                                          16.sbW,
                                          AutoSizeText(
                                            e,
                                            style: GoogleFonts.plusJakartaSans(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList()),
                        ),
                      ],
                    ),
                  ),
                  36.sbH,
                  UiButton(
                    color: AppColors.subtleAccent,
                    textColor: AppColors.bgContrast,
                    text: "Next",
                    onPressed: () => {},
                  ),
                  24.sbH,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
