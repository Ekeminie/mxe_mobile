import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/textstyles.dart';
import 'package:mxe_mobile/ui/crypto/home/backup/backup.vm.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';
import 'package:mxe_mobile/widgets/toast.dart';
import 'package:mxe_mobile/widgets/transaction-pin/bills-pin.dart';

class CryptoWalletBackupPage extends StatefulWidget {
  const CryptoWalletBackupPage({super.key});

  @override
  createState() => CryptoWalletBackupPageState();
}

class CryptoWalletBackupPageState extends State<CryptoWalletBackupPage> {
  ValueNotifier<num> page = ValueNotifier(0);

  ValueNotifier<List<bool?>> answers = ValueNotifier([null, null, null]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        "",
      ),
      body: BaseView<BackUpCryptoViewModel>(
          builder: (context, model, child) => SafeArea(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: ValueListenableBuilder(
                    valueListenable: page,
                    builder: (context, pageIndex, _) => Builder(
                      builder: (context) {
                        switch (pageIndex) {
                          case 0:
                            return Column(
                              children: [
                                header("Backup Wallet", usePadding: false),
                                32.sbH,
                                Text(
                                  "You can write down the words in order and keep them stored in a secure location.",
                                  style: AppTextStyle.labelMdRegular
                                      .copyWith(color: AppColors.grey),
                                ),
                                32.sbH,
                                Expanded(
                                  child: GridView.builder(
                                    shrinkWrap: false,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            mainAxisSpacing: 16.0,
                                            crossAxisSpacing: 8.0,
                                            childAspectRatio: 2.9 / 1),
                                    itemCount: list.length,
                                    itemBuilder: (context, index) {
                                      return Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: AppColors.subtleAccent,
                                              borderRadius:
                                                  BorderRadius.circular(24)),
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Text(list[index],
                                                style: AppTextStyle.labelSmBold
                                                    .copyWith(
                                                        color: AppColors
                                                            .moderateBlue)),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                36.sbH,
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                      color: AppColors.yellowBg,
                                      borderRadius: BorderRadius.circular(24)),
                                  child: Flexible(
                                    child: AutoSizeText(
                                      "MXE will never ask for your seed phrase, so don’t share it with anyone. ",
                                      style: AppTextStyle.labelMdBold.copyWith(
                                          color: AppColors.yellowText),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                36.sbH,
                                UiButton(
                                    text: "Continue",
                                    onPressed: () => page.value = 1),
                                40.sbH,
                              ],
                            );
                          case 1:
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                header("Verify Seed Phrase", usePadding: false),
                                32.sbH,
                                WordTriviaTiles(
                                    index: 3,
                                    words: getThreeWords(3),
                                    onSelected: (v) {
                                      print(v);
                                      answers.value[0] = v;
                                    }),
                                32.sbH,
                                WordTriviaTiles(
                                    index: 7,
                                    words: getThreeWords(7),
                                    onSelected: (v) {
                                      print(v);
                                      answers.value[1] = v;
                                    }),
                                32.sbH,
                                WordTriviaTiles(
                                    key: Key('llk'),
                                    index: 10,
                                    words: getThreeWords(10),
                                    onSelected: (v) {
                                      print(v);
                                      answers.value[2] = v;
                                      print(answers.value);
                                    }),
                                32.sbH,
                                const Spacer(),
                                ValueListenableBuilder(
                                  valueListenable: answers,
                                  builder: (context, values, _) => UiButton(
                                    text: "Continue",
                                    onPressed: () {
                                      if (values.hasNullValue()) {
                                        showCustomToast(
                                            "Please select an answer for each");
                                      } else {
                                        showNewTransferPinBottomSheet(context,
                                            onCompleted: (c) => model
                                                .userService.transactionPin = c,
                                            onDone: () {
                                              if (values.allTrue()) {
                                              } else {
                                                showCustomToast("");
                                              }
                                            });
                                      }
                                    },
                                  ),
                                ),
                                40.sbH,
                              ],
                            );
                          default:
                            return Column(
                              children: [
                                header("Backup Wallet", usePadding: false),
                                32.sbH,
                                Text(
                                  "You can write down the words in order and keep them stored in a secure location.",
                                  style: AppTextStyle.labelMdRegular
                                      .copyWith(color: AppColors.grey),
                                ),
                                32.sbH,
                                Expanded(
                                  child: GridView.builder(
                                    shrinkWrap: false,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            mainAxisSpacing: 16.0,
                                            crossAxisSpacing: 8.0,
                                            childAspectRatio: 2.9 / 1),
                                    itemCount: list.length,
                                    itemBuilder: (context, index) {
                                      return Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: AppColors.subtleAccent,
                                              borderRadius:
                                                  BorderRadius.circular(24)),
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Text(list[index],
                                                style: AppTextStyle.labelSmBold
                                                    .copyWith(
                                                        color: AppColors
                                                            .moderateBlue)),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                36.sbH,
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                      color: AppColors.yellowBg,
                                      borderRadius: BorderRadius.circular(24)),
                                  child: Flexible(
                                    child: AutoSizeText(
                                      "MXE will never ask for your seed phrase, so don’t share it with anyone. ",
                                      style: AppTextStyle.labelMdBold.copyWith(
                                          color: AppColors.yellowText),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                36.sbH,
                                UiButton(
                                  text: "Continue",
                                  onPressed: () {},
                                ),
                                40.sbH,
                              ],
                            );
                        }
                      },
                    ),
                  ),
                ),
              )),
    );
  }
}

List<String> list = [
  'Ghost',
  'Grand',
  'Scheme',
  'Orbit',
  'Manual',
  'Receive',
  'Dog',
  'Sly',
  'Retrieve',
  'Annual',
  'Elf',
  'Sample'
];

List<String> getThreeWords(num index) {
  index = index - 1;
  if (list.length < 3 || index < 0 || index >= list.length) {
    throw ArgumentError('Invalid input');
  }

  List<String> result = [];
  result.add(list[index.toInt()]);

  // Generate two random indices different from the specified index
  List<int> randomIndices = List.generate(list.length, (i) => i)
      .where((i) => i != index)
      .toList()
    ..shuffle();

  // Add words corresponding to the randomly selected indices
  result.add(list[randomIndices[0]]);
  result.add(list[randomIndices[1]]);
  result.shuffle();
  result.shuffle();
  result.shuffle();
  return result;
}

class WordTriviaTiles extends StatelessWidget {
  final num index;
  final List words;
  final Function(bool) onSelected;
  WordTriviaTiles(
      {super.key,
      required this.index,
      required this.words,
      required this.onSelected});
  ValueNotifier<String?> word = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Word #$index",
          style: AppTextStyle.labelMdBold,
        ),
        24.sbH,
        ValueListenableBuilder(
          valueListenable: word,
          builder: (context, selected, _) => Row(
            children: words
                .map((e) => GestureDetector(
                      onTap: () => {
                        word.value = e,
                        onSelected(e == list[index.toInt() - 1])
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                            color: selected == e
                                ? AppColors.moderateBlue
                                : AppColors.subtleAccent,
                            borderRadius: BorderRadius.circular(24)),
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(e,
                              style: AppTextStyle.labelSmBold.copyWith(
                                  color: selected == e
                                      ? AppColors.white
                                      : AppColors.moderateBlue)),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}

extension BoolListExtensions on List<bool?> {
  // Method to check and return true if the list has a null value
  bool hasNullValue() {
    return any((element) => element == null);
  }

  // Method to return true if the list has no false and null values
  bool allTrue() {
    return every((element) => element == true);
  }
}
