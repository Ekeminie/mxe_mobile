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
import 'package:mxe_mobile/ui/bills/bills-beneficiaries/bills-beneficiaries.ui.dart';
import 'package:mxe_mobile/ui/bills/data/data.vm.dart';
import 'package:mxe_mobile/ui/bills/data/select-denomination-bottomsheet.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';
import 'package:mxe_mobile/widgets/input.dart';

class BuyDataPage extends StatefulWidget {
  const BuyDataPage({Key? key}) : super(key: key);

  @override
  State<BuyDataPage> createState() => _BuyDataPageState();
}

class _BuyDataPageState extends State<BuyDataPage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<BuyDataViewModel>(
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: customAppBar("", bgColor: AppColors.bgColor, actions: [
          actionWidget("Beneficiaries", () async {
            SingleBeneficiary? contact = await Navigator.pushNamed(
                    context, Routes.billsBeneficiaryPageRoute)
                as SingleBeneficiary?;
            if (contact != null) {
              model.setPhone(contact.phone, useController: true);
            }
          })
        ]),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header('Buy Data'),
              32.sbH,
              ValueListenableBuilder(
                valueListenable: model.network,
                builder: (context, provider, _) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: NetworkProviderEnum.values
                      .map((e) => Visibility(
                            visible: e.title != null,
                            child: GestureDetector(
                              onTap: () =>
                                  {model.network.value = e, model.refresh()},
                              child: Opacity(
                                opacity:
                                    (provider.title != null && provider != e)
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
                                  child: SvgPicture.asset(
                                    e.image.toString().svg,
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
                      hintText: "Enter Phone Number",
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
                      onChanged: (v) => model.setPhone(v),
                    ),
                    16.sbH,
                    GestureDetector(
                      onTap: () => showSelectDataBottomSheet(context,
                          onTap: (v) => model.setDataVariation(v),
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
                    if (model.hasDataVariation) 8.sbH,
                    if (model.hasDataVariation)
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
                      valueListenable: model.saveBeneficiary,
                      builder: (context, save, _) => Visibility(
                        visible: save,
                        child: Input(
                          hintText: "Beneficiary Name",
                          onChanged: (v) => model.setAmount(v),
                        ),
                      ),
                    ),
                    16.sbH,
                    ValueListenableBuilder(
                      valueListenable: model.saveBeneficiary,
                      builder: (context, save, _) => Row(
                        children: [
                          Checkbox(
                            visualDensity: const VisualDensity(
                                horizontal: -4, vertical: -4),
                            value: save,
                            onChanged: (v) => {
                              model.saveBeneficiary.value = v!,
                              model.refresh()
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  4.0), // Adjust the radius as needed
                            ),
                          ),
                          12.sbW,
                          AutoSizeText(
                            "Save as Beneficiary",
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
                              context, Routes.reviewDataPageRoute)
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
