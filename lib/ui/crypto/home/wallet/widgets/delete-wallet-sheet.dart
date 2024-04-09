import 'package:flutter/material.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/textstyles.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/bottomsheet-widgets.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';

class DeleteCryptoWalletBottomSheet extends StatelessWidget {
  DeleteCryptoWalletBottomSheet({Key? key}) : super(key: key);

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
              const Text(
                "Delete this Wallet?",
                style: AppTextStyle.headingHeading2,
              ),
              16.sbH,
              Text(
                  "After deletion, you can restore this wallet by importing its seed phrase. Make sure it's backed-up before deletion, or you'll permanently lose access to this wallet.",
                  style: AppTextStyle.labelSmRegular
                      .copyWith(color: AppColors.textLight)),
              42.sbH,
              UiButton(
                text: "Delete Wallet",
                color: AppColors.errorCode,
                textColor: AppColors.white,
                onPressed: () {},
              ),
              32.sbH,
            ],
          ),
        ),
      ),
    );
  }
}

showDeleteCryptoWalletSheet(BuildContext context) {
  showModalBottomSheet(
      enableDrag: true,
      isDismissible: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DeleteCryptoWalletBottomSheet();
      });
}
