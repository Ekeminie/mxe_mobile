import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';

class SquareButton extends StatelessWidget {
  final bool isActive;
  final Function() onClick;
  const SquareButton(
      {super.key, required this.isActive, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
            color: isActive ? AppColors.moderateBlue : AppColors.disabledBg,
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(18.5),
        child: SvgPicture.asset((isActive ? "arrow_a" : "arrow").svg),
      ),
    );
  }
}
