import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/enum/bills-enum.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/bills/cable/cable.vm.dart';
import 'package:mxe_mobile/ui/bills/cable/select-denomination-bottomsheet.dart';
import 'package:mxe_mobile/ui/bills/electricity/schedule-payment-type.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';
import 'package:mxe_mobile/widgets/input.dart';

class PayCablePage extends StatefulWidget {
  const PayCablePage({Key? key}) : super(key: key);

  @override
  State<PayCablePage> createState() => _PayCablePageState();
}

class _PayCablePageState extends State<PayCablePage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<PayCableViewModel>(
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: customAppBar(
          "",
          bgColor: AppColors.bgColor,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header('Pay Cable Subscription'),
              32.sbH,
              ValueListenableBuilder(
                valueListenable: model.provider,
                builder: (context, provider, _) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: CableProviderEnum.values
                      .map((e) => Visibility(
                            visible: e.title != null,
                            child: GestureDetector(
                              onTap: () =>
                                  {model.provider.value = e, model.refresh()},
                              child: Opacity(
                                opacity:
                                    (provider?.title != null && provider != e)
                                        ? 0.3
                                        : 1.0,
                                child: Container(
                                  decoration: provider == e
                                      ? BoxDecoration(
                                          color: e.color,
                                          borderRadius:
                                              BorderRadius.circular(28),
                                          border: Border.all(
                                              color: AppColors.moderateBlue,
                                              width: 5))
                                      : null,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.w),
                                  child: Image.asset(
                                    e.image.toString().png,
                                    width: 85.w,
                                    height: 85.h,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
              32.sbH,
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    Input(
                      controller: model.phoneNumberController,
                      hintText: "Smart card/decoder number",
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (v) => model.setSmartCardNo(v),
                    ),
                    if (model.hasSmartCardNo) 8.sbH,
                    if (model.hasSmartCardNo)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          "Odafe David",
                          style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                              color: AppColors.textLight),
                        ),
                      ),
                    16.sbH,
                    GestureDetector(
                      onTap: () => showSelectCableBottomSheet(context,
                          onTap: (v) => model.setCableVariation(v),
                          old: model.selectedVariation),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.border,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(
                              model.selectedVariation ?? "      Select Plan",
                              style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp,
                                  color: AppColors.bgContrast),
                            ),
                            const Icon(Icons.keyboard_arrow_down_outlined)
                          ],
                        ),
                      ),
                    ),
                    if (model.hasCableVariation) 8.sbH,
                    if (model.hasCableVariation)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: AutoSizeText(
                          formatPrice("100"),
                          style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                              color: AppColors.textLight),
                        ),
                      ),
                    16.sbH,
                    ValueListenableBuilder(
                      valueListenable: model.schedulePayment,
                      builder: (context, save, _) => Visibility(
                        visible: save,
                        child: GestureDetector(
                          onTap: () => showElectricityScheduleBottomSheet(
                              context,
                              onTap: (v) => model.setSchedule(v),
                              old: model.scheduleType.value),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.border,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                model.selectedVariation != null
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AutoSizeText(
                                            "      Schedule Frequency",
                                            style: GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.sp,
                                                color: AppColors.textLight),
                                          ),
                                          2.sbH,
                                          Text(
                                            "    Every ${model.scheduleType.value!.name.toCapitalized()}",
                                            style: GoogleFonts.plusJakartaSans(
                                                color: AppColors.bgContrast,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16.sp),
                                          ),
                                        ],
                                      )
                                    : AutoSizeText(
                                        "      Schedule Frequency",
                                        style: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.sp,
                                            color: AppColors.bgContrast),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    16.sbH,
                    ValueListenableBuilder(
                      valueListenable: model.schedulePayment,
                      builder: (context, save, _) => Row(
                        children: [
                          Checkbox(
                            visualDensity: const VisualDensity(
                                horizontal: -4, vertical: -4),
                            value: save,
                            onChanged: (v) => {
                              model.schedulePayment.value = v!,
                              model.refresh()
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  4.0), // Adjust the radius as needed
                            ),
                          ),
                          12.sbW,
                          AutoSizeText(
                            "Schedule Frequency",
                            style: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                                color: AppColors.bgContrast),
                          ),
                        ],
                      ),
                    ),
                    20.sbH,
                    Row(
                      children: [
                        6.sbW,
                        SvgPicture.asset('cancel'.svg),
                        12.sbW,
                        AutoSizeText(
                          "Min: NGN 100.00",
                          style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: AppColors.textLight),
                        ),
                      ],
                    ),
                    8.sbH,
                    Row(
                      children: [
                        6.sbW,
                        SvgPicture.asset('check'.svg),
                        12.sbW,
                        AutoSizeText(
                          "Max: NGN 50,000.00",
                          style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: AppColors.textLight),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              32.sbH,
              UiButton(
                text: "Continue",
                onPressed: model.isValidInputs
                    ? () => {
                          model.save(),
                          Navigator.pushNamed(
                              context, Routes.reviewCablePageRoute)
                        }
                    : null,
              )
            ],
          ),
        ),
      ),
    );
  }
}
