import 'package:flutter/material.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/ui/crypto/intro/crypto-onboarding.vm.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';

class SelectCryptoWalletPage extends StatelessWidget {
  const SelectCryptoWalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseView<CryptoOnboardingViewModel>(
        builder: (context, model, child) => Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const BackButton(),
              16.0.sbH,
              header("Wallet A", usePadding: false),
            ],
          ),
        ),
      ),
    );
  }
}
