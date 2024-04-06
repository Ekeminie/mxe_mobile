import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/textstyles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/home/insights/insights.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/dual-action-sheet.dart';
import 'package:mxe_mobile/widgets/initials-widget.dart';
import 'package:visibility_detector/visibility_detector.dart';

class TransferBeneficiariesListPage extends StatefulWidget {
  List<dynamic> list;
  String? title;
  TransferBeneficiariesListPage({Key? key, required this.list, this.title})
      : super(key: key);

  @override
  _TransferBeneficiariesListPageState createState() =>
      _TransferBeneficiariesListPageState();
}

class _TransferBeneficiariesListPageState
    extends State<TransferBeneficiariesListPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<InsightsViewModel>(
      builder: (context, model, child) => VisibilityDetector(
        key: const Key('customers'),
        onVisibilityChanged: (visibilityInfo) {
          if (visibilityInfo.visibleFraction == 1) {}
        },
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: AppColors.bgColor,
            body: widget.list.isEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      54.sbH,
                      Center(child: SvgPicture.asset('empty-icon'.svg)),
                      48.sbH,
                      AutoSizeText(
                        "It's Empty here",
                        style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                            color: AppColors.bgContrast),
                      )
                    ],
                  )
                : Column(
                    children: [
                      24.sbH,
                      ...widget.list.map((e) => LItem(item: e)).toList()
                    ],
                  )),
      ),
    )
        // )
        ;
  }
}

class LItem extends StatelessWidget {
  final dynamic item;
  LItem({super.key, required this.item});
  final ValueNotifier<bool> onTap = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      key: Key(item.toString()),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(12)),
      child: ValueListenableBuilder(
        valueListenable: onTap,
        builder: (context, show, _) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  UserNameWidget(userFullName: item.toString()),
                  16.sbW,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          item.toString(),
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 16.sp, fontWeight: FontWeight.w400),
                        ),
                        10.sbH,
                        AutoSizeText(
                          item.toString(),
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textLight),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => {onTap.value = !onTap.value},
                    child: show
                        ? SvgPicture.asset('chevron-down'.svg)
                        : SvgPicture.asset('chevron-right'.svg),
                  ),
                ],
              ),
              if (show)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: LItemEnum.values
                      .map((e) => GestureDetector(
                            onTap: () {
                              switch (e) {
                                case LItemEnum.edit:
                                  Navigator.pushNamed(
                                      context, Routes.editBeneficiaryRoute);
                                  break;
                                case LItemEnum.send:
                                  Navigator.pushNamed(
                                      context, Routes.editBeneficiaryRoute);
                                  break;
                                case LItemEnum.delete:
                                  dualActionSheets(context,
                                      title: "Delete Beneficiary",
                                      subTitle:
                                          "You are about to delete this beneficiary? Are you sure?",
                                      actionTitle: "Delete",
                                      icon: "idelete".svg,
                                      onTap: () => Navigator.pop(context));
                                  break;
                                default:
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 16),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              decoration: BoxDecoration(
                                  color: e.color,
                                  borderRadius: BorderRadius.circular(24)),
                              child: Row(
                                children: [
                                  AutoSizeText(
                                    e.title!,
                                    style: AppTextStyle.labelSmBold
                                        .copyWith(color: e.tColor),
                                  ),
                                  8.sbW,
                                  SvgPicture.asset(e.icon.toString().svg)
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                )
            ],
          ),
        ),
      ),
    );
  }
}

enum LItemEnum {
  edit(
      title: "Edit",
      icon: 't_edit',
      color: AppColors.moderateBlue,
      tColor: AppColors.white),
  send(
      title: "Send Money",
      icon: 't_send_money',
      color: AppColors.subtleAccent,
      tColor: AppColors.moderateBlue),
  delete(
      title: "Delete",
      icon: 't_delete',
      color: AppColors.errorCode,
      tColor: AppColors.white);

  final String? title;
  final String? icon;
  final Color? color;
  final Color? tColor;
  const LItemEnum({this.title, this.icon, this.color, this.tColor});
}
