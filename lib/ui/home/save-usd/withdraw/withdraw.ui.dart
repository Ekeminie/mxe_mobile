import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/home/save-usd/save-usd.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';
import 'package:mxe_mobile/widgets/transaction-pin/bills-pin.dart';
import 'package:mxe_mobile/widgets/transaction-pin/number-input.dart';
import 'package:mxe_mobile/widgets/transaction-success/transaction-success-widget.dart';

class WithdrawSaveInUsd extends StatefulWidget {
  const WithdrawSaveInUsd({Key? key}) : super(key: key);

  @override
  State<WithdrawSaveInUsd> createState() => _WithdrawSaveInUsdState();
}

class _WithdrawSaveInUsdState extends State<WithdrawSaveInUsd> {
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
            header("Withdraw USD"),
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
                ],
              ),
            ),
            54.sbH,
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: NumberInput(
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
                ),
              ],
            ),
          ],
        ),
        bottomSheet: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              UiButton(
                text: "Continue",
                onPressed: model.hasAmount
                    ? () => showNewTransferPinBottomSheet(context,
                        onCompleted: (c) =>
                            model.userService.transactionPin = c,
                        onDone: () => Navigator.pushNamed(
                            context, Routes.transactionSuccessPageRoute,
                            arguments: SuccessData(
                                amount: model.numAmount.toString(),
                                title: "Transaction Successful",
                                transType: "Savings",
                                recipient: "",
                                subTitle:
                                    "Your withdrawal of USD ${model.numAmount} (NGN ${formatPrice(model.numAmount.formatMoney)}) was successful")))
                    : null,
              ),
              32.sbH,
            ],
          ),
        ),
      ),
    );
  }
}
