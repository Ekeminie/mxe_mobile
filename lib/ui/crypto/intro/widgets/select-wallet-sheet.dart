import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mxe_mobile/core/services/user.service.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/textstyles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';
import 'package:mxe_mobile/widgets/transaction-pin/bills-pin.dart';

class SelectCryptoWalletSheet extends StatelessWidget {
  final Function() onSubmit;
  SelectCryptoWalletSheet({super.key, required this.onSubmit});

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
                    header("Wallet A", usePadding: false),
                    24.0.sbH,
                    32.sbH,
                    ...CryptoEnum.values
                        .map((e) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      e.icon!.svg,
                                      height: 24,
                                      width: 24,
                                      fit: BoxFit.contain,
                                    ),
                                    12.sbW,
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            e.title!,
                                            style: AppTextStyle.labelMdRegular,
                                          ),
                                          10.sbH,
                                          Text(
                                            e.address!,
                                            style: AppTextStyle.labelXsRegular
                                                .copyWith(
                                                    color: AppColors.textLight),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const Divider(),
                                12.sbH
                              ],
                            ))
                        .toList(),
                    const Spacer(
                      flex: 3,
                    ),
                    UiButton(
                      text: "Restore",
                      onPressed: () {
                        showNewTransferPinBottomSheet(
                          context,
                          onDone: () {
                            Navigator.pushReplacementNamed(
                                context, Routes.cryptoHome);
                          },
                          onCompleted: (c) => uService.transactionPin = c,
                        );
                      },
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

selectCryptoWalletSheet(BuildContext context, {required Function() onSubmit}) {
  showModalBottomSheet(
      enableDrag: true,
      isDismissible: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return SelectCryptoWalletSheet(
          onSubmit: onSubmit,
        );
      });
}

enum CryptoEnum {
  bitcoin(
      title: "Bitcoin",
      icon: "btc",
      address: "cgascjundtyfzxclkidhcayvkcn6r3tmxv789msfnewfgh"),
  ethereum(
      title: "Bitcoin", icon: "eth", address: "Pjsg8ahn8lagsyqpnxgastchggsvd"),
  ripple(
      title: "Ripple",
      icon: "ripple",
      address: "PjsgASgjscvo927w0vhs58ahn8lagsyqpnxgastchggsvd");

  final String? title;
  final String? icon;
  final String? address;
  const CryptoEnum({this.title, this.icon, this.address});
}
