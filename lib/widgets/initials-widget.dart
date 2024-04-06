import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mxe_mobile/constant/palette.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';

class UserNameWidget extends StatelessWidget {
  final String userFullName;
  final double radius;
  Color? textColor;
  Color? bgColor;
  double? textSize;
  TextStyle? textStyle;
  UserNameWidget(
      {Key? key,
      required this.userFullName,
      this.radius = 20,
      this.textColor,
      this.textSize,
      this.textStyle,
      this.bgColor,
      t})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: bgColor ?? const Color(0xffD9EAFF),
      child: Text(
        userFullName.getInitials(),
        style: textStyle ??
            TextStyle(
                color: textColor ?? primaryDarkColor,
                fontWeight: FontWeight.w700,
                fontSize: textSize ?? 14.sp),
      ),
    );
  }
}
