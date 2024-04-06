import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/textstyles.dart';
import 'package:mxe_mobile/ui/crypto/intro/widgets/select-wallet-sheet.dart';
import 'package:mxe_mobile/utils/string%20utils.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';

class ImportSeedPhraseSheet extends StatelessWidget {
  final Function(String) onSubmit;
  ImportSeedPhraseSheet({super.key, required this.onSubmit});

  final ValueNotifier<String?> phrase = ValueNotifier(null);
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
                    16.0.sbH,
                    header("Import Seed Phrase or Private Key",
                        usePadding: false),
                    Flexible(
                      child: AutoSizeText(
                        "If you are importing a wallet that uses seed phrase, make sure you use space between words",
                        style: AppTextStyle.labelMdRegular
                            .copyWith(color: AppColors.bgContrast),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    24.0.sbH,
                    Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.accentColor, width: 4),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.moderateBlue, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ValueListenableBuilder(
                            valueListenable: phrase,
                            builder: (context, seed, _) => AutoSizeText(
                              seed ?? "Enter Seed Phrase or Private Key",
                              style: AppTextStyle.paragraphMd.copyWith(
                                  color: seed.isNotNullNorEmpty
                                      ? AppColors.moderateBlue
                                      : AppColors.textLight),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: GestureDetector(
                          onTap: () async =>
                              phrase.value = await getClipboardText(),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.paste,
                                color: AppColors.bgContrast,
                              ),
                              Text("Paste",
                                  style: AppTextStyle.paragraphMd
                                      .copyWith(color: AppColors.bgContrast))
                            ],
                          ),
                        ),
                      ),
                    ),
                    32.sbH,
                    16.sbH,
                    const Spacer(
                      flex: 3,
                    ),
                    ValueListenableBuilder(
                      valueListenable: phrase,
                      builder: (contex, seed, _) => UiButton(
                        text: "Okay",
                        onPressed: seed.isNotNullNorEmpty
                            ? () async {
                                await selectCryptoWalletSheet(
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
                                onSubmit('abc, abcd, efg, hijk');
                              }
                            : null,
                      ),
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

seedPhraseSheet(BuildContext context, {required Function(String) onSubmit}) {
  showModalBottomSheet(
      enableDrag: true,
      isDismissible: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return ImportSeedPhraseSheet(
          onSubmit: onSubmit,
        );
      });
}
