import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/textstyles.dart';
import 'package:mxe_mobile/ui/crypto/home/home.vm.dart';
import 'package:mxe_mobile/ui/crypto/home/wallet/widgets/delete-wallet-sheet.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';

class ManageCryptoWallet extends StatefulWidget {
  const ManageCryptoWallet({super.key});

  @override
  createState() => ManageCryptoWalletState();
}

class ManageCryptoWalletState extends State<ManageCryptoWallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: customAppBar("", bgColor: AppColors.bgColor),
      body: BaseView<CryptoHomeViewModel>(
        builder: (context, model, child) => Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              header("Manage Wallet", usePadding: false),
              16.sbH,
              ...['afdsasf', 'afasdfa']
                  .map((e) => GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => showDeleteCryptoWalletSheet(context),
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
                            children: [
                              SvgPicture.asset('red-check'.svg),
                              16.sbW,
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
    );
  }
}
