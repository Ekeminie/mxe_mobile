import 'package:flutter/material.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';

class NText extends StatelessWidget {
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? align;
  final String? amount;
  const NText(this.amount,
      {Key? key,
      this.fontWeight = FontWeight.w400,
      this.color,
      this.align,
      this.fontSize})
      : super(key: key);
  String get price => formatPrice(amount ?? "0");
  List<String> get splitAmount => price.split(nairaCurrency.currencySymbol);
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: align ?? TextAlign.start,
      text: TextSpan(
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
        children: [
          TextSpan(
              text: nairaCurrency.currencySymbol,
              style: const TextStyle(fontFamily: "nunito")),
          TextSpan(text: splitAmount[1]),
        ],
      ),
    );

    //   Row(
    //   mainAxisSize: MainAxisSize.min,
    //   children: [
    //     Text(
    //       nairaCurrency.currencySymbol,
    //       style: TextStyle(
    //         fontFamily: "nunito",
    //         fontSize: fontSize,
    //         fontWeight: fontWeight,
    //         color: color,
    //       ),
    //       textAlign: align,
    //     ),
    //     Text(
    //       splitAmount[1],
    //       style: TextStyle(
    //         fontSize: fontSize,
    //         fontWeight: fontWeight,
    //         color: color,
    //       ),
    //       textAlign: align,
    //     ),
    //   ],
    // );
  }
}
