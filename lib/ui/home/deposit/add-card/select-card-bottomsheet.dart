import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/bottomsheet-widgets.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';

class SelectCurrencyBottomSheet extends StatefulWidget {
  Function(CardBrand)? onTap;
  CardBrand? old;
  SelectCurrencyBottomSheet({Key? key, this.onTap, this.old}) : super(key: key);

  @override
  State<SelectCurrencyBottomSheet> createState() =>
      _SelectCurrencyBottomSheetState();
}

class _SelectCurrencyBottomSheetState extends State<SelectCurrencyBottomSheet> {
  ValueNotifier<CardBrand> cardBrand = ValueNotifier(CardBrand.visa);
  @override
  void initState() {
    super.initState();
    if (widget.old != null) {
      cardBrand = ValueNotifier(widget.old!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      child: Container(
        padding: EdgeInsets.only(
            // right: 20,
            // left: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        color: Colors.white,
        // height: 500,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              12.sbH,
              SheetHandle(),
              16.0.sbH,
              Align(
                alignment: Alignment.centerLeft,
                child: AutoSizeText(
                  "Saved Cards",
                  style: GoogleFonts.plusJakartaSans(
                      color: AppColors.bgContrast,
                      fontWeight: FontWeight.w700,
                      fontSize: 24.sp),
                ),
              ),
              24.0.sbH,
              ...CardBrand.values
                  .map((e) => GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          cardBrand.value = e;
                          Navigator.pushReplacementNamed(
                              context, Routes.fundAccountSuccessPageRoute);
                          widget.onTap!(e);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          margin: EdgeInsets.only(bottom: 12.h),
                          decoration: BoxDecoration(
                              color: AppColors.bgColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.border)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(e.name.svg),
                                  16.sbW,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "NGN Wallet",
                                        style: GoogleFonts.plusJakartaSans(
                                            color: AppColors.bgContrast,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.sp),
                                      ),
                                      4.sbH,
                                      Text(
                                        "Available Balance - NGN 49,000.00",
                                        style: GoogleFonts.plusJakartaSans(
                                            color: AppColors.bgContrast,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14.sp),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              ValueListenableBuilder(
                                  valueListenable: cardBrand,
                                  builder: (context, brand, _) => brand == e
                                      ? SvgPicture.asset('radio-a'.svg)
                                      : SvgPicture.asset('radio'.svg))
                            ],
                          ),
                        ),
                      ))
                  .toList(),
              18.sbH,
              UiButton(
                text: 'Add New Card',
                onPressed: () =>
                    Navigator.pushNamed(context, Routes.addCardPageRoute),
              ),
              32.sbH,
            ],
          ),
        ),
      ),
    );
  }
}

showSavedCardsBottomSheet(BuildContext context,
    {Function(CardBrand)? onTap, CardBrand? old}) {
  showModalBottomSheet(
      enableDrag: true,
      isDismissible: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SelectCurrencyBottomSheet(
          onTap: onTap,
          old: old,
        );
      });
}

enum CardBrand { visa, mastercard }
