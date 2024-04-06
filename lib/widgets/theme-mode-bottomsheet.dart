import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';

class ThemeModeBottomSheet extends StatelessWidget {
  ThemeModeBottomSheet({Key? key}) : super(key: key);

  ValueNotifier<bool> light = ValueNotifier(true);
  ValueNotifier<bool> dark = ValueNotifier(false);
  ValueNotifier<bool> defaultOs = ValueNotifier(false);

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
              24.0.sbH,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => {},
                    behavior: HitTestBehavior.opaque,
                    child: Row(
                      children: [
                        SvgPicture.asset('theme-mode'.svg),
                        16.sbW,
                        Text(
                          "Light Mode",
                          style: GoogleFonts.plusJakartaSans(
                              color: AppColors.bgContrast,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp),
                        ),
                      ],
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: light,
                    builder: (context, light_, _) => CupertinoSwitch(
                      value: light_,
                      onChanged: (v) => light.value = !light.value,
                      activeColor: AppColors.moderateBlue,
                    ),
                  )
                ],
              ),
              32.sbH,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => {},
                    behavior: HitTestBehavior.opaque,
                    child: Row(
                      children: [
                        SvgPicture.asset('dark-mode'.svg),
                        16.sbW,
                        Text(
                          "Dark Mode",
                          style: GoogleFonts.plusJakartaSans(
                              color: AppColors.bgContrast,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp),
                        ),
                      ],
                    ),
                  ),
                  ValueListenableBuilder(
                      valueListenable: dark,
                      builder: (context, dark_, _) => CupertinoSwitch(
                            value: dark_,
                            onChanged: (v) => dark.value = !dark.value,
                            activeColor: AppColors.moderateBlue,
                          ))
                ],
              ),
              32.sbH,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => {},
                    behavior: HitTestBehavior.opaque,
                    child: Row(
                      children: [
                        SvgPicture.asset('default-os'.svg),
                        16.sbW,
                        Text(
                          "Default OS",
                          style: GoogleFonts.plusJakartaSans(
                              color: AppColors.bgContrast,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp),
                        ),
                      ],
                    ),
                  ),
                  ValueListenableBuilder(
                      valueListenable: defaultOs,
                      builder: (context, dark_, _) => CupertinoSwitch(
                            value: dark_,
                            onChanged: (v) =>
                                defaultOs.value = !defaultOs.value,
                            activeColor: AppColors.moderateBlue,
                          ))
                ],
              ),
              32.sbH,
            ],
          ),
        ),
      ),
    );
  }
}

showThemeModeBottomSheet(BuildContext context) {
  showModalBottomSheet(
      enableDrag: true,
      isDismissible: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return ThemeModeBottomSheet();
      });
}
