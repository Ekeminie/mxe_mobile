import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/core/enum/fundtype-enum.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/ui/home/deposit/account-sheet.ui.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/bottomsheet-widgets.dart';

class FundTypeBottomSheet extends StatefulWidget {
  Function(FundType)? onTap;
  FundType? old;
  FundTypeBottomSheet({Key? key, this.onTap, this.old}) : super(key: key);

  @override
  State<FundTypeBottomSheet> createState() => _FundTypeBottomSheetState();
}

class _FundTypeBottomSheetState extends State<FundTypeBottomSheet> {
  ValueNotifier<FundType> fundtype = ValueNotifier(FundType.cardPayment);
  @override
  void initState() {
    super.initState();
    if (widget.old != null) {
      fundtype = ValueNotifier(widget.old!);
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
        color: AppColors.bgColor,
        // height: 500,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              8.0.sbH,
              const SheetHandle(),
              24.sbH,
              8.0.sbH,
              Align(
                alignment: Alignment.centerLeft,
                child: AutoSizeText(
                  "Wallet",
                  style: GoogleFonts.plusJakartaSans(
                      color: AppColors.bgContrast,
                      fontWeight: FontWeight.w700,
                      fontSize: 24.sp),
                ),
              ),
              24.0.sbH,
              ...FundType.values
                  .map((e) => GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if (e == FundType.bankTransfer) {
                            fundtype.value = e;
                            widget.onTap!(fundtype.value);
                            showAccountDetailBottomSheet(context);
                            return;
                          }
                          fundtype.value = e;
                          widget.onTap!(fundtype.value);
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      e.icon!.svg,
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.contain,
                                    ),
                                    16.sbW,
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            e.title!,
                                            style: GoogleFonts.plusJakartaSans(
                                                color: AppColors.bgContrast,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16.sp),
                                          ),
                                          4.sbH,
                                          Text(
                                            e.desc!,
                                            style: GoogleFonts.plusJakartaSans(
                                                color: AppColors.textLight,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14.sp),
                                          ),
                                          if (e.hasSupport!) const Divider(),
                                          if (e.hasSupport!)
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Supports  ",
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12),
                                                ),
                                                4.sbW,
                                                SvgPicture.asset(
                                                    e.supportIcon!.svg)
                                              ],
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              12.sbW,
                              ValueListenableBuilder(
                                  valueListenable: fundtype,
                                  builder: (context, type, _) => Visibility(
                                      visible: type == e,
                                      child: SvgPicture.asset('radio-a'.svg)))
                            ],
                          ),
                        ),
                      ))
                  .toList(),
              32.sbH,
              32.sbH,
            ],
          ),
        ),
      ),
    );
  }
}

showFundTypeBottomSheet(BuildContext context,
    {Function(FundType)? onTap, FundType? old}) {
  showModalBottomSheet(
      enableDrag: true,
      isDismissible: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return FundTypeBottomSheet(
          onTap: onTap,
          old: old,
        );
      });
}
