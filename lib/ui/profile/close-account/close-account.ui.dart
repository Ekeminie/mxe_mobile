import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/enum/status-enum.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/textstyles.dart';
import 'package:mxe_mobile/ui/profile/saved-cards/saved-card.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/input.dart';
import 'package:mxe_mobile/widgets/select-currency-bottomsheet.dart';

class CloseAccountPage extends StatefulWidget {
  const CloseAccountPage({Key? key}) : super(key: key);

  @override
  State<CloseAccountPage> createState() => _CloseAccountPageState();
}

class _CloseAccountPageState extends State<CloseAccountPage> {
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
                  "Before closing your account, here are some things to bear in mind.",
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
                  ...[
                    "You won’t be able to open another account for 6 months",
                    "Your virtual card connected to your account will be cancelled",
                    "Ensure you move all your funds and/or crypto assets so you don’t lose your funds"
                  ]
                      .map((e) => Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                SvgPicture.asset('bullet-arrow'.svg),
                                16.sbW,
                                Flexible(
                                    child: AutoSizeText(
                                  e,
                                  style: AppTextStyle.labelMdRegular,
                                )),
                              ],
                            ),
                          ))
                      .toList(),
                  48.sbH,
                  Align(
                      alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        "Please type “DELETE” in all caps below",
                        style: AppTextStyle.headingHeading5.copyWith(
                            color: model.error.isNotNullNorEmpty
                                ? AppColors.errorCode
                                : AppColors.bgContrast),
                      )),
                  4.sbH,
                  Input(
                    errorText: model.error,
                    autofocus: false,
                    hintText: "DELETE",
                    readOnly: false,
                    onChanged: (v) => model.setDeleteText(v),
                  ),
                  24.sbH,
                  36.sbH,
                  UiButton(
                    text: "Delete",
                    onPressed: model.deleteText.isNotNullNorEmpty
                        ? () => model.checkDeletionText()
                        : null,
                    color: AppColors.errorCode,
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
