import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';

class SelectCurrencyBottomSheet extends StatefulWidget {
  Function(Currency)? onTap;
  Currency? old;
  String? title;
  SelectCurrencyBottomSheet({Key? key, this.onTap, this.old, this.title})
      : super(key: key);

  @override
  State<SelectCurrencyBottomSheet> createState() =>
      _SelectCurrencyBottomSheetState();
}

class _SelectCurrencyBottomSheetState extends State<SelectCurrencyBottomSheet> {
  ValueNotifier<Currency> currency = ValueNotifier(Currency.ngn);
  @override
  void initState() {
    super.initState();
    if (widget.old != null) {
      currency = ValueNotifier(widget.old!);
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
              8.0.sbH,
              Align(
                alignment: Alignment.centerLeft,
                child: AutoSizeText(
                  widget.title ?? "Wallet",
                  style: GoogleFonts.plusJakartaSans(
                      color: AppColors.bgContrast,
                      fontWeight: FontWeight.w700,
                      fontSize: 24.sp),
                ),
              ),
              24.0.sbH,
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => currency.value != Currency.ngn
                    ? {
                        currency.value = Currency.ngn,
                        widget.onTap!(currency.value),
                        Navigator.pop(context)
                      }
                    : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('ngn'.svg),
                        16.sbW,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                        valueListenable: currency,
                        builder: (context, currency_, _) =>
                            currency_ == Currency.ngn
                                ? SvgPicture.asset('radio-a'.svg)
                                : SvgPicture.asset('radio'.svg))
                  ],
                ),
              ),
              32.sbH,
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => currency.value != Currency.usd
                    ? {
                        currency.value = Currency.usd,
                        widget.onTap!(currency.value),
                        Navigator.pop(context)
                      }
                    : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: SvgPicture.asset('usd'.svg)),
                        16.sbW,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "USD Wallet",
                              style: GoogleFonts.plusJakartaSans(
                                  color: AppColors.bgContrast,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp),
                            ),
                            4.sbH,
                            Text(
                              "Available Balance - USD 49,00",
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
                        valueListenable: currency,
                        builder: (context, currency_, _) =>
                            currency_ == Currency.usd
                                ? SvgPicture.asset('radio-a'.svg)
                                : SvgPicture.asset('radio'.svg))
                  ],
                ),
              ),
              32.sbH,
            ],
          ),
        ),
      ),
    );
  }
}

showSelectCurrencyBottomSheet(BuildContext context,
    {Function(Currency)? onTap, Currency? old, String? title}) {
  showModalBottomSheet(
      enableDrag: true,
      isDismissible: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SelectCurrencyBottomSheet(onTap: onTap, old: old, title: title);
      });
}

enum Currency { usd, ngn }
