import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/ui/profile/statement/as-timeline-sheet.dart';
import 'package:mxe_mobile/ui/profile/statement/statement.vm.dart';
import 'package:mxe_mobile/ui/profile/statement/statement_accounttype-sheet.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';

class AccountStatementPage extends StatefulWidget {
  const AccountStatementPage({Key? key}) : super(key: key);

  @override
  State<AccountStatementPage> createState() => _AccountStatementPageState();
}

class _AccountStatementPageState extends State<AccountStatementPage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<AccountStatementViewModel>(
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: customAppBar(
          "",
          bgColor: AppColors.bgColor,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header("Download Statement", usePadding: false),
              24.sbH,
              Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: model.accountType,
                      builder: (context, accountType, _) => GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => showUsASDownloadStatementSheet(context,
                            old: model.accountType.value,
                            onTap: (v) =>
                                {model.accountType.value = v, model.refresh()},
                            title: "Select Account",
                            fromCurrency: true),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.h, horizontal: 16.w),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: (accountType != null)
                                      ? AppColors.moderateBlue
                                      : AppColors.border,
                                  width: 2),
                              borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (accountType?.icon != null)
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: SvgPicture.asset(
                                          accountType!.icon.toString().svg,
                                          width: 16,
                                          height: 20,
                                          fit: BoxFit.fitWidth,
                                        )),
                                  16.sbW,
                                  (accountType != null)
                                      ? Text(accountType.title ?? "")
                                      : Text(
                                          "Select Account",
                                          style: GoogleFonts.plusJakartaSans(
                                            color: AppColors.textLight,
                                          ),
                                        ),
                                ],
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: accountType != null
                                    ? null
                                    : AppColors.border,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    24.sbH,
                    ValueListenableBuilder(
                      valueListenable: model.timelineType,
                      builder: (context, accountType, _) => GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => showUsASTimelineSheet(context,
                            old: model.timelineType.value,
                            onTap: (v) =>
                                {model.timelineType.value = v, model.refresh()},
                            title: "Select Timeline",
                            fromCurrency: true),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.h, horizontal: 16.w),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: (accountType != null)
                                      ? AppColors.moderateBlue
                                      : AppColors.border,
                                  width: 2),
                              borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              (accountType != null)
                                  ? Text(accountType.title ?? "")
                                  : Text(
                                      "Select Timeline",
                                      style: GoogleFonts.plusJakartaSans(
                                        color: AppColors.textLight,
                                      ),
                                    ),
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: accountType != null
                                    ? null
                                    : AppColors.border,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    24.sbH,
                    UiButton(
                      text: "Download Statement",
                      onPressed: () {
                        model.getStatementOfAccount();
                        // showCustomToast(
                        //     "You will receive an email with your account statement  shortly",
                        //     success: true);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
