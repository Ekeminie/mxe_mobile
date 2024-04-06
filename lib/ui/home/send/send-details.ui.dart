import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/enum/fundtype-enum.dart';
import 'package:mxe_mobile/core/enum/status-enum.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/ui/home/send/send.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/input.dart';
import 'package:mxe_mobile/widgets/transaction-pin/bills-pin.dart';

class SendFundsDetailsPage extends StatefulWidget {
  const SendFundsDetailsPage({Key? key}) : super(key: key);

  @override
  State<SendFundsDetailsPage> createState() => _SendFundsDetailsPageState();
}

class _SendFundsDetailsPageState extends State<SendFundsDetailsPage> {
  ValueNotifier<InsightsTimeLineEnum> timeline =
      ValueNotifier(InsightsTimeLineEnum.sevenDays);

  ValueNotifier<SendFundType> fundType = ValueNotifier(SendFundType.mxeTag);

  final ref = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BaseView<SendFundsViewModel>(
      onModelReady: (m) => m.get1(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: customAppBar("", bgColor: AppColors.bgColor, actions: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
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
        body: Column(
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
                                "NGN ${formatPrice(model.numAmount.toString()).substring(1)}",
                                style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                ),
                              ),
                              16.sbH,
                              Input(
                                controller: model.tagController,
                                autofocus: false,
                                prefixText: "@",
                                hintText: "   Mxe Tag",
                                // labelText: "@   Mxe Tag",
                                readOnly: false,
                                onChanged: (v) => model.search(v),
                              ),
                              16.sbH,
                              if (model.isLoading)
                                const LinearProgressIndicator(
                                  color: AppColors.primaryColor,
                                ),
                              if (model.hasTag)
                                Visibility(
                                    visible: model.hasTag,
                                    child: ValueListenableBuilder(
                                      valueListenable: model.queryResult,
                                      builder: (context, list, _) => Column(
                                        children: list
                                            .map((e) => GestureDetector(
                                                  onTap: () => model.setTag(e),
                                                  child: Row(
                                                    children: [
                                                      Image.asset(
                                                          'small-avatar'.png),
                                                      8.sbW,
                                                      Text(
                                                        "$e",
                                                        style: GoogleFonts
                                                            .plusJakartaSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize:
                                                                    16.sp),
                                                      )
                                                    ],
                                                  ),
                                                ))
                                            .toList(),
                                      ),
                                    )),
                              if (model.hasTag) 12.sbH,
                              16.sbH,
                              Input(
                                controller: ref,
                                autofocus: false,
                                hintText: "Payment Reference",
                                // labelText: "Payment Reference",
                                readOnly: false,
                                maxLines: 5,
                                onChanged: (v) => model.setRef(v),
                              ),
                              16.sbH,
                              ValueListenableBuilder(
                                valueListenable: model.saveBeneficiary_,
                                builder: (context, save, _) => Column(
                                  children: [
                                    if (save)
                                      Input(
                                        autofocus: false,
                                        hintText: "Beneficiary Name",
                                        labelText: "Beneficiary Name",
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
                                              model.saveBeneficiary_.value = b!,
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
                  36.sbH,
                  UiButton(
                    text: "Fund Now",
                    onPressed: model.hasValue
                        ? () => showNewTransferPinBottomSheet(context,
                            onCompleted: (c) =>
                                model.userService.transactionPin = c,
                            onDone: () => model.transferToMXeUser())
                        : null,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
