import 'package:flutter/material.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';

class SheetHandle extends StatelessWidget {
  const SheetHandle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 50,
        height: 4,
        decoration: BoxDecoration(
            color: AppColors.border, borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
