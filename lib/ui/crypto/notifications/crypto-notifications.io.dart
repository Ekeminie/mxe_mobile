import 'package:flutter/material.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/textstyles.dart';
import 'package:mxe_mobile/ui/crypto/notifications/crypto-notifications.vm.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/empty-state.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';

class CryptoNotifications extends StatefulWidget {
  const CryptoNotifications({super.key});

  @override
  createState() => CryptoNotificationsState();
}

class CryptoNotificationsState extends State<CryptoNotifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: customAppBar("", bgColor: AppColors.bgColor),
      body: BaseView<CryptoNotificationsViewModel>(
        builder: (context, model, child) => Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              header("Notifications"),
              const EmptyState(),
              ...list
                  .map((e) => Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.title!,
                                  style: AppTextStyle.labelMdBold,
                                ),
                                8.sbH,
                                Text(
                                  e.sub!,
                                  style: AppTextStyle.labelSmRegular
                                      .copyWith(color: AppColors.grey),
                                )
                              ],
                            ),
                            Text(
                              e.date!,
                              style: AppTextStyle.labelXsRegular
                                  .copyWith(color: AppColors.moderateBlue),
                            )
                          ],
                        ),
                      ))
                  .toList()
            ],
          ),
        ),
      ),
    );
  }
}

class DummyCNotifications {
  final String? title;
  final String? sub;
  final String? date;
  DummyCNotifications({this.title, this.sub, this.date});
}

List<DummyCNotifications> list = [
  DummyCNotifications(
      title: "Withdrawal Completed",
      sub: "Withdrew BTC 0.00011 ",
      date: "09 Nov 23"),
  DummyCNotifications(
      title: "Asset Received",
      sub: "You recently received Ethereum ",
      date: "05 Nov 23"),
  DummyCNotifications(
      title: "Swap Completed",
      sub: "You  successfully swapped BTC for ETH",
      date: "01 Nov 23"),
  DummyCNotifications(
      title: "Withdrawal Completed",
      sub: "Withdrew BTC 0.00011 ",
      date: "09 Nov 23"),
];
