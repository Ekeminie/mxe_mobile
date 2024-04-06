import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class AddNewCardPage extends StatefulWidget {
  const AddNewCardPage({Key? key}) : super(key: key);

  @override
  State<AddNewCardPage> createState() => _AddNewCardPageState();
}

class _AddNewCardPageState extends State<AddNewCardPage> {
  ValueNotifier<InsightsTimeLineEnum> timeline =
      ValueNotifier(InsightsTimeLineEnum.sevenDays);

  final TextEditingController name = TextEditingController();
  final TextEditingController cardNo = TextEditingController();
  final TextEditingController expiry = TextEditingController();
  final TextEditingController cvv = TextEditingController();

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
                  "Add New Card",
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
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              32.sbH,
                              Input(
                                controller: name,
                                autofocus: false,
                                hintText: "Name on Card",
                                // labelText: "Name on Card",
                                readOnly: false,
                                onChanged: (v) => model.setName(v),
                              ),
                              16.sbH,
                              Input(
                                controller: cardNo,
                                autofocus: false,
                                hintText: "Card Number",
                                // labelText: "Card Number",
                                readOnly: false,
                                onChanged: (v) => model.setNo(v),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                              ),
                              16.sbH,
                              Row(
                                children: [
                                  Expanded(
                                    child: Input(
                                      controller: expiry,
                                      autofocus: false,
                                      hintText: "Expiry",
                                      // labelText: "Expiry",
                                      readOnly: false,
                                      onChanged: (v) => model.setExpiry(v),
                                    ),
                                  ),
                                  16.sbW,
                                  Expanded(
                                    child: Input(
                                      controller: cvv,
                                      autofocus: false,
                                      hintText: "CVV",
                                      // labelText: "CVV",
                                      readOnly: false,
                                      onChanged: (v) => model.setCVV(v),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              16.sbH,
                            ],
                          ),
                        ),
                        Container(
                          height: 2,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: AppColors.moderateBlue,
                              borderRadius: BorderRadius.circular(8)),
                        )
                      ],
                    ),
                  ),
                  24.sbH,
                  36.sbH,
                  UiButton(
                    text: "Save this Card",
                    onPressed: model.hasValidInputs
                        ? () => Navigator.pushNamed(
                            context, Routes.newCardVerificationPageRoute)
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
