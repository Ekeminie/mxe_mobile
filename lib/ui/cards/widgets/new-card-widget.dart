import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';

class NewCardWidget extends StatelessWidget {
  const NewCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: customAppBar("",
          bgColor: AppColors.bgColor,
          showBackButton: false,
          backFunction: () {}),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header("Create Virtual Card", usePadding: false),
            32.sbH,
            Image.asset('assets/animation/card-animation.gif'),
            // SvgPicture.asset('dummy-card'.svg),
            32.sbH,
            AutoSizeText(
              "Unlock the world of global shopping and seamless subscription payments with MXE's Virtual Card. Our Virtual Cards are your ticket to hassle-free international purchases and subscription management.",
              style: GoogleFonts.plusJakartaSans(),
              textAlign: TextAlign.center,
            ),
            68.sbH,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('price'.svg),
                Text(
                  "Creation fee \$3.50",
                  style: GoogleFonts.plusJakartaSans(
                      color: AppColors.yellow, fontSize: 16),
                )
              ],
            ),
            16.sbH,
            UiButton(
              text: "Create Virtual Card",
              onPressed: () =>
                  Navigator.pushNamed(context, Routes.createCardPageRoute),
            ),
          ],
        ),
      ),
    );
  }
}
