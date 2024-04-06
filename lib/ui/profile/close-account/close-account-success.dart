import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/textstyles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/profile/saved-cards/saved-card.vm.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';

class CloseAccountSuccess extends StatefulWidget {
  const CloseAccountSuccess({Key? key}) : super(key: key);

  @override
  State<CloseAccountSuccess> createState() => _CloseAccountSuccessState();
}

class _CloseAccountSuccessState extends State<CloseAccountSuccess> {
  @override
  Widget build(BuildContext context) {
    return BaseView<SavedCardViewModel>(
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: customAppBar(
          "",
          bgColor: AppColors.bgColor,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              const AutoSizeText(
                "We are sorry to see you go",
                style: AppTextStyle.headingHeading1,
              ),
              24.sbH,
              const AutoSizeText(
                "If you would ever like to reopen your account, please react out to support@mxe.com and we will provide you steps to get your account back",
                style: AppTextStyle.paragraphMd,
              ),
              100.sbH,
              UiButton(
                text: "Home",
                onPressed: () => Navigator.pushNamed(context, Routes.homeRoute),
              ),
              Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
