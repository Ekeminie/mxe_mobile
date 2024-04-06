import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/textstyles.dart';
import 'package:mxe_mobile/ui/crypto/intro/widgets/import-seed-phrase.dart';
import 'package:mxe_mobile/ui/crypto/intro/widgets/security-tips-sheet.dart';
import 'package:mxe_mobile/ui/crypto/intro/widgets/select-wallet-sheet.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/bottomsheet-widgets.dart';

class HaveWalletBottomSheet extends StatelessWidget {
  HaveWalletBottomSheet({Key? key}) : super(key: key);

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
                onTap: () async {
                  securityTipsSheet(context, onSubmit: () async {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    await seedPhraseSheet(context, onSubmit: (v) {
                      debugPrint(v.toString());
                      print('rest');
                      selectCryptoWalletSheet(
                        context,
                        onSubmit: () {
                          // showNewTransferPinBottomSheet(
                          //   context,
                          //   onCompleted: (c) => uService.transactionPin = c,
                          //   onDone: () => Navigator.pushReplacementNamed(
                          //     context,
                          //     Routes.cryptoHome,
                          //   ),
                          // );
                        },
                      );
                    });
                  });
                },
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Import Seed Phrase or Private key",
                            style: AppTextStyle.labelMdRegular
                                .copyWith(color: AppColors.bgContrast),
                          ),
                          8.sbH,
                          Text(
                            "Enter 12, 18 o 24-word seed phrase or enter your private key",
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
              42.sbH,
              GestureDetector(
                onTap: () => {},
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "iCloud Backup",
                            style: AppTextStyle.labelMdRegular
                                .copyWith(color: AppColors.bgContrast),
                          ),
                          8.sbH,
                          Text(
                            "Get seed phrase from iCloud backup to restore wallet",
                            style: AppTextStyle.labelSmRegular
                                .copyWith(color: AppColors.textLight),
                          ),
                        ],
                      ),
                    ),
                    SvgPicture.asset('icloud-backup'.svg),
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

haveWalletBottomSheet(BuildContext context) {
  showModalBottomSheet(
      enableDrag: true,
      isDismissible: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return HaveWalletBottomSheet();
      });
}
