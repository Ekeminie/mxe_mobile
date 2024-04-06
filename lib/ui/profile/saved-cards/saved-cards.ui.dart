import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/textstyles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/profile/saved-cards/saved-card.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/dual-action-sheet.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';

class SavedCardPage extends StatefulWidget {
  const SavedCardPage({Key? key}) : super(key: key);

  @override
  State<SavedCardPage> createState() => _NotificationPreferencePageState();
}

class _NotificationPreferencePageState extends State<SavedCardPage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<SavedCardViewModel>(
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.bgColor,
        appBar: customAppBar("", bgColor: AppColors.bgColor),
        body: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header("Saved Cards"),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    38.sbH,
                    32.sbH,
                    ...['visa', 'mastercard']
                        .map(
                          (e) => Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: AppColors.border, width: 2)),
                            child: Row(
                              children: [
                                SvgPicture.asset(e.toString().svg),
                                12.sbW,
                                const AutoSizeText(
                                  "1234",
                                  style: AppTextStyle.labelMdRegular,
                                ),
                                const Spacer(),
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () => dualActionSheets(context,
                                      title: "Delete this Card",
                                      subTitle:
                                          "You are about to delete this  **3729 Visa Card? Are you sure?",
                                      actionTitle: "Delete",
                                      icon: "idelete".svg,
                                      onTap: () => Navigator.pop(context)),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 8),
                                    decoration: BoxDecoration(
                                        color: AppColors.errorCodeBG,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: AutoSizeText(
                                      "Delete",
                                      style: AppTextStyle.labelMdBold
                                          .copyWith(color: AppColors.errorCode),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    UiButton(
                      text: "Add New Card",
                      onPressed: () => Navigator.pushNamed(
                          context, Routes.addNewCardPageRoute),
                    ),
                    32.sbH,
                    24.sbH,
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
