import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/core/enum/status-enum.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';

class SelectInsightTimelineSheet extends StatefulWidget {
  final InsightsTimeLineEnum old;
  final Function(InsightsTimeLineEnum e) onSelected;
  SelectInsightTimelineSheet(
      {Key? key, required this.onSelected, required this.old})
      : super(key: key);

  @override
  State<SelectInsightTimelineSheet> createState() =>
      _SelectInsightTimelineSheetState();
}

class _SelectInsightTimelineSheetState
    extends State<SelectInsightTimelineSheet> {
  ValueNotifier<InsightsTimeLineEnum> timeline =
      ValueNotifier(InsightsTimeLineEnum.sevenDays);

  @override
  void initState() {
    super.initState();
    timeline = ValueNotifier(widget.old);
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
          child: ValueListenableBuilder(
            valueListenable: timeline,
            builder: (context, time, _) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    "Timeline",
                    style: GoogleFonts.plusJakartaSans(
                        color: AppColors.bgContrast,
                        fontWeight: FontWeight.w700,
                        fontSize: 24.sp),
                  ),
                ),
                12.sbH,
                ...InsightsTimeLineEnum.values
                    .map((e) => GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => timeline.value != e
                              ? {
                                  timeline.value = e,
                                  widget.onSelected(e),
                                  Navigator.pop(context)
                                }
                              : null,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  e.title!,
                                  style: GoogleFonts.plusJakartaSans(
                                      color: AppColors.bgContrast,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.sp),
                                ),
                                timeline.value == e
                                    ? SvgPicture.asset('radio-a'.svg)
                                    : SvgPicture.asset('radio'.svg)
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

showSelectInsightTimelineSheet(BuildContext context,
    {required Function(InsightsTimeLineEnum e) onSelected,
    required InsightsTimeLineEnum old}) {
  showModalBottomSheet(
      enableDrag: true,
      isDismissible: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SelectInsightTimelineSheet(onSelected: onSelected, old: old);
      });
}
