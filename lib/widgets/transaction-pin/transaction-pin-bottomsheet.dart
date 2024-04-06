import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/constant/palette.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/styles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/transaction-pin/number-input.dart';
import 'package:mxe_mobile/widgets/transaction-pin/transfer-pin.vm.dart';
import 'package:pinput/pinput.dart';

class TransferPinBottomSheet extends StatefulWidget {
  final Function(String)? onCompleted;
  final ValueChanged<String>? onChanged;
  final Function? onDone;

  const TransferPinBottomSheet({
    Key? key,
    this.onChanged,
    this.onDone,
    this.onCompleted,
  }) : super(key: key);

  @override
  State<TransferPinBottomSheet> createState() => _TransferPinBottomSheetState();
}

class _TransferPinBottomSheetState extends State<TransferPinBottomSheet> {
  String? transactionPin;

  @override
  Widget build(BuildContext context) {
    return BaseView<TransferPinViewModel>(
        builder: (context, model, child) => Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    child: Container(
                      padding: EdgeInsets.only(
                          right: 20,
                          left: 20,
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      color: Colors.white,
                      // height: 500,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 20.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 40.h,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          Center(
                                              child: Text(
                                            "Enter Transaction Pin",
                                            style: TextStyle(
                                                color: textDark,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          Positioned(
                                              left: 0,
                                              top: 0,
                                              child: IconButton(
                                                  icon: Icon(Icons.cancel,
                                                      color: textDark),
                                                  onPressed: () =>
                                                      Navigator.pop(context)))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
                                                onTap: () =>
                                                    Navigator.pushNamed(
                                                        context,
                                                        Routes
                                                            .resetPinPageRoute),
                                                child: Center(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 16.h),
                                                    child: Text(
                                                      "Reset Pin ?",
                                                      style: GoogleFonts
                                                          .plusJakartaSans(
                                                              color: AppColors
                                                                  .moderateBlue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 16.sp),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    top: 12),
                                                padding:
                                                    const EdgeInsets.all(12),
                                                decoration: BoxDecoration(
                                                    color:
                                                        AppColors.errorCodeBG,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: Center(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () => model
                                                            .reverseError(),
                                                        child: const Icon(
                                                          Icons.close,
                                                          color: AppColors
                                                              .errorCode,
                                                          size: 16,
                                                        ),
                                                      ),
                                                      8.sbW,
                                                      Expanded(
                                                        child: Center(
                                                          child: Text(
                                                            model.errorMessage_ ??
                                                                "",
                                                            style: GoogleFonts
                                                                .plusJakartaSans(
                                                                    color: AppColors
                                                                        .errorCode,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        16.sp),
                                                            textAlign: TextAlign
                                                                .center,
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
                                      AndroidSmsAutofillMethod
                                          .smsUserConsentApi,
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
                              20.0.sbH,
                              NumberInput(
                                  onTap: (v) {
                                    transactionPin = v;
                                    widget.onChanged != null
                                        ? widget.onChanged!(v)
                                        : null;
                                  },
                                  onCompleted: (c) async =>
                                      widget.onCompleted != null
                                          ? {
                                              model.setPin(c),
                                              model.verifyPassword(f: () async {
                                                widget.onCompleted!(c);
                                                Navigator.pop(context);
                                                await Future.delayed(
                                                    const Duration(
                                                        milliseconds: 500));
                                                widget.onDone != null
                                                    ? widget.onDone!()
                                                    : null;
                                              })
                                            }
                                          : null),
                              15.0.sbH,
                              // SizedBox(
                              //   width: double.infinity,
                              //   child: UiButton(
                              //     onPressed: () async {
                              //       if (transactionPin?.length != 4) {
                              //         showCustomToast("Please enter a valid pin");
                              //       } else {
                              //         Navigator.pop(context);
                              //         await Future.delayed(
                              //             const Duration(milliseconds: 500));
                              //         widget.onDone != null ? widget.onDone!() : null;
                              //       }
                              //     },
                              //     text: "Done",
                              //     loadingState: model.viewState,
                              //   ),
                              // ),
                              // 20.0.sbH,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }
}

showTransferPinBottomSheet(
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
        return TransferPinBottomSheet(
          onCompleted: (v) => onCompleted != null ? onCompleted(v) : null,
          onChanged: (v) => onChanged != null ? onChanged(v) : null,
          onDone: () => onDone != null ? onDone() : null,
        );
      });
}
