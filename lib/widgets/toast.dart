import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mxe_mobile/constant/palette.dart';
import 'package:mxe_mobile/core/services/navigation_service.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/locator.dart';

Widget toast(String message, {bool? success}) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Align(
      alignment: Alignment.bottomCenter,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          width: double.infinity,
          height: 50.0,
          color: !success! ? Colors.orangeAccent : Colors.greenAccent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Material(
                color: Colors.transparent,
                child: Text(
                  message.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

showCustomToast(
  String message, {
  bool success = false,
  num? time,
}) {
  // dialogLocation(message: message, success: success, time: time);
  // showToastWidget(
  //   toast(message, success: success),
  //   duration: const Duration(seconds: 3),
  //   onDismiss: () {},
  // );

  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: success ? Colors.green : AppColors.errorCodeBG,
    textColor: success ? Colors.white : AppColors.errorCode,
    fontSize: 16.0,
  );
}

showCustomToastt(
  String message, {
  bool success = false,
  bool showCancel = false,
  bool floating = false,
}) {
  final SnackBar snackBar = SnackBar(
    behavior: !floating ? null : SnackBarBehavior.floating,
    content: Text(message),
    action: showCancel
        ? SnackBarAction(
            textColor: primaryDarkColor,
            label: 'Close',
            onPressed: () {
              getIt<NavigationService>()
                  .snackBarKey
                  .currentState
                  ?.removeCurrentSnackBar();
            },
          )
        : null,
    backgroundColor: success ? primaryColor : Colors.red,
  );
  getIt<NavigationService>().snackBarKey.currentState?.showSnackBar(snackBar);
}

void dialogLocation({bool? success = false, String? message, num? time}) async {
  locationDialog({
    required Alignment alignment,
    double width = double.infinity,
    double height = double.infinity,
  }) async {
    SmartDialog.show(
      alignment: alignment,
      builder: (_) => Container(
          padding: EdgeInsets.only(left: 8.0.w, right: 8.0.w),
          width: width,
          height: height,
          color: success! ? Colors.green : Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  message!,
                  style: TextStyle(
                      color: white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp),
                ),
              ),
              IconButton(
                  onPressed: () {
                    SmartDialog.dismiss();
                  },
                  icon: Icon(
                    Icons.close,
                    color: white,
                  ))
            ],
          )),
    );
    await Future.delayed(Duration(milliseconds: time?.toInt() ?? 5000));
    SmartDialog.dismiss();
  }

  //bottom
  await locationDialog(height: 70, alignment: Alignment.bottomCenter);
}
