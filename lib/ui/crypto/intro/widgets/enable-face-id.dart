import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/textstyles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/cards/card.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/bottomsheet-widgets.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';

class EnableFaceIDSheet extends StatelessWidget {
  const EnableFaceIDSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<CardViewModel>(
      builder: (context, model, child) => SingleChildScrollView(
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  8.0.sbH,
                  const SheetHandle(),
                  36.0.sbH,
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    behavior: HitTestBehavior.opaque,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: SvgPicture.asset('close-icon'.svg)),
                  ),
                  34.0.sbH,
                  header("Enable Face ID to access wallet", usePadding: false),
                  32.0.sbH,
                  Flexible(
                    child: AutoSizeText(
                      "Once enabled, you can unlock wallets or make transactions by verifying your Face ID. ",
                      style: AppTextStyle.labelMdRegular
                          .copyWith(color: AppColors.boldSemantic),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  32.sbH,
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                        color: AppColors.yellowBg,
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        const Icon(Icons.info_outline_rounded),
                        16.sbW,
                        Flexible(
                          child: AutoSizeText(
                            "To protect your assets, make sure the facial information on your device is trustworthy",
                            style: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: AppColors.yellowText),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                  16.sbH,
                  const Spacer(
                    flex: 3,
                  ),
                  UiButton(
                    text: "Enable Now",
                    onPressed: () async {
                      Navigator.pushReplacementNamed(
                          context, Routes.cryptoHome);
                    },
                  ),
                  12.sbH,
                  UiButton(
                    text: "Maybe Later",
                    color: AppColors.subtleAccent,
                    textColor: AppColors.moderateBlue,
                    onPressed: () async {
                      Navigator.pushReplacementNamed(
                          context, Routes.cryptoHome);
                    },
                  ),
                  24.sbH,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enableFaceIdBottomSheet(BuildContext context) {
  showModalBottomSheet(
      enableDrag: true,
      isDismissible: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return const EnableFaceIDSheet();
      });
}
