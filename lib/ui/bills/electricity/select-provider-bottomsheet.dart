import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/core/enum/bills-enum.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';

class SelectElectricityProviderBottomSheet extends StatefulWidget {
  Function(ElectricityProviderEnum)? onTap;
  ElectricityProviderEnum? old;
  SelectElectricityProviderBottomSheet({Key? key, this.onTap, this.old})
      : super(key: key);

  @override
  State<SelectElectricityProviderBottomSheet> createState() =>
      _SelectElectricityProviderBottomSheetState();
}

class _SelectElectricityProviderBottomSheetState
    extends State<SelectElectricityProviderBottomSheet> {
  ValueNotifier<ElectricityProviderEnum?> currency = ValueNotifier(null);
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
                  "Select Provider",
                  style: GoogleFonts.plusJakartaSans(
                      color: AppColors.bgContrast,
                      fontWeight: FontWeight.w700,
                      fontSize: 24.sp),
                ),
              ),
              24.0.sbH,
              ...ElectricityProviderEnum.values
                  .map((e) => GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          currency.value = e;
                          widget.onTap!(currency.value!);
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child: Row(
                            children: [
                              Image.asset(
                                "electricity/${e.image}".png,
                                width: 53,
                                height: 53,
                              ),
                              16.sbW,
                              Text(
                                e.title ?? "",
                                style: GoogleFonts.plusJakartaSans(
                                    color: AppColors.bgContrast,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.sp),
                              ),
                              Spacer(),
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

showElectricityProviderBottomSheet(BuildContext context,
    {Function(ElectricityProviderEnum)? onTap, ElectricityProviderEnum? old}) {
  showModalBottomSheet(
      enableDrag: true,
      isDismissible: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SelectElectricityProviderBottomSheet(
          onTap: onTap,
          old: old,
        );
      });
}
