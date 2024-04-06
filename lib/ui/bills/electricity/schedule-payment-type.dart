import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/ui/bills/electricity/electricity.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';

class SelectElectricityScheduleBottomSheet extends StatefulWidget {
  Function(EScheduleType)? onTap;
  EScheduleType? old;
  SelectElectricityScheduleBottomSheet({Key? key, this.onTap, this.old})
      : super(key: key);

  @override
  State<SelectElectricityScheduleBottomSheet> createState() =>
      _SelectElectricityScheduleBottomSheetState();
}

class _SelectElectricityScheduleBottomSheetState
    extends State<SelectElectricityScheduleBottomSheet> {
  ValueNotifier<EScheduleType?> selected = ValueNotifier(null);
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
                  "Schedule Frequency",
                  style: GoogleFonts.plusJakartaSans(
                      color: AppColors.bgContrast,
                      fontWeight: FontWeight.w700,
                      fontSize: 24.sp),
                ),
              ),
              24.0.sbH,
              ...EScheduleType.values
                  .map((e) => GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          selected.value = e;
                          widget.onTap!(selected.value!);
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    " Every ${e.name.toCapitalized()}",
                                    style: GoogleFonts.plusJakartaSans(
                                        color: AppColors.bgContrast,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.sp),
                                  ),
                                  8.sbH,
                                  Text(
                                    "Next Payment - ${getNextDate(e)}",
                                    style: GoogleFonts.plusJakartaSans(
                                        color: AppColors.textLight,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.sp),
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
              32.sbH,
            ],
          ),
        ),
      ),
    );
  }

  String getNextDate(EScheduleType v) {
    switch (v) {
      case EScheduleType.week:
        var date = DateFormat('MMM d')
            .format(DateTime.now().add(const Duration(days: 7)));
        return date;
      case EScheduleType.month:
        var date = DateFormat('MMM d')
            .format(DateTime.now().add(const Duration(days: 30)));
        return date;
    }
  }
}

showElectricityScheduleBottomSheet(BuildContext context,
    {Function(EScheduleType)? onTap, EScheduleType? old}) {
  showModalBottomSheet(
      enableDrag: true,
      isDismissible: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SelectElectricityScheduleBottomSheet(
          onTap: onTap,
          old: old,
        );
      });
}
