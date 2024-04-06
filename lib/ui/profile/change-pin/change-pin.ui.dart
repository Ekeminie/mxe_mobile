import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/styles/styles.dart';
import 'package:mxe_mobile/ui/profile/change-pin/change-pin.vm.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';
import 'package:pinput/pinput.dart';

class ChangePinPage extends StatefulWidget {
  final String? route;
  const ChangePinPage({Key? key, this.route}) : super(key: key);

  @override
  State<ChangePinPage> createState() => _ChangePinPageState();
}

class _ChangePinPageState extends State<ChangePinPage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<ChangePinViewModel>(
        onModelReady: (m) => m.sendOTP(),
        builder: (context, model, child) => Scaffold(
            appBar: customAppBar(
              "",
            ),
            resizeToAvoidBottomInset: true,
            extendBody: true,
            // backgroundColor: Colors.black26,
            body: Builder(builder: (context) {
              switch (model.pageIndex) {
                case 0:
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        12.sbH,
                        const IHeader(
                          title: "Change Pin",
                          subTitle:
                              "To be sure it’s you trying to change PIN, kindly enter the 4-digit code sent to +234812****00",
                        ),
                        36.sbH,
                        Center(
                          child: Pinput(
                            key: const Key("otp-first"),
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
                              model.setOtp(value);

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
                        100.sbH,
                        UiButton(
                          text: "Verify",
                          onPressed: model.hasOTP
                              ? () => model.changePageIndex(1)
                              : null,
                        )
                      ],
                    ),
                  );
                case 1:
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        12.sbH,
                        const IHeader(title: "Create New PIN", subTitle: ""),
                        36.sbH,
                        Center(
                          child: Pinput(
                            key: const Key("pin"),
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
                              model.setPin(value);

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
                        100.sbH,
                        UiButton(
                          text: "Verify",
                          onPressed: model.hasPin
                              ? () => model.changePageIndex(1)
                              : null,
                        )
                      ],
                    ),
                  );
                case 2:
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        12.sbH,
                        const IHeader(
                          title: "Confirm Your New PIN",
                          subTitle: "Re-enter your secure 4-digit PIN",
                        ),
                        36.sbH,
                        Center(
                          child: Pinput(
                            key: const Key("new-pin"),
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
                              model.setConfirmPin(value);

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
                        100.sbH,
                        UiButton(
                          text: "Change",
                          onPressed: model.isValidPins
                              ? () => model.changePin()
                              : null,
                        )
                      ],
                    ),
                  );

                default:
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        12.sbH,
                        const IHeader(
                          title: "Change Pin",
                          subTitle:
                              "To be sure it’s you trying to change PIN, kindly enter the 4-digit code sent to +234812****00",
                        ),
                        36.sbH,
                        Center(
                          child: Pinput(
                            key: const Key("otp first"),
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
                              model.setOtp(value);

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
                        100.sbH,
                        UiButton(
                          text: "Verify",
                          onPressed: model.hasOTP
                              ? () => model.changePageIndex(1)
                              : null,
                        )
                      ],
                    ),
                  );
              }
            })));
  }
}
