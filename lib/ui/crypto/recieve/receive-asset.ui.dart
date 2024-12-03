import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/textstyles.dart';
import 'package:mxe_mobile/ui/crypto/recieve/receive-asset.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';

class ReceiveAssetPage extends StatefulWidget {
  const ReceiveAssetPage({super.key});

  @override
  State<ReceiveAssetPage> createState() => _ReceiveAssetPageState();
}

class _ReceiveAssetPageState extends State<ReceiveAssetPage> {
  ValueNotifier<int> page = ValueNotifier(0);
  ValueNotifier<int> progress = ValueNotifier(1);
  @override
  Widget build(BuildContext context) {
    return BaseView<ReceiveAssetsViewModel>(
      builder: (context, model, child) => ValueListenableBuilder(
        valueListenable: page,
        builder: (context, index, _) => Builder(
          builder: (context) {
            switch (index) {
              case 0:
                return Scaffold(
                  appBar: customAppBar(""),
                  body: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Spacer(),
                        const Text(
                          "Only send Bitcoin (BTC) to this address",
                          style: AppTextStyle.labelLgBold,
                          textAlign: TextAlign.center,
                        ),
                        16.sbH,
                        const Text(
                          "Sending any other asset to this address will lead to loss of asset.",
                          style: AppTextStyle.paragraphMd,
                          textAlign: TextAlign.center,
                        ),
                        40.sbH,
                        Spacer(),
                        UiButton(
                          text: "I Understand",
                          onPressed: () => page.value = 1,
                        ),
                        40.sbH,
                      ],
                    ),
                  ),
                );
              case 1:
                return Scaffold(
                  appBar: customAppBar("", actions: [
                    Row(
                      children: [
                        SvgPicture.asset('refresh'.svg),
                        12.sbW,
                        SvgPicture.asset('share-icon'.svg),
                        16.sbW,
                      ],
                    )
                  ]),
                  body: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        header("Receive Bitcoin", usePadding: false),
                        32.sbH,
                        Row(
                          children: [
                            SvgPicture.asset(
                              "btc".svg,
                            ),
                            16.sbW,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Bitcoin",
                                  style: AppTextStyle.headingHeading3
                                      .copyWith(color: AppColors.bgContrast),
                                ),
                                Text(
                                  'BTC',
                                  style: AppTextStyle.paragraphSm
                                      .copyWith(color: AppColors.textLight),
                                ),
                              ],
                            ),
                          ],
                        ),
                        16.sbH,
                        Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(child: Image.asset('qr-code'.png))),
                        16.sbH,
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Address",
                            style: AppTextStyle.labelXsRegular
                                .copyWith(color: AppColors.textLight),
                          ),
                        ),
                        4.sbH,
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              const Text(
                                "xgajsymnz56JK92gc56092yh90rfsz5yus",
                                style: AppTextStyle.labelMdRegular,
                              ),
                              8.sbW,
                              SvgPicture.asset('copy-small'.svg),
                            ],
                          ),
                        ),
                        16.sbH,
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: Color(0xffFFFBE5)),
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  "This address can only be used to receive Bitcoin.",
                                  style: AppTextStyle.labelMdBold
                                      .copyWith(color: Color(0xffE6BF00)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        12.sbH,
                        CustomProgressBar(index: 3),
                        Spacer(),
                        UiButton(
                          text: "Done",
                          onPressed: () => Navigator.pop(context),
                        ),
                        40.sbH,
                      ],
                    ),
                  ),
                );
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}

class ProgressCircle extends StatelessWidget {
  final int index;

  const ProgressCircle({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: index > 0,
            child: body()),
        8.sbW,
        Visibility(
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: index > 1,
            child: body()),
        8.sbW,
        Visibility(
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            visible: index > 2,
            child: body())
      ],
    );
  }

  Container body() {
    return Container(
      height: 20,
      width: 20,
      decoration: const BoxDecoration(
          shape: BoxShape.circle, color: AppColors.moderateBlue),
    );
  }
}

class CustomProgressBar extends StatelessWidget {
  final int index;

  CustomProgressBar({required this.index});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double progressWidth;
    Color progressColor;

    switch (index) {
      case 1:
        progressWidth = screenWidth / 3;
        progressColor = AppColors.moderateBlue;
        break;
      case 2:
        progressWidth = (screenWidth / 3) * 2;
        progressColor = AppColors.moderateBlue;
        break;
      case 3:
        progressWidth = screenWidth;
        progressColor = AppColors.moderateBlue;
        break;
      default:
        throw Exception("Invalid index value");
    }

    return Container(
      width: screenWidth,
      height: 3,
      decoration: BoxDecoration(
        color: AppColors.subtleAccent,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        children: [
          Container(
            width: progressWidth,
            height: 2,
            decoration: BoxDecoration(
              color: progressColor,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ],
      ),
    );
  }
}
