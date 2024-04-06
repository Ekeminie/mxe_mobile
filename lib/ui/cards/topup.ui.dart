import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/enum/fundtype-enum.dart';
import 'package:mxe_mobile/core/enum/status-enum.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/cards/card.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';
import 'package:mxe_mobile/widgets/input.dart';
import 'package:mxe_mobile/widgets/select-currency-bottomsheet.dart';
import 'package:mxe_mobile/widgets/transaction-pin/bills-pin.dart';
import 'package:mxe_mobile/widgets/transaction-success/transaction-success-widget.dart';

class VirtualCardTopup extends StatefulWidget {
  const VirtualCardTopup({Key? key}) : super(key: key);

  @override
  State<VirtualCardTopup> createState() => _VirtualCardTopupState();
}

class _VirtualCardTopupState extends State<VirtualCardTopup> {
  ValueNotifier<InsightsTimeLineEnum> timeline =
      ValueNotifier(InsightsTimeLineEnum.sevenDays);

  ValueNotifier<Currency?> currency = ValueNotifier(null);
  ValueNotifier<FundType> fundType = ValueNotifier(FundType.cardPayment);

  bool newUser = true;
  bool verified = true;

  @override
  Widget build(BuildContext context) {
    return BaseView<CardViewModel>(
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: customAppBar("", bgColor: AppColors.bgColor),
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header("Fund Virtual Account"),
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
                          prefixWidget: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              16.sbW,
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: SvgPicture.asset(
                                    "usd".svg,
                                    width: 40,
                                    height: 20,
                                    fit: BoxFit.contain,
                                  )),
                              5.sbW,
                              const Text("USD"),
                              5.sbW,
                              const Icon(Icons.keyboard_arrow_down_rounded),
                            ],
                          ),
                          readOnly: false,
                          onChanged: (v) => model.setAmount(v),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        16.sbH,
                        ValueListenableBuilder(
                          valueListenable: currency,
                          builder: (context, type, _) => GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => showSelectCurrencyBottomSheet(context,
                                old: type,
                                onTap: (v) =>
                                    {currency.value = v, model.setSource(v)},
                                title: "Funding Source"),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 14.h, horizontal: 16.w),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.moderateBlue, width: 2),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "${type?.name.toUpperCase() ?? "Funding Source"} "),
                                  const Icon(Icons.keyboard_arrow_down_rounded),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  56.sbH,
                  UiButton(
                    text: "Fund Now",
                    onPressed: model.isValidInputs
                        ? () {
                            showNewTransferPinBottomSheet(context,
                                onCompleted: (c) =>
                                    model.userService.transactionPin = c,
                                onDone: () => Navigator.pushNamed(
                                    context, Routes.transactionSuccessPageRoute,
                                    arguments: SuccessData(
                                        amount: model.amount.toString(),
                                        title:
                                            "Your Virtual Card Topup was Successful",
                                        transType: "Virtual Card Top-up",
                                        subTitle:
                                            "You have successfully funded your virtual card with  USD ${model.amount}")));
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
