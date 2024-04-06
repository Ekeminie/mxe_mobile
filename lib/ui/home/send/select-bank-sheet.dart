import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/core/model/banks-response.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/bottomsheet-widgets.dart';

class SelectBankListBottomSheet extends StatefulWidget {
  final List<BankModel> list;
  Function(BankModel)? onTap;
  BankModel? old;
  String? title;
  SelectBankListBottomSheet(
      {Key? key, this.onTap, this.old, this.title, required this.list})
      : super(key: key);

  @override
  State<SelectBankListBottomSheet> createState() =>
      _SelectBankListBottomSheetState();
}

class _SelectBankListBottomSheetState extends State<SelectBankListBottomSheet> {
  ValueNotifier<BankModel?> currency = ValueNotifier(null);
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
        height: height(context) - 100,
        padding: EdgeInsets.only(
            // right: 20,
            // left: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        color: Colors.white,
        // height: 500,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                12.sbH,
                const SheetHandle(),
                12.0.sbH,
                Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    widget.title ?? "Select Banks",
                    style: GoogleFonts.plusJakartaSans(
                        color: AppColors.bgContrast,
                        fontWeight: FontWeight.w700,
                        fontSize: 24.sp),
                  ),
                ),
                24.0.sbH,
                ...(widget.list)
                    .map((e) => GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => {
                            currency.value = e,
                            widget.onTap!(currency.value!),
                            Navigator.pop(context)
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          child: SvgPicture.asset(
                                              "bank-avatar".svg)),
                                      16.sbW,
                                      Flexible(
                                        child: AutoSizeText(
                                          "${e.bankName?.capitalizeWords()}",
                                          style: GoogleFonts.plusJakartaSans(
                                              color: AppColors.bgContrast,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16.sp),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
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
      ),
    );
  }
}

selectBankBottomSheet(BuildContext context,
    {Function(BankModel)? onTap,
    BankModel? old,
    String? title,
    required List<BankModel> list}) {
  showModalBottomSheet(
      enableDrag: true,
      isDismissible: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SelectBankListBottomSheet(
            onTap: onTap, old: old, title: title, list: list);
      });
}

enum Currency { usd, ngn }
