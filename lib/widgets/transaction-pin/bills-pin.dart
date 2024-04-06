import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/constant/palette.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/styles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/transaction-pin/number-input.dart';
import 'package:mxe_mobile/widgets/transaction-pin/transfer-pin.vm.dart';
import 'package:pinput/pinput.dart';

class NewTransferPinBottomSheet extends StatefulWidget {
  final Function(String)? onCompleted;
  final ValueChanged<String>? onChanged;
  final Function? onDone;

  const NewTransferPinBottomSheet({
    Key? key,
    this.onChanged,
    this.onDone,
    this.onCompleted,
  }) : super(key: key);

  @override
  State<NewTransferPinBottomSheet> createState() =>
      _NewTransferPinBottomSheetState();
}

class _NewTransferPinBottomSheetState extends State<NewTransferPinBottomSheet> {
  ValueNotifier<String?> transactionPin = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return BaseView<TransferPinViewModel>(
        builder: (context, model, child) => Stack(
              children: [
                SvgPicture.asset(
                  'transaction-pin-bg'.svg,
                  width: width(context),
                  height: height(context),
                  fit: BoxFit.fill,
                  color: Colors.red,
                ),
                Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(image: AssetImage('lines'.png))),
                  padding: EdgeInsets.only(
                      right: 20,
                      left: 20,
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0.0, vertical: 20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        30.sbH,
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                              icon: Icon(Icons.arrow_back_ios, color: textDark),
                              onPressed: () => Navigator.pop(context)),
                        ),
                        50.sbH,
                        Expanded(child: Container()),
                        const Text("Enter PIN to authorise transaction"),
                        20.0.sbH,
                        Center(
                          child: Pinput(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            errorText: model.errorMessage_,
                            forceErrorState: model.error,
                            errorBuilder: (b, v) {
                              return v != null
                                  ? Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () => Navigator.pushNamed(
                                              context,
                                              Routes.resetPinPageRoute),
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(top: 16.h),
                                              child: Text(
                                                "Reset Pin ?",
                                                style:
                                                    GoogleFonts.plusJakartaSans(
                                                        color: AppColors
                                                            .moderateBlue,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 16.sp),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 12),
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                              color: AppColors.errorCodeBG,
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Center(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () =>
                                                      model.reverseError(),
                                                  child: const Icon(
                                                    Icons.close,
                                                    color: AppColors.errorCode,
                                                    size: 16,
                                                  ),
                                                ),
                                                8.sbW,
                                                Expanded(
                                                  child: Center(
                                                    child: Text(
                                                      model.errorMessage_ ?? "",
                                                      style: GoogleFonts
                                                          .plusJakartaSans(
                                                              color: AppColors
                                                                  .errorCode,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 16.sp),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : const SizedBox.shrink();
                            },
                            controller: model.pinController,
                            key: const Key("otp-field"),
                            androidSmsAutofillMethod:
                                AndroidSmsAutofillMethod.smsUserConsentApi,
                            listenForMultipleSmsOnAndroid: true,
                            defaultPinTheme: defaultPinTheme,
                            focusedPinTheme: focusedPinTheme,
                            submittedPinTheme: submittedPinTheme,
                            errorPinTheme: errorPinTheme,
                            pinputAutovalidateMode:
                                PinputAutovalidateMode.onSubmit,
                            keyboardType: TextInputType.number,
                            obscuringCharacter: "•",
                            obscureText: true,
                            showCursor: true,
                            length: 4,
                            onChanged: (value) {
                              // model.otp = value;
                              // if (model.otp!.length == 4) {
                              //   model.verifyOtp();
                              // }
                              transactionPin.value = value;
                            },
                            onSubmitted: (value) {
                              // model.otp = value;
                              // if (model.otp!.length == 4) {
                              //   model.verifyOtp();
                              // }
                            },
                          ),
                        ),
                        model.error ? 0.sbH : 40.sbH,
                        10.sbH,
                        NumberInput(onTap: (v) {
                          model.pinController.text = v;
                          transactionPin.value = v;
                          model.setPin(v);
                          widget.onChanged != null
                              ? widget.onChanged!(v)
                              : null;
                        }, onCompleted: (c) async {
                          widget.onCompleted != null
                              ? widget.onCompleted!(c)
                              : null;
                        }),
                        15.0.sbH,
                        ValueListenableBuilder(
                            valueListenable: transactionPin,
                            builder: (context, pin, _) => UiButton(
                                  text: "Authorise",
                                  onPressed: pin?.length == 4
                                      ? () async {
                                          Navigator.pop(context);
                                          await Future.delayed(const Duration(
                                              milliseconds: 500));
                                          (widget.onDone != null)
                                              ? widget.onDone!()
                                              : null;
                                        }
                                      : null,
                                )),
                        Expanded(child: Container()),
                        20.0.sbH,
                      ],
                    ),
                  ),
                )
              ],
            ));
  }
}

showNewTransferPinBottomSheet(
  BuildContext context, {
  Function(String)? onCompleted,
  ValueChanged<String>? onChanged,
  Function? onDone,
}) {
  showModalBottomSheet(
      enableDrag: true,
      isDismissible: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return NewTransferPinBottomSheet(
          onCompleted: (v) => onCompleted != null ? onCompleted(v) : null,
          onChanged: (v) => onChanged != null ? onChanged(v) : null,
          onDone: () => onDone != null ? onDone() : null,
        );
      });
}
