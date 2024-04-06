import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/styles.dart';
import 'package:mxe_mobile/core/styles/textstyles.dart';
import 'package:mxe_mobile/ui/auth/verify-otp/verify-otp.vm.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';
import 'package:mxe_mobile/widgets/square-btn.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:pinput/pinput.dart';

class VerifyOtp extends StatefulWidget {
  final String? route;
  const VerifyOtp({Key? key, this.route}) : super(key: key);

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  OtpTimerButtonController controller = OtpTimerButtonController();

  @override
  Widget build(BuildContext context) {
    return BaseView<OtpVerificationViewModel>(
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
                  Center(
                    child: IHeader(
                      centerAlign: true,
                      title: "Enter the Code",
                      subTitle:
                          "We have sent a code to ${model.authRepo.phone ?? ""} to approve this device",
                    ),
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
                  50.sbH,
                  Center(
                    child: OtpTimer(
                        duration: 60, onPressed: () => model.resendOtp()),
                    // OtpTimerButton(
                    //   backgroundColor: Colors.transparent,
                    //   buttonType: ButtonType.text_button,
                    //   textColor: AppColors.moderateBlue,
                    //   controller: controller,
                    //   onPressed: () => model.resendOtp(),
                    //   text: const Text('Resend OTP in '),
                    //   duration: 60,
                    // ),
                  ),
                  100.sbH,
                  Align(
                      alignment: Alignment.centerRight,
                      child: SquareButton(
                        isActive: model.hasOTP,
                        onClick: () => model.verifyOtp(widget.route),
                      )),
                ],
              ),
            )));
  }
}

class OtpTimer extends StatelessWidget {
  final num duration;
  final Function() onPressed;

  const OtpTimer({super.key, required this.duration, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: AppColors.textLight,
            ),
            children: [
              const TextSpan(
                text: "Resend in ",
                style: AppTextStyle.labelSmRegular,
              ),
              TextSpan(
                text: "0.20",
                style: AppTextStyle.paragraphMd
                    .copyWith(color: AppColors.moderateBlue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimerService {
  late int _initialSeconds;
  late int _remainingSeconds;
  late bool _isTimerActive;
  late bool _isTimerComplete;

  late ValueNotifier<int> _timerValueNotifier;
  late Timer _timer;

  TimerService(int seconds) {
    _initialSeconds = seconds;
    _remainingSeconds = seconds;
    _isTimerActive = false;
    _isTimerComplete = false;

    _timerValueNotifier = ValueNotifier<int>(_remainingSeconds);

    _timer = Timer.periodic(Duration(seconds: 1), _updateTimer);
  }

  ValueNotifier<int> get timerValueNotifier => _timerValueNotifier;

  bool get isTimerComplete => _isTimerComplete;

  void startTimer() {
    _isTimerActive = true;
  }

  void stopTimer() {
    _isTimerActive = false;
  }

  void resetTimer() {
    _remainingSeconds = _initialSeconds;
    _isTimerActive = false;
    _isTimerComplete = false;
    _timerValueNotifier.value = _remainingSeconds;
  }

  void _updateTimer(Timer timer) {
    if (_isTimerActive) {
      _remainingSeconds--;
      _timerValueNotifier.value = _remainingSeconds;

      if (_remainingSeconds <= 0) {
        _isTimerActive = false;
        _isTimerComplete = true;
      }
    }
  }

  void dispose() {
    _timer.cancel();
    _timerValueNotifier.dispose();
  }
}
