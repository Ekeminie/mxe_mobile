import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/textstyles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/home/save-usd/save-usd-deposit-source-sheet.dart';
import 'package:mxe_mobile/ui/home/save-usd/save-usd.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';
import 'package:mxe_mobile/widgets/transaction-pin/number-input.dart';

class DepositSaveInUsd extends StatefulWidget {
  const DepositSaveInUsd({Key? key}) : super(key: key);

  @override
  State<DepositSaveInUsd> createState() => _DepositSaveInUsdState();
}

class _DepositSaveInUsdState extends State<DepositSaveInUsd> {
  final controller = TextEditingController();
  String? text;
  @override
  Widget build(BuildContext context) {
    return BaseView<SaveInUsdViewModel>(
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: customAppBar("", bgColor: AppColors.bgColor),
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header("Deposit USD"),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  32.sbH,
                  AutoSizeText(
                    "Enter amount",
                    style: GoogleFonts.plusJakartaSans(
                        color: AppColors.bgContrast,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp),
                  ),
                  8.sbH,
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        "\$   ",
                        style: GoogleFonts.plusJakartaSans(
                            color: AppColors.bgContrast,
                            fontWeight: FontWeight.w700,
                            fontSize: 18.sp),
                      ),
                      IntrinsicWidth(
                        child: TextField(
                          style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w700, fontSize: 32),
                          controller: controller,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            border: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          onChanged: (v) => controller.text =
                              formatPrice(v).replaceAll(".00", "").substring(1),
                        ),
                      ),
                    ],
                  ),
                  ValueListenableBuilder(
                    valueListenable: model.accountType,
                    builder: (context, accountType, _) => GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => saveInUSDSourceSheet(context,
                          old: model.accountType.value,
                          onTap: (v) =>
                              {model.accountType.value = v, model.refresh()},
                          title: "Choose Source",
                          fromCurrency: true),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 16.h, horizontal: 16.w),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: (accountType != null)
                                    ? AppColors.moderateBlue
                                    : AppColors.border,
                                width: 2),
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (accountType?.icon != null)
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: SvgPicture.asset(
                                        accountType!.icon.toString().svg,
                                        width: 16,
                                        height: 20,
                                        fit: BoxFit.fitWidth,
                                      )),
                                16.sbW,
                                (accountType != null)
                                    ? Text(accountType.title ?? "")
                                    : Text(
                                        "Select Account",
                                        style: GoogleFonts.plusJakartaSans(
                                          color: AppColors.textLight,
                                        ),
                                      ),
                              ],
                            ),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color:
                                  accountType != null ? null : AppColors.border,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  16.sbH,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: ["50", "100", "500", "1000"]
                        .map((e) => GestureDetector(
                              onTap: () =>
                                  {controller.text = e, model.setAmount(e)},
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.subtleAccent,
                                        width: 2),
                                    borderRadius: BorderRadius.circular(18)),
                                child: AutoSizeText(
                                  "\$${formatPrice(e).replaceAll(".00", "").substring(1)}",
                                  style: AppTextStyle.labelMdBold
                                      .copyWith(color: AppColors.moderateBlue),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  NumberInput(
                    biometrics: false,
                    // isForPrice: true,
                    onTap: (v) => {
                      model.setAmount(v),
                      controller.text = formatPrice(model.numAmount.toString())
                          .replaceAll(".00", "")
                          .substring(1)
                    },
                    usePinLength: false,
                    onCompleted: (v) {
                      if (v != "1111") {}
                    },
                  ),
                  16.sbH,
                  UiButton(
                    text: "Continue",
                    onPressed: model.hasAmount
                        ? () => Navigator.pushNamed(
                                context, Routes.saveInUsdConfirmationPageRoute,
                                arguments: {
                                  'type': model.accountType.value,
                                  "amount": model.numAmount.trimAndFormatNum,
                                })
                        : null,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
