import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';

class FixedHeightScrollView extends StatelessWidget {
  final Widget child;
  const FixedHeightScrollView({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          minWidth: width(context), minHeight: (height(context) - 160.h)),
      child: IntrinsicHeight(
        child: child,
      ),
    );
  }
}
