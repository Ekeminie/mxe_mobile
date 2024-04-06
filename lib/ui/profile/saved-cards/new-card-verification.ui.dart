import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/enum/status-enum.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/profile/saved-cards/saved-card.vm.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/input.dart';
import 'package:mxe_mobile/widgets/select-currency-bottomsheet.dart';

class NewCardVerificationPage extends StatefulWidget {
  const NewCardVerificationPage({Key? key}) : super(key: key);

  @override
  State<NewCardVerificationPage> createState() =>
      _NewCardVerificationPageState();
}

class _NewCardVerificationPageState extends State<NewCardVerificationPage> {
  ValueNotifier<InsightsTimeLineEnum> timeline =
      ValueNotifier(InsightsTimeLineEnum.sevenDays);

  ValueNotifier<Currency> currency = ValueNotifier(Currency.ngn);
  ValueNotifier<bool> saveCard = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return BaseView<SavedCardViewModel>(
      builder: (context, model, child) => Scaffold(
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
                  "New Card Verification",
                  style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 24.sp,
                      color: AppColors.bgContrast),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  32.sbH,
                  const AutoSizeText(
                      "To ensure the security of your new card, a small transaction has been done on your card labeled 'MXE Card Verification'."),
                  const AutoSizeText(
                      "\n\n Confirm the first 3-digits of the reference number to validate and finalize the addition of your card to MXE."),
                  48.sbH,
                  Input(
                    autofocus: false,
                    hintText: "Reference Number",
                    readOnly: false,
                    onChanged: (v) => model.setReference(v),
                  ),
                  24.sbH,
                  36.sbH,
                  UiButton(
                    text: "Verify",
                    onPressed: model.hasReference
                        ? () => Navigator.pushNamed(
                            context, Routes.fundAccountSuccessPageRoute)
                        : null,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
