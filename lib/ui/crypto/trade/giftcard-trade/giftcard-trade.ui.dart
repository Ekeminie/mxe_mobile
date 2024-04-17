import 'package:cached_network_image/cached_network_image.dart';
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

class GiftCardTrade extends StatefulWidget {
  const GiftCardTrade({super.key});

  @override
  State<GiftCardTrade> createState() => _GiftCardTradeState();
}

class _GiftCardTradeState extends State<GiftCardTrade> {
  ValueNotifier<GiftCardCountryEnum> selectedTab =
      ValueNotifier(GiftCardCountryEnum.us);
  @override
  Widget build(BuildContext context) {
    return BaseView<FinanceViewModel>(
      onModelReady: (m) => m.init(),
      builder: (context, model, child) => Scaffold(
        body: Container(
          decoration: const BoxDecoration(color: AppColors.bgColor),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: ValueListenableBuilder(
            valueListenable: selectedTab,
            builder: (context, tab, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                12.sbH,
                header("Trade", usePadding: false),
                12.sbH,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: GiftCardCountryEnum.values
                      .map((e) => GestureDetector(
                            onTap: () => selectedTab.value = e,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
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
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child:
                                            SvgPicture.asset("${e.icon}".svg)),
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
                24.sbH,
                Expanded(
                  child: GridView.count(
                    // controller: model.controller,
                    padding: const EdgeInsets.all(4),
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 0.h,
                    physics: const ClampingScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 1.6,
                    shrinkWrap: true,
                    children: ["", '', '', '', '', '', '', '', '', '', '', '']
                        .map((e) => GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, Routes.giftCardDetailsPage,
                                  arguments: e),
                              child: Container(
                                height: 100,
                                margin: EdgeInsets.symmetric(vertical: 6),
                                decoration: BoxDecoration(
                                    color: AppColors.subtleAccent,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Stack(
                                  children: [
                                    Positioned(
                                        left: 20,
                                        top: 40,
                                        child: Text(
                                          "Apple",
                                          style: AppTextStyle.headingHeading4,
                                        )),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      height: 100.h,
                                      width: 100,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          child: IntrinsicWidth(
                                            child: CachedNetworkImage(
                                              imageUrl: "",
                                              fit: BoxFit.cover,
                                              errorWidget: (context, _, __) =>
                                                  Container(
                                                      height: 100.h,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                                'itunes-apple'
                                                                    .png),
                                                            fit: BoxFit.cover),
                                                      )),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum GiftCardCountryEnum {
  us(code: 0, title: "United States", icon: 'us'),
  uk(code: 1, title: "United Kingdom", icon: 'uk');

  final String? title;
  final num? code;
  final String? icon;
  const GiftCardCountryEnum({this.title, this.code, this.icon});
}
