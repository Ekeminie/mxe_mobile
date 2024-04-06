import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/textstyles.dart';
import 'package:mxe_mobile/ui/crypto/intro/crypto-onboarding.vm.dart';
import 'package:mxe_mobile/ui/crypto/intro/widgets/already-have-wallet-bottomsheet.dart';
import 'package:mxe_mobile/ui/crypto/intro/widgets/create-wallet-sheet.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';

class CryptoOnboarding extends StatefulWidget {
  const CryptoOnboarding({super.key});

  @override
  createState() => CryptoOnboardingState();
}

class CryptoOnboardingState extends State<CryptoOnboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseView<CryptoOnboardingViewModel>(
        builder: (context, model, child) => SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SvgPicture.asset('crypto-intro'.svg),
                Text(
                  "Welcome to Web3",
                  style: AppTextStyle.bigBold
                      .copyWith(color: AppColors.bgContrast),
                ),
                8.sbH,
                UiButton(
                  text: "Create Wallet",
                  onPressed: () => createWalletBottomSheet(context),
                ),
                8.sbH,
                UiButton(
                  color: AppColors.white,
                  text: "I already have one",
                  textColor: AppColors.moderateBlue,
                  onPressed: () => haveWalletBottomSheet(context),
                ),
                Expanded(
                    child: SvgPicture.asset(
                  'crypto-animation'.svg,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
