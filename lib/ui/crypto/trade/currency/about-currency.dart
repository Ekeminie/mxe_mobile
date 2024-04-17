import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/textstyles.dart';
import 'package:mxe_mobile/ui/crypto/trade/crypto-trade/crypto-trade.ui.dart';
import 'package:mxe_mobile/ui/home/finance/finance.vm.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';

class AboutCurrencyPage extends StatefulWidget {
  final TAsset asset;
  const AboutCurrencyPage({super.key, required this.asset});

  @override
  State<AboutCurrencyPage> createState() => _AboutCurrencyPageState();
}

class _AboutCurrencyPageState extends State<AboutCurrencyPage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<FinanceViewModel>(
      builder: (context, model, child) => Scaffold(
        appBar: customAppBar(
          "",
        ),
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header("About ${widget.asset.title}", usePadding: false),
                Text('''
Bitcoin, created in 2009 by an unknown person or group using the pseudonym Satoshi Nakamoto, revolutionized the financial landscape as the first decentralized digital currency. Satoshi Nakamoto introduces the need for a system that allows online payments to be sent directly from one party to another without the involvement of a financial institution.
            They highlighted the limitations and issues with traditional payment systems, such as reliance on trust, fees, and delays.
            
            Bitcoin operates on a peer-to-peer network without the need for a central authority or intermediary.
            '''),
                Text(
                  '''Key Characteristics:\n\n''',
                  style: AppTextStyle.labelLgBold,
                ),
                Text(
                  "1. Decentralization: ",
                  style: AppTextStyle.labelMdBold,
                ),
                Text('''
            Bitcoin operates on a decentralized network called the blockchain, where transactions are verified and recorded by a network of computers (nodes) without the need for a central governing authority like a bank.
            Limited Supply: Unlike traditional currencies, Bitcoin has a fixed supply cap of 21 million coins. This scarcity is built into its protocol, making it deflationary in nature.
            Security and Transparency: The blockchain, a public ledger, records all Bitcoin transactions. Each transaction is cryptographically secured, transparent, and immutable, making it resistant to fraud or alteration.
            Anonymity and Pseudonymity: While transactions are transparent, users' identities remain pseudonymous. Wallet addresses, not personal information, are used for transactions, offering a degree of privacy.
            
            How Bitcoin Works:
            
            Mining: Bitcoin transactions are verified and added to the blockchain through a process called mining. Miners use powerful computers to solve complex mathematical puzzles, securing the network and earning newly minted bitcoins as rewards.
            Transactions: Users can send and receive bitcoins using digital wallets. Transactions involve cryptographic signatures and are broadcast to the network, where miners confirm their validity.
            
            Bitcoin's creation marked the beginning of a new era in finance, introducing a decentralized and innovative approach to digital currency. Its impact continues to evolve, shaping the landscape of both finance and technology.
            
            Find more;
            Bitcoin Website
            Bitcoin Whitepaper
            
                  '''),
                50.sbH,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
