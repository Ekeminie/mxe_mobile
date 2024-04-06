import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/constant/constants.dart';
import 'package:mxe_mobile/core/enum/bills-enum.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/bills/betting/betting.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';
import 'package:mxe_mobile/widgets/input.dart';

class PayBettingPage extends StatefulWidget {
  const PayBettingPage({Key? key}) : super(key: key);

  @override
  State<PayBettingPage> createState() => _PayBettingPageState();
}

class _PayBettingPageState extends State<PayBettingPage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<PayBettingViewModel>(
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
              header('Fund Games'),
              32.sbH,
              ValueListenableBuilder(
                valueListenable: model.provider,
                builder: (context, provider, _) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: BettingProviderEnum.values
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
                      key: const Key('userID'),
                      controller: model.userIdController,
                      hintText: "Enter user ID",
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (v) => model.setUserID(v),
                    ),
                    16.sbH,
                    Input(
                        controller: model.amountController,
                        key: const Key('amount'),
                        hintText: "Amount",
                        prefixText: nairaSign,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (v) => model.setAmount(v),
                        errorText: model.hasSufficientBalance()),
                    16.sbH,
                    ValueListenableBuilder(
                      valueListenable: model.saveBeneficiary,
                      builder: (context, save, _) => Visibility(
                        visible: save,
                        child: Input(
                          hintText: "Beneficiary Name",
                          onChanged: (v) => model.setBeneficiaryName(v),
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
                              context, Routes.reviewBettingPageRoute)
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
