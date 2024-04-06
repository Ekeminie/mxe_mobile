import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/enum/status-enum.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/home/deposit/add-card/card.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/input.dart';
import 'package:mxe_mobile/widgets/select-currency-bottomsheet.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({Key? key}) : super(key: key);

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  ValueNotifier<InsightsTimeLineEnum> timeline =
      ValueNotifier(InsightsTimeLineEnum.sevenDays);

  ValueNotifier<Currency> currency = ValueNotifier(Currency.ngn);
  ValueNotifier<bool> saveCard = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return BaseView<AddCardViewModel>(
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: customAppBar("", bgColor: AppColors.bgColor, actions: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 20,
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                  color: AppColors.subtleAccent,
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: Text(
                  "Edit Amount",
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.boldSemantic),
                ),
              ),
            ),
          )
        ]),
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: AutoSizeText(
                  "Fund Account",
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
                              AutoSizeText(
                                "Amount you will Pay",
                                style: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: AppColors.textLight),
                              ),
                              8.sbH,
                              AutoSizeText(
                                "NGN ${formatPrice("10000").substring(1)}",
                                style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                ),
                              ),
                              16.sbH,
                              Input(
                                autofocus: false,
                                hintText: "Name on Card",
                                labelText: "Name on Card",
                                readOnly: false,
                                onChanged: (v) => model.setName(v),
                              ),
                              16.sbH,
                              Input(
                                autofocus: false,
                                hintText: "Card Number",
                                labelText: "Card Number",
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
                                      autofocus: false,
                                      hintText: "Expiry",
                                      labelText: "Expiry",
                                      readOnly: false,
                                      onChanged: (v) => model.setExpiry(v),
                                    ),
                                  ),
                                  16.sbW,
                                  Expanded(
                                    child: Input(
                                      autofocus: false,
                                      hintText: "CVV",
                                      labelText: "CVV",
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
                              ValueListenableBuilder(
                                valueListenable: saveCard,
                                builder: (context, save, _) => Row(
                                  children: [
                                    Checkbox(
                                      value: save,
                                      onChanged: (b) => saveCard.value = b!,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      checkColor: AppColors.white,
                                      activeColor: AppColors.moderateBlue,
                                    ),
                                    const Text("Save this card"),
                                  ],
                                ),
                              ),
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
                    text: "Fund Now",
                    onPressed: model.hasValidInputs
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
