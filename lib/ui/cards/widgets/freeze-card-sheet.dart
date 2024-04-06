import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/ui/cards/card.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/bottomsheet-widgets.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';

class FreezeCardBottomSheet extends StatelessWidget {
  const FreezeCardBottomSheet({super.key});

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
                  header("Freeze Virtual Card", usePadding: false),
                  32.0.sbH,
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
                            "Freezing the card will temporarily suspend its usage for any transactions.",
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
                  AutoSizeText(
                    "Your card details will remain secure, but you won't be able to use it for purchases or payments until you unfreeze it.",
                    style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                  const Spacer(),
                  UiButton(
                    text: "Freeze Card",
                    color: AppColors.errorCode,
                    onPressed: () async {
                      await model.freezeCard();
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

class DeleteCardBottomSheet extends StatelessWidget {
  const DeleteCardBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                header("Delete Virtual Card", usePadding: false),
                32.0.sbH,
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
                          "Your card will be permanently deleted. You can’t undone this action.",
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
                AutoSizeText(
                  "Any funds on your card will be converted from USD to NGN using the current exchange rate. Funds will be moved to your NGN wallet\n\nIf you decide to create a new card, you will have to pay another creation fee.",
                  style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w400, fontSize: 16),
                ),
                const Spacer(),
                UiButton(
                  text: "Delete Card",
                  color: AppColors.errorCode,
                  onPressed: () {},
                ),
                24.sbH,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

freezeOrDeleteCardBottomSheet(BuildContext context, {bool isDelete = false}) {
  showModalBottomSheet(
      enableDrag: true,
      isDismissible: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return isDelete
            ? const DeleteCardBottomSheet()
            : const FreezeCardBottomSheet();
      });
}
