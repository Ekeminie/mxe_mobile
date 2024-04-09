import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/textstyles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/crypto/home/home.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';

class ViewCryptoWallet extends StatefulWidget {
  const ViewCryptoWallet({super.key});

  @override
  createState() => ViewCryptoWalletState();
}

class ViewCryptoWalletState extends State<ViewCryptoWallet> {
  ValueNotifier<String?> selected = ValueNotifier(null);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: customAppBar("", bgColor: AppColors.bgColor, actions: [
        actionWidget("Manage",
            () => Navigator.pushNamed(context, Routes.manageCryptoWallet),
            bgColor: AppColors.moderateBlue, textColor: AppColors.white)
      ]),
      body: BaseView<CryptoHomeViewModel>(
        builder: (context, model, child) => Container(
          padding: const EdgeInsets.all(16.0),
          child: ValueListenableBuilder(
            valueListenable: selected,
            builder: (context, wallet, _) => Column(
              children: [
                header("Total Assets", usePadding: false),
                header("\$0", usePadding: false),
                16.sbH,
                ...['afdsasf', 'afasdfa']
                    .map((e) => GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => selected.value = e,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 16),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.grey.withOpacity(0.3),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "Wallet A - ",
                                          style: AppTextStyle.headingHeading3,
                                        ),
                                        Text(
                                          "${e.toUpperCase()} *******",
                                          style: AppTextStyle.paragraphMd,
                                        ),
                                      ],
                                    ),
                                    const Text("\$0.00"),
                                  ],
                                ),
                                wallet == e
                                    ? SvgPicture.asset('radio-a'.svg)
                                    : SvgPicture.asset('radio'.svg)
                              ],
                            ),
                          ),
                        ))
                    .toList(),
                Spacer(),
                UiButton(
                  text: "Add Wallet",
                  color: AppColors.subtleAccent,
                  textColor: AppColors.moderateBlue,
                  onPressed: () {},
                ),
                40.sbH,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
