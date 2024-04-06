import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';

Widget dialogBox(context) {
  return Container(
    width: 250,
    height: 400,
    child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Pin Changed",
            style: GoogleFonts.plusJakartaSans(
                fontSize: 24.sp, fontWeight: FontWeight.w700),
          ),
          12.sbH,
          Text(
            "You have successfully changed your PIN",
            style: GoogleFonts.plusJakartaSans(
                fontSize: 16.sp, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          24.sbH,
          UiButton(
            text: "Okay",
            onPressed: () => Navigator.pushNamed(context, Routes.homeRoute),
          )
        ],
      ),
    ),
  );
}

Widget buildSuccessDialog(BuildContext context) {
  return AlertDialog(
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(18.0))),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        dialogBox(context),
      ],
    ),
    actions: const <Widget>[],
  );
}
