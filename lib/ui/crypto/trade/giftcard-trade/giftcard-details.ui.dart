import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/ui/crypto/trade/giftcard-trade/giftcard.vm.dart';
import 'package:mxe_mobile/ui/crypto/trade/giftcard-trade/widgets/payout-option-bottomsheet.dart';
import 'package:mxe_mobile/ui/crypto/trade/giftcard-trade/widgets/select-giftcard-currency.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';
import 'package:mxe_mobile/widgets/input.dart';

class GiftCardDetailsPage extends StatefulWidget {
  const GiftCardDetailsPage({super.key});

  @override
  State<GiftCardDetailsPage> createState() => _GiftCardDetailsPageState();
}

class _GiftCardDetailsPageState extends State<GiftCardDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<GiftCardViewModel>(
      onModelReady: (m) => m.transferRepo.giftCardCurrency = m.currency.value,
      builder: (context, model, child) => Scaffold(
        appBar: customAppBar("", actions: [
          SvgPicture.asset('giftcard-scan'.svg),
          18.sbW,
        ]),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              12.sbH,
              header("Sell GiftCard", usePadding: false),
              24.sbH,
              Center(child: Image.asset('itunes'.png)),
              16.sbH,
              Input(
                controller: model.amountController,
                autofocus: false,
                hintText: "Amount",
                // labelText: "Amount",
                prefixWidget: GestureDetector(
                  onTap: () => showSelectGiftCardCurrencyBottomSheet(context,
                      onTap: (v) => {
                            model.currency.value = v,
                            model.transferRepo.giftCardCurrency = v
                          },
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
                        Text(c.symbol ?? ""),
                        5.sbW,
                        const Icon(Icons.keyboard_arrow_down_rounded),
                      ],
                    ),
                  ),
                ),
                readOnly: false,
                onChanged: (v) => model.setAmount(v),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              12.sbH,
              Input(
                controller: model.cardNoController,
                autofocus: false,
                hintText: "Card Number",
                // labelText: "Amount",
                readOnly: false,
                onChanged: (v) => model.setCardNo(v),
              ),
              34.sbH,
              UiButton(
                text: "Sell Now",
                onPressed: model.hasValidInputs
                    ? () => showPayoutOptionsBottomSheet(context, onTap: (v) {})
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
