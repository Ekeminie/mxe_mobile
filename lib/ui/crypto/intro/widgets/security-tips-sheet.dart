import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/textstyles.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';

class SecurityTipsSheet extends StatelessWidget {
  final Function() onSubmit;
  const SecurityTipsSheet({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        appBar:
            customAppBar("", bgColor: AppColors.bgColor, showBackButton: false),
        body: SingleChildScrollView(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            child: Container(
              height: height(context) - 100,
              padding: EdgeInsets.only(
                  // right: 20,
                  // left: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              color: AppColors.bgColor,
              // height: 500,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BackButton(),
                    Center(child: SvgPicture.asset('security-tips'.svg)),
                    16.0.sbH,
                    header("Security Tips", usePadding: false),
                    24.0.sbH,
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: AutoSizeText(
                              "Beware of Scams",
                              style: AppTextStyle.labelMdBold
                                  .copyWith(color: AppColors.bgContrast),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          12.sbH,
                          Flexible(
                            child: AutoSizeText(
                              "Don’t import any unfamiliar seed phrase or private key. MXE will never provide such information and if anyone does, beware of potential scams.",
                              style: AppTextStyle.labelMdRegular
                                  .copyWith(color: AppColors.bgContrast),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                    12.sbH,
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: AutoSizeText(
                              "You are in Control",
                              style: AppTextStyle.labelMdBold
                                  .copyWith(color: AppColors.bgContrast),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          12.sbH,
                          Flexible(
                            child: AutoSizeText(
                              "MXE never saves your seed phrase or private key. Keep them safe and be at alert as your assets can be stolen if your seed phrase or private key is stolen",
                              style: AppTextStyle.labelMdRegular
                                  .copyWith(color: AppColors.bgContrast),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                    32.sbH,
                    16.sbH,
                    const Spacer(
                      flex: 3,
                    ),
                    UiButton(
                      text: "Okay",
                      onPressed: onSubmit,
                    ),
                    24.sbH,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

securityTipsSheet(BuildContext context, {Function()? onSubmit}) {
  showModalBottomSheet(
      enableDrag: true,
      isDismissible: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SecurityTipsSheet(
          onSubmit: onSubmit!,
        );
      });
}
