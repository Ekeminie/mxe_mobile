import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/textstyles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/home/finance/finance.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';

class CryptoTradePage extends StatefulWidget {
  const CryptoTradePage({super.key});

  @override
  State<CryptoTradePage> createState() => _CryptoTradePageState();
}

class _CryptoTradePageState extends State<CryptoTradePage> {
  ValueNotifier<CryptoTabsEnum> selectedTab = ValueNotifier(CryptoTabsEnum.all);
  @override
  Widget build(BuildContext context) {
    return BaseView<FinanceViewModel>(
      builder: (context, model, child) => SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(color: AppColors.bgColor),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: ValueListenableBuilder(
            valueListenable: selectedTab,
            builder: (context, tab, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header("Trade", usePadding: false),
                12.sbH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: CryptoTabsEnum.values
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
                              child: Row(
                                children: [
                                  if (e.icon != null)
                                    SvgPicture.asset(
                                        "${e.icon}${tab == e ? "white" : "blue"}"
                                            .svg),
                                  if (e.icon != null) 8.sbW,
                                  Text(
                                    e.title!,
                                    style: AppTextStyle.labelMdBold.copyWith(
                                        color: tab == e
                                            ? AppColors.white
                                            : AppColors.moderateBlue),
                                  )
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
                12.sbH,
                body(tab),
                50.sbH,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget body(CryptoTabsEnum e) {
    switch (e) {
      case CryptoTabsEnum.all:
        return AllTrade(
          list: currencies,
          index: 0,
        );
      case CryptoTabsEnum.watchlist:
        return const AllTrade(
          list: [],
          index: 1,
        );
      case CryptoTabsEnum.topMovers:
        return AllTrade(
          list: currencies.sublist(0, 4),
          index: 2,
        );
      default:
        return AllTrade(
          list: currencies,
          index: 0,
        );
    }
  }
}

class AllTrade extends StatelessWidget {
  final int index;
  final List<TAsset> list;
  const AllTrade({super.key, required this.list, this.index = 0});

  @override
  Widget build(BuildContext context) {
    return (list.length != 0)
        ? Column(
            children: list
                .map((e) => GestureDetector(
                      onTap: () => Navigator.pushNamed(
                          context, Routes.currencyViewPageRoute,
                          arguments: e),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  e.icon!,
                                  height: 24,
                                  width: 24,
                                ),
                                16.sbW,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      e.title!,
                                      style: AppTextStyle.labelMdRegular
                                          .copyWith(
                                              color: AppColors.bgContrast),
                                    ),
                                    10.sbH,
                                    Text(
                                      e.sub!,
                                      style: AppTextStyle.labelXsRegular
                                          .copyWith(color: AppColors.textLight),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "\$${e.price!}",
                                      style: AppTextStyle.paragraphMd.copyWith(
                                          color: AppColors.bgContrast),
                                    ),
                                    10.sbH,
                                    Text(
                                      "${e.pNL ? "+" : "-"}0.2323123213(0.34%)",
                                      style: AppTextStyle.labelXsRegular
                                          .copyWith(
                                              color: e.pNL
                                                  ? Colors.green
                                                  : Colors.red),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            4.sbH,
                            const Divider(),
                          ],
                        ),
                      ),
                    ))
                .toList())
        : emptyState(index);
  }

  Widget emptyState(int index) {
    switch (index) {
      case 0:
        return Column();
      case 1:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [200.sbH, SvgPicture.asset('fav-empty-state'.svg)],
        );
      case 2:
        return Column();
      default:
        return Column();
    }
  }
}

enum CryptoTabsEnum {
  all(
    code: 0,
    title: "All",
  ),
  watchlist(
    code: 1,
    title: "Watchlist",
    icon: "fav-outline-",
  ),
  topMovers(
    code: 2,
    title: "Top Movers",
  );

  final String? title;
  final num? code;
  final String? icon;
  const CryptoTabsEnum({this.title, this.code, this.icon});
}

class TAsset {
  final String? title;
  final String? sub;
  final String? price;
  final String? icon;
  final bool pNL;
  TAsset({this.title, this.sub, this.price, this.pNL = false, this.icon});
}

List<TAsset> currencies = [
  TAsset(
      title: "Avalanche",
      sub: "AVAX",
      icon: "tm-avalanche".svg,
      price: "17.81",
      pNL: true),
  TAsset(
      title: "Ethereum",
      sub: "ETH",
      icon: "tm-eth".svg,
      price: "200.81",
      pNL: true),
  TAsset(
      title: "Litecoin",
      sub: "LTC",
      icon: "tm-ltc".svg,
      price: "17.81",
      pNL: false),
  TAsset(
      title: "Avalanche",
      sub: "AVAX",
      icon: "tm-avalanche".svg,
      price: "17.81",
      pNL: true),
  TAsset(
      title: "POLKA",
      sub: "POLK",
      icon: "tm-polka".svg,
      price: "17.81",
      pNL: false),
  TAsset(
      title: "RIPPLE",
      sub: "XRP",
      icon: "tm-ripple".svg,
      price: "17.81",
      pNL: true),
  TAsset(
      title: "SHIBA INU",
      sub: "SHIBA",
      icon: "tm-shiba".svg,
      price: "17.81",
      pNL: false),
  TAsset(
      title: "SOLANA",
      sub: "SOL",
      icon: "tm-solana".svg,
      price: "17.81",
      pNL: true),
  TAsset(
      title: "USDT",
      sub: "USDT",
      icon: "tm-usdt".svg,
      price: "17.81",
      pNL: true),
];
