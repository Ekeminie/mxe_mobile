import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/styles/styles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/auth/reset-pin/reset-pin.vm.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';
import 'package:pinput/pinput.dart';

class ResetPinOtp extends StatefulWidget {
  const ResetPinOtp({Key? key}) : super(key: key);

  @override
  State<ResetPinOtp> createState() => _ResetPinOtpState();
}

class _ResetPinOtpState extends State<ResetPinOtp> {
  @override
  Widget build(BuildContext context) {
    return BaseView<ResetPinViewModel>(
        builder: (context, model, child) => Scaffold(
            appBar: customAppBar(
              "",
            ),
            resizeToAvoidBottomInset: true,
            extendBody: true,
            // backgroundColor: Colors.black26,
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  12.sbH,
                  const IHeader(
                    centerAlign: false,
                    title: "Reset Pin",
                    subTitle:
                        "To be sure it’s you trying to change PIN, kindly enter the 4-digit code sent to +234812****00",
                  ),
                  36.sbH,
                  Center(
                    child: Pinput(
                      key: const Key("otp-field"),
                      androidSmsAutofillMethod:
                          AndroidSmsAutofillMethod.smsUserConsentApi,
                      listenForMultipleSmsOnAndroid: true,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: focusedPinTheme,
                      submittedPinTheme: submittedPinTheme,
                      errorPinTheme: errorPinTheme,
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      keyboardType: TextInputType.number,
                      // obscuringCharacter: "•",
                      // obscureText: true,
                      showCursor: true,
                      length: 4,
                      onChanged: (value) {
                        model.setOtp(value);
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
                        ? () => model.navigationService
                            .navigateTo(Routes.createPinRoute)
                        : null,
                  ),
                ],
              ),
            )));
  }
}
