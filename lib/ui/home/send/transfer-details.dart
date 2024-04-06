import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/enum/fundtype-enum.dart';
import 'package:mxe_mobile/core/enum/status-enum.dart';
import 'package:mxe_mobile/core/model/withdrawal-beneficiary-response.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/home/send/select-bank-sheet.dart';
import 'package:mxe_mobile/ui/home/send/send.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/input.dart';
import 'package:mxe_mobile/widgets/transaction-pin/bills-pin.dart';

class TransferDetailsPage extends StatefulWidget {
  const TransferDetailsPage({Key? key}) : super(key: key);

  @override
  State<TransferDetailsPage> createState() => _TransferDetailsPageState();
}

class _TransferDetailsPageState extends State<TransferDetailsPage> {
  ValueNotifier<InsightsTimeLineEnum> timeline =
      ValueNotifier(InsightsTimeLineEnum.sevenDays);

  final tag = TextEditingController();

  final sortCode = TextEditingController();
  final swiftCode = TextEditingController();
  final receiverName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<SendFundsViewModel>(
      onModelReady: (m) => m.get1(),
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.bgColor,
        appBar: customAppBar("", bgColor: AppColors.bgColor, actions: [
          GestureDetector(
            onTap: () async {
              var result = await Navigator.pushNamed(
                  context, Routes.transferBeneficiariesPageRoute);
              if (result != null) {
                model.setBeneficiary(result as WithdrawalBeneficiary);
              }
            },
            child: Container(
              height: 20,
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                  color: AppColors.subtleAccent,
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: Text(
                  "Beneficiaries",
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.boldSemantic),
                ),
              ),
            ),
          )
        ]),
        body: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: AutoSizeText(
                    "Recipient Details",
                    style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 24.sp,
                        color: AppColors.bgContrast),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    32.sbH,
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                AutoSizeText(
                                  "You're about to send",
                                  style: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: AppColors.textLight),
                                ),
                                8.sbH,
                                AutoSizeText(
                                  "${getCurrencySign(model.currency.value.code!.toLowerCase())} ${formatPrice(model.numAmount.toString()).substring(1)}",
                                  style: GoogleFonts.plusJakartaSans(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24,
                                  ),
                                ),
                                16.sbH,
                                ValueListenableBuilder(
                                  valueListenable: model.selectedBank,
                                  builder: (context, bank, _) =>
                                      GestureDetector(
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
                                          borderRadius:
                                              BorderRadius.circular(12)),
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
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
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
                                ValueListenableBuilder(
                                    valueListenable: model.localBeneficiaryName,
                                    builder: (context, name, _) => Visibility(
                                        visible: name.isNotNullNorEmpty,
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(name ?? "")))),
                                12.sbH,
                                ValueListenableBuilder(
                                  valueListenable: model.saveBeneficiary_,
                                  builder: (context, save, _) => Column(
                                    children: [
                                      if (save) 16.sbH,
                                      if (save)
                                        Input(
                                          controller:
                                              model.beneficiaryNameController,
                                          autofocus: false,
                                          hintText: "Beneficiary Name",
                                          readOnly: false,
                                          onChanged: (v) =>
                                              model.setBeneficiaryName(v),
                                        ),
                                      if (save) 16.sbH,
                                      Row(
                                        children: [
                                          Checkbox(
                                            value: save,
                                            onChanged: (b) =>
                                                model.setSaveBeneficiary(b!),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            checkColor: AppColors.white,
                                            activeColor: AppColors.moderateBlue,
                                          ),
                                          const Text("Save Beneficiary"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    24.sbH,
                    UiButton(
                      text: "Fund Now",
                      onPressed: model.hasTransferDetails
                          ? () => showNewTransferPinBottomSheet(context,
                              onCompleted: (c) =>
                                  model.userService.transactionPin = c,
                              onDone: () => model.transferToBank())
                          : null,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
