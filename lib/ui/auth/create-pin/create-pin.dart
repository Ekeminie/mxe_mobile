import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/styles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/auth/create-pin/create-pin.vm.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';
import 'package:mxe_mobile/widgets/transaction-pin/number-input.dart';
import 'package:pinput/pinput.dart';

class CreateNewPinPage extends StatefulWidget {
  const CreateNewPinPage({Key? key}) : super(key: key);

  @override
  State<CreateNewPinPage> createState() => _CreateNewPinPageState();
}

class _CreateNewPinPageState extends State<CreateNewPinPage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<CreatePinViewModel>(
        builder: (context, model, child) => Scaffold(
            appBar: customAppBar(
              "",
            ),
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
                    const IHeader(
                      centerAlign: false,
                      title: "Create New Pin",
                      subTitle: "",
                    ),
                    36.sbH,
                    Center(
                      child: Pinput(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        errorText: model.errorMessage_,
                        forceErrorState: model.error,
                        errorBuilder: (b, v) {
                          return v != null
                              ? Container(
                                  margin: const EdgeInsets.only(top: 12),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      color: AppColors.errorCodeBG,
                                      borderRadius: BorderRadius.circular(12)),
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
                                              style:
                                                  GoogleFonts.plusJakartaSans(
                                                      color:
                                                          AppColors.errorCode,
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
                    model.error ? 0.sbH : 50.sbH,
                    UiButton(
                      text: "Next",
                      onPressed: model.hasPin
                          ? () => Navigator.pushNamed(
                              context, Routes.confirmPinRoute)
                          : null,
                    ),
                    NumberInput(
                      onTap: (v) => model.pinController.text = v,
                      usePinLength: true,
                      onCompleted: (v) {},
                      biometrics: false,
                    ),
                  ],
                ),
              ),
            )));
  }
}
