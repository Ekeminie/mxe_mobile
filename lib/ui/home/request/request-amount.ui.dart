import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/constant/constants.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/ui/home/request/request.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';
import 'package:mxe_mobile/widgets/initials-widget.dart';
import 'package:mxe_mobile/widgets/input.dart';
import 'package:mxe_mobile/widgets/transaction-pin/bills-pin.dart';
import 'package:mxe_mobile/widgets/transaction-pin/number-input.dart';

class RequestDetailsPage extends StatefulWidget {
  const RequestDetailsPage({Key? key}) : super(key: key);

  @override
  State<RequestDetailsPage> createState() => _RequestDetailsPageState();
}

class _RequestDetailsPageState extends State<RequestDetailsPage> {
  final controller = TextEditingController();
  String? text;
  @override
  Widget build(BuildContext context) {
    return BaseView<RequestViewModel>(
      onModelReady: (m) => m.get1(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: customAppBar("", bgColor: AppColors.bgColor),
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header("Request From ${model.selectedBeneficiaryUserName}"),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  16.sbH,
                  UserNameWidget(
                    textColor: AppColors.moderateBlue,
                    userFullName:
                        model.selectedBeneficiaryUserName!.substring(1),
                    radius: 22,
                  ),
                  10.sbH,
                  AutoSizeText(
                    "Enter request amount",
                    style: GoogleFonts.plusJakartaSans(
                        color: AppColors.bgContrast,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp),
                  ),
                  8.sbH,
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AutoSizeText(
                        "$nairaSign   ",
                        style: GoogleFonts.plusJakartaSans(
                            color: AppColors.bgContrast,
                            fontWeight: FontWeight.w700,
                            fontSize: 18.sp),
                      ),
                      IntrinsicWidth(
                        child: TextField(
                          style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w700, fontSize: 32),
                          controller: controller,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            border: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                          onChanged: (v) => controller.text =
                              formatPrice(v).replaceAll(".00", "").substring(1),
                        ),
                      ),
                    ],
                  ),
                  NumberInput(
                    onTap: (v) => {
                      model.setAmount(v),
                      controller.text = formatPrice(model.numAmount.toString())
                          .replaceAll(".00", "")
                          .substring(1)
                    },
                    usePinLength: false,
                    onCompleted: (v) {
                      if (v != "1111") {}
                    },
                  ),
                  Input(
                    autofocus: false,
                    prefixText: "",
                    hintText: "Note (Optional)",
                    onChanged: (v) => model.setNarration(v),
                  ),
                  16.sbH,
                  UiButton(
                    text: "Request",
                    onPressed: model.hasAmount
                        ? () => showNewTransferPinBottomSheet(context,
                            onCompleted: (c) =>
                                model.userService.transactionPin = c,
                            onDone: () => model.requestFunds())
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
