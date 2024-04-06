import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/textstyles.dart';
import 'package:mxe_mobile/ui/crypto/intro/widgets/already-have-wallet-bottomsheet.dart';
import 'package:mxe_mobile/ui/crypto/intro/widgets/enable-face-id.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/bottomsheet-widgets.dart';

class CreateWalletBottomSheet extends StatelessWidget {
  CreateWalletBottomSheet({Key? key}) : super(key: key);

  ValueNotifier<bool> light = ValueNotifier(true);
  ValueNotifier<bool> dark = ValueNotifier(false);
  ValueNotifier<bool> defaultOs = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      child: Container(
        padding: EdgeInsets.only(
            // right: 20,
            // left: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        color: Colors.white,
        // height: 500,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SheetHandle(),
              34.0.sbH,
              GestureDetector(
                onTap: () =>
                    {Navigator.pop(context), enableFaceIdBottomSheet(context)},
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Create Wallet",
                            style: AppTextStyle.labelMdRegular
                                .copyWith(color: AppColors.bgContrast),
                          ),
                          8.sbH,
                          Text(
                            "Create a new seed phrase wallet",
                            style: AppTextStyle.labelSmRegular
                                .copyWith(color: AppColors.textLight),
                          ),
                        ],
                      ),
                    ),
                    SvgPicture.asset('create-wallet'.svg),
                  ],
                ),
              ),
              42.sbH,
              GestureDetector(
                onTap: () => {Navigator.pop(context),haveWalletBottomSheet(context)},
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Import Wallet",
                            style: AppTextStyle.labelMdRegular
                                .copyWith(color: AppColors.bgContrast),
                          ),
                          8.sbH,
                          Text(
                            "Import wallet using seed phrase, private key or iCloud backup",
                            style: AppTextStyle.labelSmRegular
                                .copyWith(color: AppColors.textLight),
                          ),
                        ],
                      ),
                    ),
                    SvgPicture.asset('import-wallet'.svg),
                  ],
                ),
              ),
              32.sbH,
            ],
          ),
        ),
      ),
    );
  }
}

createWalletBottomSheet(BuildContext context) {
  showModalBottomSheet(
      enableDrag: true,
      isDismissible: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return CreateWalletBottomSheet();
      });
}
