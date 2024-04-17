import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/textstyles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/crypto/trade/crypto-trade/crypto-trade.ui.dart';
import 'package:mxe_mobile/ui/home/finance/finance.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';

class ViewCurrencyPage extends StatefulWidget {
  final TAsset asset;
  const ViewCurrencyPage({super.key, required this.asset});

  @override
  State<ViewCurrencyPage> createState() => _ViewCurrencyPageState();
}

class _ViewCurrencyPageState extends State<ViewCurrencyPage> {
  ValueNotifier<CryptoTimeTabsEnum> selectedTab =
      ValueNotifier(CryptoTimeTabsEnum.oneHour);
  @override
  Widget build(BuildContext context) {
    return BaseView<FinanceViewModel>(
      builder: (context, model, child) => Scaffold(
        appBar: customAppBar("", actions: [
          Row(
            children: [
              SvgPicture.asset("heart".svg),
              18.sbW,
            ],
          )
        ]),
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: ValueListenableBuilder(
              valueListenable: selectedTab,
              builder: (context, tab, _) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(
                            context, Routes.aboutCurrencyPage,
                            arguments: widget.asset),
                        child: SvgPicture.asset(
                          widget.asset.icon!,
                          height: 43,
                          width: 43,
                        ),
                      ),
                      16.sbW,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.asset.title!,
                            style: AppTextStyle.headingHeading3
                                .copyWith(color: AppColors.bgContrast),
                          ),
                          10.sbH,
                          Text(
                            widget.asset.sub!,
                            style: AppTextStyle.paragraphSm
                                .copyWith(color: AppColors.textLight),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    "\$${widget.asset.price!}",
                    style: AppTextStyle.headingHeading1,
                  ),
                  Row(
                    children: [
                      Text(
                        "${widget.asset.pNL ? "+" : "-"}0.2323123213(0.34%) ",
                        style: AppTextStyle.labelXsRegular.copyWith(
                            color:
                                widget.asset.pNL ? Colors.green : Colors.red),
                      ),
                      Text(" Over the last hour")
                    ],
                  ),
                  350.sbH,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: CryptoTimeTabsEnum.values
                        .map((e) => GestureDetector(
                              onTap: () => selectedTab.value = e,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: tab == e
                                        ? AppColors.moderateBlue
                                        : Colors.transparent,
                                    border: Border.all(
                                        color: tab == e
                                            ? Colors.transparent
                                            : AppColors.accentColor,
                                        width: 2)),
                                child: Text(
                                  e.title!,
                                  style: AppTextStyle.labelMdBold.copyWith(
                                      color: tab == e
                                          ? AppColors.white
                                          : AppColors.moderateBlue),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  24.sbH,
                  Text(
                    "Market Stats",
                    style: AppTextStyle.headingHeading3,
                  ),
                  16.sbH,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Volume (24H)",
                        style: AppTextStyle.paragraphMd,
                      ),
                      Text(
                        "\$220.50K",
                        style: AppTextStyle.paragraphMd,
                      )
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "All-time High",
                        style: AppTextStyle.paragraphMd,
                      ),
                      Text(
                        "\$93.30K",
                        style: AppTextStyle.paragraphMd,
                      )
                    ],
                  ),
                  34.sbH,
                  UiButton(
                    text: "Sell ${widget.asset.title}",
                    onPressed: () {},
                  ),
                  12.sbH,
                  50.sbH,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum CryptoTimeTabsEnum {
  oneHour(
    code: 0,
    title: "1H",
  ),
  oneDay(
    code: 1,
    title: "1D",
  ),
  oneWeek(
    code: 2,
    title: "1W",
  ),
  oneMonth(
    code: 3,
    title: "1M",
  ),
  oneYear(
    code: 4,
    title: "1Y",
  );

  final String? title;
  final num? code;
  const CryptoTimeTabsEnum({
    this.title,
    this.code,
  });
}
