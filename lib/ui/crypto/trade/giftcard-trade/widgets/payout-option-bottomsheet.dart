import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/textstyles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';

class PayoutOptionBottomSheet extends StatefulWidget {
  Function(String)? onTap;
  String? old;
  PayoutOptionBottomSheet({Key? key, this.onTap, this.old}) : super(key: key);

  @override
  State<PayoutOptionBottomSheet> createState() =>
      _PayoutOptionBottomSheetState();
}

class _PayoutOptionBottomSheetState extends State<PayoutOptionBottomSheet> {
  ValueNotifier<String?> selected = ValueNotifier(null);
  @override
  void initState() {
    super.initState();
    if (widget.old != null) {
      selected = ValueNotifier(widget.old!);
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
                  "Payout Options",
                  style: GoogleFonts.plusJakartaSans(
                      color: AppColors.bgContrast,
                      fontWeight: FontWeight.w700,
                      fontSize: 24.sp),
                ),
              ),
              24.0.sbH,
              ...["Access Bank"]
                  .map((e) => GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          selected.value = e;
                          widget.onTap!(selected.value!);
                          Navigator.pushReplacementNamed(
                              context, Routes.giftCardSuccessPage);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child: Row(
                            children: [
                              Image.asset('access'.png),
                              6.sbW,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${e.toCapitalized()}",
                                    style: AppTextStyle.labelMdRegular,
                                  ),
                                  8.sbH,
                                  const Text(
                                    "******1627",
                                    style: AppTextStyle.labelMdRegular,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              ValueListenableBuilder(
                                  valueListenable: selected,
                                  builder: (context, currency_, _) =>
                                      currency_ == e
                                          ? SvgPicture.asset('radio-a'.svg)
                                          : SvgPicture.asset('radio'.svg))
                            ],
                          ),
                        ),
                      ))
                  .toList(),
              16.sbH,
              UiButton(
                text: "Add New Account",
                onPressed: () => Navigator.pushReplacementNamed(
                    context, Routes.addAccountPageRoute),
              ),
              32.sbH,
            ],
          ),
        ),
      ),
    );
  }
}

showPayoutOptionsBottomSheet(BuildContext context,
    {Function(String)? onTap, String? old}) {
  showModalBottomSheet(
      enableDrag: true,
      isDismissible: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return PayoutOptionBottomSheet(
          onTap: onTap,
          old: old,
        );
      });
}
