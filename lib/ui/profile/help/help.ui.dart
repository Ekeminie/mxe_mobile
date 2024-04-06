import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/textstyles.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/custom-accordion.dart';
import 'package:mxe_mobile/widgets/input.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  ValueNotifier<bool> balance = ValueNotifier(false);
  ValueNotifier<bool> faceId = ValueNotifier(false);

  ValueNotifier<bool> use = ValueNotifier(false);
  ValueNotifier<bool> rate = ValueNotifier(false);
  ValueNotifier<bool> fees = ValueNotifier(false);
  ValueNotifier<bool> onSelected = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: AppColors.bgColor),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Frame2Widget(
                child: IntrinsicHeight(
                  child: Container(
                    // height: .h,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    child: Column(
                      children: [
                        Text(
                          "Hi Odafe, how can we help?",
                          style: AppTextStyle.headingHeading2
                              .copyWith(color: AppColors.white),
                        ),
                        16.sbH,
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(14)),
                          child: Input(
                            hintText: "Search",
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              32.sbH,
              GestureDetector(
                onTap: () {},
                behavior: HitTestBehavior.opaque,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding:
                      const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset("support-chat".svg),
                      16.sbW,
                      const AutoSizeText(
                        "Talk to MXE",
                        style: AppTextStyle.labelMdRegular,
                      ),
                      const Spacer(),
                      SvgPicture.asset('chevron-right'.svg)
                    ],
                  ),
                ),
              ),
              32.sbH,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Frequently Asked Questions",
                  style: AppTextStyle.labelLgBold
                      .copyWith(color: AppColors.bgContrast),
                ),
              ),
              16.sbH,
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: map.entries
                      .map((e) => CustomAccordion(
                          builder: (context, expand) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  12.sbH,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: AutoSizeText(
                                          e.key,
                                          style: AppTextStyle.headingHeading4,
                                        ),
                                      ),
                                      expand
                                          ? SvgPicture.asset(
                                              'chevron-down'.svg,
                                            )
                                          : SvgPicture.asset(
                                              'chevron-right'.svg),
                                    ],
                                  ),
                                  16.sbH,
                                  if (expand)
                                    AutoSizeText(
                                      "${e.value}\n",
                                      style: AppTextStyle.paragraphSm,
                                    ),
                                  const Divider(),
                                  12.sbH,
                                ],
                              )))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Frame2Widget extends StatelessWidget {
  final Widget? child;
  const Frame2Widget({super.key, this.child});
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator FrameWidget - FRAME
    return Container(
        width: double.infinity,
        height: 300,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment(-0.5182339549064636, -0.19736452400684357),
              end: Alignment(0.19736452400684357, -0.19326947629451752),
              colors: [
                Color.fromRGBO(14, 35, 101, 1),
                Color.fromRGBO(68, 165, 253, 1)
              ]),
        ),
        child: Stack(children: <Widget>[
          Positioned(
              top: 30,
              left: -5,
              child: SvgPicture.asset(
                'line2'.svg,
                semanticsLabel: 'vector',
                fit: BoxFit.fill,
              )),
          Align(alignment: Alignment.center, child: child),
        ]));
  }
}

Map<String, String> map = {
  "How do I fund my  wallet?":
      "You can fund your MXE account through various methods, including bank transfers, credit/debit card transactions, and cryptocurrency deposits.",
  "How do I convert Naira to Pounds":
      "You can fund your MXE account through various methods, including bank transfers, credit/debit card transactions, and cryptocurrency deposits.",
  "How do I get a statement if my account is closed?":
      "You can fund your MXE account through various methods, including bank transfers, credit/debit card transactions, and cryptocurrency deposits.",
  "Can I request my transaction history if my account has been closed?":
      "You can fund your MXE account through various methods, including bank transfers, credit/debit card transactions, and cryptocurrency deposits.",
};
