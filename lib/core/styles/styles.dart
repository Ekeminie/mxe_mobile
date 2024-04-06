import 'package:flutter/material.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:pinput/pinput.dart';

final defaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: const TextStyle(
      fontSize: 18,
      color: Color.fromRGBO(87, 30, 30, 1),
      fontWeight: FontWeight.w600),
  decoration: BoxDecoration(
      border: Border.all(color: AppColors.border), shape: BoxShape.circle),
);

final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    border: Border.all(color: AppColors.boldSemantic, width: 2),
    // borderRadius: BorderRadius.circular(8),
    shape: BoxShape.circle);

final submittedPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: const TextStyle(
      fontSize: 18, color: AppColors.bgContrast, fontWeight: FontWeight.w600),
  decoration: BoxDecoration(
      color: AppColors.white,
      shape: BoxShape.circle,
      border: Border.all(color: AppColors.disabledBg)),
);
final errorPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: const TextStyle(
      fontSize: 18, color: AppColors.errorCode, fontWeight: FontWeight.w600),
  decoration: BoxDecoration(
      color: AppColors.errorCodeBG,
      shape: BoxShape.circle,
      border: Border.all(color: AppColors.errorCode, width: 2)),
);
