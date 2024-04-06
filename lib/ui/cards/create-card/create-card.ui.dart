import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/constant/palette.dart';
import 'package:mxe_mobile/core/enum/fundtype-enum.dart';
import 'package:mxe_mobile/core/enum/status-enum.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/ui/cards/card.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';
import 'package:mxe_mobile/widgets/input.dart';

class CreateCardPage extends StatefulWidget {
  const CreateCardPage({super.key});

  @override
  State<CreateCardPage> createState() => _CreateCardPageState();
}

class _CreateCardPageState extends State<CreateCardPage> {
  ValueNotifier<InsightsTimeLineEnum> timeline =
      ValueNotifier(InsightsTimeLineEnum.sevenDays);

  ValueNotifier<String?> text = ValueNotifier(null);
  ValueNotifier<bool> visibility = ValueNotifier(false);
  ValueNotifier<FundType> fundType = ValueNotifier(FundType.cardPayment);

  bool newUser = true;
  bool verified = true;

  @override
  Widget build(BuildContext context) {
    return BaseView<CardViewModel>(
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar:
            customAppBar("", bgColor: AppColors.bgColor, showBackButton: true),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header("Create Virtual Card", usePadding: false),
              32.sbH,
              ValueListenableBuilder(
                  valueListenable: model.color,
                  builder: (context, selectedColor, _) => Stack(
                        children: [
                          SvgPicture.asset(
                            'test-card'.svg,
                            color: selectedColor,
                          ),
                          Center(
                            child: SvgPicture.asset(
                              'cardmap'.svg,
                              color: white.withOpacity(0.3),
                            ),
                          ),
                          Positioned(
                              right: 20,
                              bottom: 10,
                              child: SvgPicture.asset('mastercard-logo'.svg)),
                          Positioned(
                            left: 20,
                            bottom: 30,
                            child: ValueListenableBuilder(
                              valueListenable: text,
                              builder: (context, name, _) => AutoSizeText(
                                "${name ?? ""}",
                                style: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18.sp,
                                    color: AppColors.white),
                              ),
                            ),
                          ),
                        ],
                      )),
              32.sbH,
              AutoSizeText(
                "Pick Card Color",
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 16, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
              4.sbH,
              ValueListenableBuilder(
                valueListenable: model.color,
                builder: (context, selectedColor, _) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: model.colors
                      .map((e) => GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => model.color.value = e,
                            child: Stack(
                              children: [
                                Container(
                                  height: selectedColor == e ? 42 : 32,
                                  width: selectedColor == e ? 42 : 32,
                                  decoration: BoxDecoration(
                                      border: selectedColor == e
                                          ? Border.all(
                                              color: AppColors.moderateBlue,
                                              width: 5)
                                          : null,
                                      color: e,
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                if (selectedColor == e)
                                  Positioned(
                                      right: 0,
                                      left: 0,
                                      bottom: 0,
                                      top: 0,
                                      child: SvgPicture.asset(
                                        'check-white'.svg,
                                        height: 11,
                                        width: 16,
                                        fit: BoxFit.scaleDown,
                                      )),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
              24.sbH,
              Input(
                // controller: model.phoneNumberController,
                hintText: "Name on Card",
                onChanged: (v) => {text.value = v, model.setCardName(v)},
              ),
              32.sbH,
              16.sbH,
              UiButton(
                  text: "Continue",
                  onPressed: model.cardName.isNotNullNorEmpty
                      ? () => model.createCard()
                      : null),
            ],
          ),
        ),
      ),
    );
  }
}
