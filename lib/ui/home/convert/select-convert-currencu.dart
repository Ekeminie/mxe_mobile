import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/core/enum/fundtype-enum.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';

class ConvertCurrencyBottomSheet extends StatefulWidget {
  Function(TransferCurrency)? onTap;
  bool fromCurrency;
  TransferCurrency? old;
  String? title;
  ConvertCurrencyBottomSheet(
      {Key? key, this.onTap, this.old, this.title, this.fromCurrency = false})
      : super(key: key);

  @override
  State<ConvertCurrencyBottomSheet> createState() =>
      _ConvertCurrencyBottomSheetState();
}

class _ConvertCurrencyBottomSheetState
    extends State<ConvertCurrencyBottomSheet> {
  ValueNotifier<TransferCurrency> currency =
      ValueNotifier(TransferCurrency.ngn);
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
                  widget.title ?? "Swap From Currency",
                  style: GoogleFonts.plusJakartaSans(
                      color: AppColors.bgContrast,
                      fontWeight: FontWeight.w700,
                      fontSize: 24.sp),
                ),
              ),
              24.0.sbH,
              ...TransferCurrency.values
                  .map((e) => Visibility(
                        visible: widget.fromCurrency,
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => {
                            currency.value = e,
                            widget.onTap!(currency.value),
                            Navigator.pop(context)
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(24),
                                        child: SvgPicture.asset(
                                            e.icon.toString().svg)),
                                    16.sbW,
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${e.code} Wallet",
                                          style: GoogleFonts.plusJakartaSans(
                                              color: AppColors.bgContrast,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16.sp),
                                        ),
                                        4.sbH,
                                        Text(
                                          "Available Balance - ${e.code} 49,000.00",
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
                                        currency_ == e
                                            ? SvgPicture.asset('radio-a'.svg)
                                            : SvgPicture.asset('radio'.svg))
                              ],
                            ),
                          ),
                        ),
                      ))
                  .toList(),
              32.sbH,
            ],
          ),
        ),
      ),
    );
  }
}

selectConvertCurrencyBottomSheet(BuildContext context,
    {Function(TransferCurrency)? onTap,
    TransferCurrency? old,
    String? title,
    bool fromCurrency = false}) {
  showModalBottomSheet(
      enableDrag: true,
      isDismissible: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return ConvertCurrencyBottomSheet(
          onTap: onTap,
          old: old,
          title: title,
          fromCurrency: fromCurrency,
        );
      });
}
