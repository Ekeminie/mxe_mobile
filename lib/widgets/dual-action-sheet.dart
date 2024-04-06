import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/textstyles.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/bottomsheet-widgets.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';

class DualActionSheet extends StatelessWidget {
  String? title;
  String? subTitle;
  String? actionTitle;
  String? icon;
  Function()? onTap;
  DualActionSheet(
      {Key? key,
      this.title,
      this.icon,
      this.actionTitle,
      this.subTitle,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      child: Container(
        padding: EdgeInsets.only(
            // right: 20,
            // left: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        color: Colors.white,
        // height: 500,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              12.sbH,
              const SheetHandle(),
              32.sbH,
              header(title ?? "", usePadding: false),
              8.0.sbH,
              24.0.sbH,
              AutoSizeText(
                subTitle ?? "",
                style: AppTextStyle.labelSmRegular.copyWith(
                  color: AppColors.textLight,
                ),
              ),
              24.sbH,
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 18),
                        decoration: BoxDecoration(
                            color: AppColors.moderateBlue,
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: AutoSizeText(
                            "Cancel",
                            style: AppTextStyle.labelMdBold
                                .copyWith(color: AppColors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  16.sbW,
                  Expanded(
                    child: GestureDetector(
                      onTap: () => {Navigator.pop(context), onTap!()},
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 18),
                        decoration: BoxDecoration(
                            color: AppColors.errorCode,
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AutoSizeText(
                              actionTitle ?? "",
                              style: AppTextStyle.labelMdBold
                                  .copyWith(color: AppColors.white),
                            ),
                            if (icon.isNotNullNorEmpty) 8.sbW,
                            if (icon.isNotNullNorEmpty) SvgPicture.asset(icon!)
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              32.sbH,
            ],
          ),
        ),
      ),
    );
  }
}

dualActionSheets(BuildContext context,
    {String? title,
    String? subTitle,
    String? actionTitle,
    String? icon,
    Function()? onTap}) {
  showModalBottomSheet(
      enableDrag: true,
      isDismissible: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DualActionSheet(
            title: title,
            subTitle: subTitle,
            actionTitle: actionTitle,
            icon: icon,
            onTap: onTap);
      });
}
