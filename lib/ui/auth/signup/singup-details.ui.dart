import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/styles.dart';
import 'package:mxe_mobile/core/styles/textstyles.dart';
import 'package:mxe_mobile/ui/auth/signup/signup.vm.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';
import 'package:mxe_mobile/widgets/input.dart';
import 'package:mxe_mobile/widgets/transaction-pin/number-input.dart';
import 'package:pinput/pinput.dart';

class SignUpDetailsPage extends StatefulWidget {
  const SignUpDetailsPage({Key? key}) : super(key: key);

  @override
  State<SignUpDetailsPage> createState() => _SignUpDetailsPageState();
}

class _SignUpDetailsPageState extends State<SignUpDetailsPage> {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BaseView<SignupViewModel>(
        builder: (context, model, child) => Scaffold(
            appBar: customAppBar("", overrideBackButtonAction: true,
                backFunction: () {
              if (model.pageIndex != 0) {
                model.goBack();
              } else {
                Navigator.pop(context);
              }
            }),
            resizeToAvoidBottomInset: true,
            extendBody: true,
            // backgroundColor: Colors.black26,
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Builder(builder: (context) {
                switch (model.pageIndex) {
                  case 0:
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomColoredContainer(
                              number: (model.pageIndex + 1),
                            ),
                            Text(
                              "Step ${model.pageIndex + 1} of 5",
                              style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            )
                          ],
                        ),
                        22.sbH,
                        Text(
                          "What’s your legal name?",
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: AppColors.bgContrast),
                        ),
                        34.sbH,
                        Input(
                          key: Key("fName"),
                          hintText: "First Name",
                          controller: firstName,
                          readOnly: false,
                          onChanged: (v) => model.setFName(v),
                        ),
                        16.sbH,
                        Input(
                          hintText: "Last Name",
                          readOnly: false,
                          controller: lastName,
                          onChanged: (v) => model.setLName(v),
                        ),
                        54.sbH,
                        UiButton(
                          text: "Next",
                          onPressed:
                              model.hasNames ? () => model.goForward() : null,
                        ),
                        36.sbH,
                      ],
                    );
                  case 1:
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomColoredContainer(
                              number: (model.pageIndex + 1),
                            ),
                            Text(
                              "Step ${model.pageIndex + 1} of 5",
                              style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            )
                          ],
                        ),
                        22.sbH,
                        Text(
                          "What’s your email?",
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: AppColors.bgContrast),
                        ),
                        34.sbH,
                        Input(
                          key: Key("email"),
                          hintText: "Email",
                          controller: email,
                          readOnly: false,
                          onChanged: (v) => model.setEmail(v),
                        ),
                        54.sbH,
                        UiButton(
                          text: "Next",
                          onPressed: model.hasEmail
                              ? () => model.updateNameAndEmail()
                              : null,
                        ),
                        36.sbH,
                      ],
                    );
                  case 2:
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomColoredContainer(
                              number: (model.pageIndex + 1),
                            ),
                            Text(
                              "Step ${model.pageIndex + 1} of 5",
                              style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            )
                          ],
                        ),
                        22.sbH,
                        const IHeader(
                          centerAlign: false,
                          title: "Create your 4-digit PIN",
                          subTitle:
                              "Please remember this PIN. It will be used to keep your account secure and approve transactions.",
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
                          onPressed:
                              model.hasPin ? () => model.goForward() : null,
                        ),
                        NumberInput(
                          onTap: (v) => model.pinController.text = v,
                          usePinLength: true,
                          onCompleted: (v) {},
                          biometrics: false,
                        ),
                      ],
                    );
                  case 3:
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomColoredContainer(
                              number: (model.pageIndex + 1),
                            ),
                            Text(
                              "Step ${model.pageIndex + 1} of 5",
                              style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            )
                          ],
                        ),
                        22.sbH,
                        const IHeader(
                          centerAlign: false,
                          title: "Confirm your 4-digit PIN",
                          subTitle: "Re-enter your secure 4-digit PIN",
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
                                    )
                                  : const SizedBox.shrink();
                            },
                            controller: model.confirmPinController,
                            key: const Key("confirm-pin"),
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
                        model.error ? 0.sbH : 50.sbH,
                        UiButton(
                          text: "Next",
                          onPressed: model.isValidPins
                              ? () => model.updatePassword()
                              : null,
                        ),
                        NumberInput(
                          onTap: (v) => model.confirmPinController.text = v,
                          usePinLength: true,
                          onCompleted: (v) {},
                          biometrics: false,
                        ),
                      ],
                    );
                  case 4:
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomColoredContainer(
                              number: (model.pageIndex + 1),
                            ),
                            Text(
                              "Step ${model.pageIndex + 1} of 5",
                              style: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            )
                          ],
                        ),
                        22.sbH,
                        const IHeader(
                          centerAlign: false,
                          title: "Create an MXE Tag",
                          subTitle:
                              "An MXE tag is your unique identifier, making it easier for others to find and transact with you.",
                        ),
                        34.sbH,
                        Input(
                          controller: model.mxeUserNameController,
                          key: const Key("mxe-name"),
                          hintText: "MXE Tag",
                          helperText: "Tag",
                          readOnly: false,
                          onChanged: (v) => model.setMXETag(v),
                        ),
                        ValueListenableBuilder(
                            valueListenable: model.mxeNames,
                            builder: (context, list, _) => Center(
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    children: list
                                        .map((e) => GestureDetector(
                                              onTap: () => model.setMXETag(e,
                                                  useController: true),
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 8, vertical: 6),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8,
                                                        horizontal: 16),
                                                decoration: BoxDecoration(
                                                    color:
                                                        AppColors.subtleAccent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Text(
                                                  e,
                                                  style: AppTextStyle
                                                      .labelSmRegular
                                                      .copyWith(
                                                          color: AppColors
                                                              .moderateBlue),
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                )),
                        54.sbH,
                        UiButton(
                          text: "Next",
                          onPressed: model.hasMxeTag
                              ? () => model.updateMxeTag()
                              : null,
                        ),
                        36.sbH,
                      ],
                    );
                  default:
                    return const SizedBox.shrink();
                }
              }),
            )));
  }
}

class CustomColoredContainer extends StatelessWidget {
  final num number;
  CustomColoredContainer({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    // Ensure the number is within the valid range (1-5)
    int clampedNumber = number.toInt().clamp(1, 5);

    // Calculate the width of the red portion
    double redWidth = clampedNumber * 24.0;

    return SizedBox(
      width: 120.0,
      height: 8.0,
      child: Row(
        children: [
          Container(
            width: redWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.moderateBlue,
            ),
          ),
          Container(
            width: 120.0 - redWidth,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
              color: AppColors.accentColor,
            ),
          ),
        ],
      ),
    );
  }
}
