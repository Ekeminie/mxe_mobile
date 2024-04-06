import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/styles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/auth/login/login.vm.dart';
import 'package:mxe_mobile/utils/string%20utils.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/transaction-pin/number-input.dart';
import 'package:pinput/pinput.dart';

class WelcomeBackPage extends StatefulWidget {
  const WelcomeBackPage({Key? key}) : super(key: key);

  @override
  State<WelcomeBackPage> createState() => _WelcomeBackPageState();
}

class _WelcomeBackPageState extends State<WelcomeBackPage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
        onModelReady: (m) => m.init(),
        builder: (context, model, child) => Scaffold(
            appBar: customAppBar("", actions: [
              GestureDetector(
                onTap: () => model.logout(),
                child: Container(
                  height: 100,
                  margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                      color: AppColors.subtleAccent,
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: ValueListenableBuilder(
                      valueListenable: model.userService.userCredentials,
                      builder: (context, user, _) => Text(
                        "Not ${user.firstName?.capitalize()}?",
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.boldSemantic),
                      ),
                    ),
                  ),
                ),
              )
            ]),
            resizeToAvoidBottomInset: true,
            extendBody: true,
            // backgroundColor: Colors.black26,
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    12.sbH,
                    34.sbH,
                    Center(child: Image.asset('avatar'.png)),
                    10.sbH,
                    Center(
                      child: ValueListenableBuilder(
                        valueListenable: model.userService.userCredentials,
                        builder: (context, user, _) => Text(
                          "Hello ${user.firstName?.capitalize()}",
                          style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    10.sbH,
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "Please confirm your PIN to access your account",
                          style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: AppColors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    16.sbH,
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
                                          context, Routes.resetPinPageRoute),
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 16.h),
                                          child: Text(
                                            "Reset Pin ?",
                                            style: GoogleFonts.plusJakartaSans(
                                                color: AppColors.moderateBlue,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 16.sp),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 12),
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
                                              onTap: () => model.reverseError(),
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
                                                              FontWeight.w700,
                                                          fontSize: 16.sp),
                                                  textAlign: TextAlign.center,
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
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        keyboardType: TextInputType.number,
                        obscuringCharacter: "•",
                        obscureText: true,
                        showCursor: true,
                        length: 4,
                        onChanged: (value) {
                          model.password = value;
                          // model.otp = value;
                          if (model.password!.length == 4) {
                            model.emailAndPasswordLogin();
                          }
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
                    NumberInput(
                      onTap: (v) => model.pinController.text = v,
                      usePinLength: true,
                      onCompleted: (v) {
                        // model.emailAndPasswordLogin();
                      },
                    ),
                  ],
                ),
              ),
            )));
  }
}
