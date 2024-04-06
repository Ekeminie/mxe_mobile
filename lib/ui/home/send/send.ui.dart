import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/enum/fundtype-enum.dart';
import 'package:mxe_mobile/core/enum/status-enum.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/home/send/select-transfer-currency.dart';
import 'package:mxe_mobile/ui/home/send/send-bottomsheet.dart';
import 'package:mxe_mobile/ui/home/send/send.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/input.dart';

class SendFundsPage extends StatefulWidget {
  const SendFundsPage({Key? key}) : super(key: key);

  @override
  State<SendFundsPage> createState() => _SendFundsPageState();
}

class _SendFundsPageState extends State<SendFundsPage> {
  ValueNotifier<InsightsTimeLineEnum> timeline =
      ValueNotifier(InsightsTimeLineEnum.sevenDays);

  ValueNotifier<SendFundType> fundType = ValueNotifier(SendFundType.mxeTag);

  bool newUser = true;
  bool verified = true;

  @override
  Widget build(BuildContext context) {
    return BaseView<SendFundsViewModel>(
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
                  "Send Money",
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
                              valueListenable: model.currency,
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
                        ValueListenableBuilder(
                          valueListenable: fundType,
                          builder: (context, type, _) => GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => showSendFundsTypeBottomSheet(context,
                                old: type, onTap: (v) => fundType.value = v),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 16.h, horizontal: 16.w),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.moderateBlue, width: 2),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(type.title!),
                                  const Icon(Icons.keyboard_arrow_down_rounded),
                                ],
                              ),
                            ),
                          ),
                        )
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
                    text: "Send Now",
                    onPressed: model.hasAmount
                        ? verified
                            ? () {
                                model.save1();
                                switch (fundType.value) {
                                  case SendFundType.mxeTag:
                                    Navigator.pushNamed(context,
                                        Routes.sendFundsDetailsPageRoute);
                                  case SendFundType.bankTransfer:
                                    Navigator.pushNamed(context,
                                        Routes.transferDetailsPageRoute);
                                  default:
                                }
                              }
                            : () => Navigator.pushNamed(
                                context, Routes.accountVerificationPageRoute)
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
