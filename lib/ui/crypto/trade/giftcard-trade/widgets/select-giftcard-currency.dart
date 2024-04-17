import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/core/enum/fundtype-enum.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';

class SelectGiftCardCurrencyBottomSheet extends StatefulWidget {
  Function(GiftCardCurrencyEnum)? onTap;
  GiftCardCurrencyEnum? old;
  String? title;
  SelectGiftCardCurrencyBottomSheet(
      {Key? key, this.onTap, this.old, this.title})
      : super(key: key);

  @override
  State<SelectGiftCardCurrencyBottomSheet> createState() =>
      _SelectGiftCardCurrencyBottomSheetState();
}

class _SelectGiftCardCurrencyBottomSheetState
    extends State<SelectGiftCardCurrencyBottomSheet> {
  ValueNotifier<GiftCardCurrencyEnum> currency =
      ValueNotifier(GiftCardCurrencyEnum.ngn);
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
                  widget.title ?? "Currency",
                  style: GoogleFonts.plusJakartaSans(
                      color: AppColors.bgContrast,
                      fontWeight: FontWeight.w700,
                      fontSize: 24.sp),
                ),
              ),
              24.0.sbH,
              ...GiftCardCurrencyEnum.values
                  .map((e) => GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => {
                          currency.value = e,
                          widget.onTap!(currency.value),
                          Navigator.pop(context)
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: SvgPicture.asset(
                                          e.icon.toString().svg)),
                                  16.sbW,
                                  Text(
                                    "${e.title} (${e.code})",
                                    style: GoogleFonts.plusJakartaSans(
                                        color: AppColors.bgContrast,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.sp),
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

showSelectGiftCardCurrencyBottomSheet(BuildContext context,
    {Function(GiftCardCurrencyEnum)? onTap,
    GiftCardCurrencyEnum? old,
    String? title}) {
  showModalBottomSheet(
      enableDrag: true,
      isDismissible: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SelectGiftCardCurrencyBottomSheet(
            onTap: onTap, old: old, title: title);
      });
}
