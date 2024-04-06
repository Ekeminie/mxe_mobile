import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/constant/constants.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/bills/electricity/electricity.vm.dart';
import 'package:mxe_mobile/ui/bills/electricity/schedule-payment-type.dart';
import 'package:mxe_mobile/ui/bills/electricity/select-provider-bottomsheet.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';
import 'package:mxe_mobile/widgets/input.dart';

class BuyElectricityPage extends StatefulWidget {
  const BuyElectricityPage({Key? key}) : super(key: key);

  @override
  State<BuyElectricityPage> createState() => _BuyElectricityPageState();
}

class _BuyElectricityPageState extends State<BuyElectricityPage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<BuyElectricityViewModel>(
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
              header('Buy Electricity Units'),
              42.sbH,
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    Input(
                      controller: model.phoneNumberController,
                      hintText: "Enter Meter Number",
                      suffixIcon: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => {},
                        child: SvgPicture.asset(
                          'user'.svg,
                          height: 12,
                          width: 12,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (v) => model.setMeterNo(v),
                    ),
                    if (model.hasMeterNo) 8.sbH,
                    if (model.hasMeterNo)
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
                      onTap: () => showElectricityProviderBottomSheet(context,
                          onTap: (v) => model.setElectricityVariation(v),
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
                            model.selectedVariation?.title != null
                                ? Expanded(
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "electricity/${model.selectedVariation!.image}"
                                              .toString()
                                              .png,
                                          width: 34,
                                          height: 34,
                                        ),
                                        16.sbW,
                                        Expanded(
                                          child: Text(
                                            model.selectedVariation!.title!,
                                            style: GoogleFonts.plusJakartaSans(
                                                color: AppColors.bgContrast,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16.sp),
                                          ),
                                        ),
                                        GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () =>
                                              showElectricityProviderBottomSheet(
                                                  context,
                                                  onTap: (v) => model
                                                      .setElectricityVariation(
                                                          v),
                                                  old: model.selectedVariation),
                                          child: Text(
                                            "Change",
                                            style: GoogleFonts.plusJakartaSans(
                                                color: AppColors.moderateBlue,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.sp),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : AutoSizeText(
                                    "      Select Provider",
                                    style: GoogleFonts.plusJakartaSans(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.sp,
                                        color: AppColors.bgContrast),
                                  ),
                            if (model.selectedVariation?.title == null)
                              const Icon(Icons.keyboard_arrow_down_outlined)
                          ],
                        ),
                      ),
                    ),
                    16.sbH,
                    Input(
                        hintText: "Amount",
                        prefixText: nairaSign,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (v) => model.setAmount(v),
                        errorText: model.hasSufficientBalance()),
                    16.sbH,
                    ValueListenableBuilder(
                      valueListenable: model.schedulePayment,
                      builder: (context, save, _) => Visibility(
                        visible: save,
                        child: GestureDetector(
                          onTap: () => showElectricityScheduleBottomSheet(
                              context,
                              onTap: (v) => model.setElectricitySchedule(v),
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
                                model.selectedVariation?.title != null
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
                            "Schedule Payment",
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
                              context, Routes.reviewElectricityPageRoute)
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
