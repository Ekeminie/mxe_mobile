import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

const String errorMessageTxt =
    "Something went wrong, Please restart app or try again";
const String token = 'token';
const String refreshToken = 'refreshToken';
const String introScreen = 'introScreen';
const String currentUser = 'currentUser';
const String userID = 'userID';
const String appleAuthObject = 'appleAuthObject';
const String settings = 'settings';
const String imagePath = "assets/images/";
const String removeTokenEndPoint = 'token/remove';
const String naira = '₦';
const String nairaSign = "\u{20a6}";
const String toggleBiometrics = 'enableBioMetrics';
const String cashAccountWallet = 'Cash Account Wallet';
String get encryptAuthInfo => 'onDeviceAuthInfo-';

String get pwdEncryptionKey => dotenv.env['PASSWORD_ENCRYPTION_KEY']!;

var fontExtraBold = GoogleFonts.poppins(fontWeight: FontWeight.w700).fontFamily;
var fontBold = GoogleFonts.poppins(fontWeight: FontWeight.w800).fontFamily;
var fontNormal = GoogleFonts.poppins(fontWeight: FontWeight.normal).fontFamily;
var fontLight = GoogleFonts.poppins(
    color: const Color.fromRGBO(79, 79, 79, 1),
    fontSize: 12,
    letterSpacing: 0,
    fontWeight: FontWeight.normal,
    height: 1.6666666666666667);

//Padding
var p20 = EdgeInsets.symmetric(horizontal: 20.w);
var p30 = EdgeInsets.symmetric(horizontal: 30.w);
var p40 = EdgeInsets.symmetric(horizontal: 40.w);

// Pin put
