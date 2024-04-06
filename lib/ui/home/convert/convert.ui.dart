import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/enum/fundtype-enum.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/home/convert/convert.vm.dart';
import 'package:mxe_mobile/ui/home/convert/select-convert-currencu.dart';
import 'package:mxe_mobile/ui/home/send/select-transfer-currency.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/input.dart';

class ConvertFundsPage extends StatefulWidget {
  const ConvertFundsPage({Key? key}) : super(key: key);

  @override
  State<ConvertFundsPage> createState() => _ConvertFundsPageState();
}

class _ConvertFundsPageState extends State<ConvertFundsPage> {
  ValueNotifier<SendFundType> fundType = ValueNotifier(SendFundType.mxeTag);

  @override
  Widget build(BuildContext context) {
    return BaseView<ConvertFundsViewModel>(
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: customAppBar("", bgColor: AppColors.bgColor),
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: AutoSizeText(
                  "Convert Currency",
                  style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 24.sp,
                      color: AppColors.bgContrast),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  32.sbH,
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        ///---->
                        ValueListenableBuilder(
                          valueListenable: model.fromCurrency,
                          builder: (context, fromCurrency_, _) =>
                              GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => selectConvertCurrencyBottomSheet(
                                context,
                                old: fromCurrency_,
                                onTap: (v) => model.setFromCurrency(v),
                                title: "Swap From",
                                fromCurrency: true),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 16.h, horizontal: 16.w),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: (fromCurrency_ != null)
                                          ? AppColors.moderateBlue
                                          : AppColors.border,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: SvgPicture.asset(
                                            fromCurrency_.icon.toString().svg,
                                            width: 16,
                                            height: 20,
                                            fit: BoxFit.fitWidth,
                                          )),
                                      16.sbW,
                                      (fromCurrency_ != null)
                                          ? Text(
                                              "Swap From ${fromCurrency_.code ?? " "}")
                                          : Text(
                                              "Select Bank",
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                color: AppColors.textLight,
                                              ),
                                            ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: fromCurrency_ != null
                                        ? null
                                        : AppColors.border,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        16.sbH,
                        ValueListenableBuilder(
                          valueListenable: model.toCurrency,
                          builder: (context, toCurrency_, _) => GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => selectConvertCurrencyBottomSheet(
                                context,
                                old: toCurrency_,
                                onTap: (v) => model.setToCurrency(v),
                                title: "Swap to",
                                fromCurrency: true),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 16.h, horizontal: 16.w),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: (toCurrency_ != null)
                                          ? AppColors.moderateBlue
                                          : AppColors.border,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: SvgPicture.asset(
                                            toCurrency_.icon.toString().svg,
                                            width: 16,
                                            height: 20,
                                            fit: BoxFit.fitWidth,
                                          )),
                                      16.sbW,
                                      (toCurrency_ != null)
                                          ? Text(
                                              "Swap to ${toCurrency_.code ?? " "}")
                                          : Text(
                                              "Select Bank",
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                color: AppColors.textLight,
                                              ),
                                            ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: (toCurrency_ != null)
                                        ? null
                                        : AppColors.border,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        16.sbH,
                        Input(
                          controller: model.amountController,
                          autofocus: false,
                          hintText: "Amount",
                          // labelText: "Amount",
                          prefixWidget: GestureDetector(
                            onTap: () => showSelectTransferCurrencyBottomSheet(
                                context,
                                onTap: (v) => model.currency.value = v,
                                old: model.currency.value),
                            child: ValueListenableBuilder(
                              valueListenable: model.fromCurrency,
                              builder: (context, c, _) => Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  16.sbW,
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: SvgPicture.asset(
                                        c.icon.toString().svg,
                                        width: 16,
                                        height: 20,
                                        fit: BoxFit.fitWidth,
                                      )),
                                  5.sbW,
                                  Text(c.name.toUpperCase()),
                                  5.sbW,
                                  const Icon(Icons.keyboard_arrow_down_rounded),
                                ],
                              ),
                            ),
                          ),
                          readOnly: false,
                          onChanged: (v) => model.setAmount(v),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        16.sbH,
                        if (model.hasAmount)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: AutoSizeText(
                              "${model.toCurrency.value.code} ${formatPrice("100").substring(1).replaceAll(".00", "")}",
                              style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp,
                                  color: AppColors.textLight),
                            ),
                          ),

                        ///---->
                      ],
                    ),
                  ),
                  24.sbH,
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        ValueListenableBuilder(
                          valueListenable: fundType,
                          builder: (context, type, _) => Column(
                              children: {
                            "Transaction Fees 2%": 12,
                            "Amount you will Pay": "1000",
                            "Amount you will Receive": "1000",
                            "Payment Method": type.code
                          }
                                  .entries
                                  .map(
                                    (e) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            e.key,
                                            style: GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color: AppColors.textLight),
                                          ),
                                          Text(
                                            (e.key == ("Payment Method"))
                                                ? (e.value.toString())
                                                : formatPrice(
                                                    e.value.toString()),
                                            style: GoogleFonts.plusJakartaSans(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList()),
                        ),
                      ],
                    ),
                  ),
                  36.sbH,
                  UiButton(
                    text: "Convert Now",
                    onPressed: model.hasAmount
                        ? () {
                            model.save1();
                            Navigator.pushNamed(
                                context, Routes.convertFundsSuccessPageRoute);
                          }
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
