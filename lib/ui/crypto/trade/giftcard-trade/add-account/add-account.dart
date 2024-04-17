import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/enum/fundtype-enum.dart';
import 'package:mxe_mobile/core/enum/status-enum.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/textstyles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/crypto/trade/giftcard-trade/giftcard.vm.dart';
import 'package:mxe_mobile/ui/home/send/select-bank-sheet.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';
import 'package:mxe_mobile/widgets/input.dart';
import 'package:mxe_mobile/widgets/transaction-pin/bills-pin.dart';

class AddAccountPage extends StatefulWidget {
  const AddAccountPage({Key? key}) : super(key: key);

  @override
  State<AddAccountPage> createState() => _AddAccountPageState();
}

class _AddAccountPageState extends State<AddAccountPage> {
  ValueNotifier<InsightsTimeLineEnum> timeline =
      ValueNotifier(InsightsTimeLineEnum.sevenDays);

  final tag = TextEditingController();

  final sortCode = TextEditingController();
  final swiftCode = TextEditingController();
  final receiverName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<GiftCardViewModel>(
      onModelReady: (m) => m.get1(),
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.bgColor,
        appBar: customAppBar(
          "",
          bgColor: AppColors.bgColor,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header("Add Account", usePadding: false),
                32.sbH,
                const Text(
                  "Add a bank account you want to use to receive payment. ",
                  style: AppTextStyle.paragraphMd,
                ),
                32.sbH,
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            16.sbH,
                            ValueListenableBuilder(
                              valueListenable: model.selectedBank,
                              builder: (context, bank, _) => GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () => selectBankBottomSheet(context,
                                    old: model.selectedBank.value,
                                    onTap: (v) => model.setBank(v),
                                    list: model.banksList.value ?? []),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 16.h, horizontal: 16.w),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: bank != null
                                              ? AppColors.moderateBlue
                                              : AppColors.border,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      bank != null
                                          ? Text(bank.bankName
                                                  ?.capitalizeWords() ??
                                              "")
                                          : Text(
                                              "Select Bank",
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                color: AppColors.textLight,
                                              ),
                                            ),
                                      Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: bank != null
                                            ? null
                                            : AppColors.border,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            16.sbH,
                            Input(
                              controller: model.accountNo,
                              autofocus: false,
                              hintText: "Account number/IBAN",
                              // labelText: "@   Mxe Tag",
                              readOnly: false,
                              onChanged: (v) =>
                                  {model.setAccNo(v), model.getAccNo(v)},
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                            // 8.sbH,
                            // const Align(
                            //     alignment: Alignment.centerLeft,
                            //     child: Text(
                            //       "Micheal Elvis",
                            //       style: AppTextStyle.labelXsRegular,
                            //     )),
                            if (model.transferRepo.sendCurrency !=
                                TransferCurrency.ngn)
                              16.sbH,
                            if (model.transferRepo.sendCurrency !=
                                TransferCurrency.ngn)
                              Input(
                                controller: sortCode,
                                autofocus: false,
                                hintText: "Routing number/Sort Code",
                                // labelText: "@   Mxe Tag",
                                readOnly: false,
                                onChanged: (v) => model.setSortCode(v),
                              ),
                            if (model.transferRepo.sendCurrency !=
                                TransferCurrency.ngn)
                              16.sbH,
                            if (model.transferRepo.sendCurrency !=
                                TransferCurrency.ngn)
                              Input(
                                controller: swiftCode,
                                autofocus: false,
                                hintText: "Swift Code",
                                readOnly: false,
                                onChanged: (v) => model.setSwiftCode(v),
                              ),
                            12.sbH,
                            if (model.transferRepo.sendCurrency !=
                                TransferCurrency.ngn)
                              Input(
                                controller: receiverName,
                                autofocus: false,
                                hintText: "Receiver name",
                                readOnly: false,
                                onChanged: (v) => model.setReceiverName(v),
                              ),
                            16.sbH,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                24.sbH,
                UiButton(
                  text: "Continue",
                  onPressed: model.hasTransferDetails
                      ? () => showNewTransferPinBottomSheet(context,
                          onCompleted: (c) =>
                              model.userService.transactionPin = c,
                          onDone: () => {
                                Navigator.pushReplacementNamed(
                                    context, Routes.giftCardSuccessPage)
                              })
                      : null,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
