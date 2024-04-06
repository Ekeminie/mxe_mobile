import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/enum/status-enum.dart';
import 'package:mxe_mobile/core/model/withdrawal-beneficiary-response.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/textstyles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/home/send/send.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/dual-action-sheet.dart';
import 'package:mxe_mobile/widgets/empty-state.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';
import 'package:mxe_mobile/widgets/initials-widget.dart';
import 'package:mxe_mobile/widgets/input.dart';

class TransferBeneficiaries extends StatefulWidget {
  final bool? showAppbar;

  const TransferBeneficiaries({Key? key, this.showAppbar = true})
      : super(key: key);

  @override
  State<TransferBeneficiaries> createState() => _TransferBeneficiariesState();
}

class _TransferBeneficiariesState extends State<TransferBeneficiaries> {
  ValueNotifier<InsightsTimeLineEnum> timeline =
      ValueNotifier(InsightsTimeLineEnum.sevenDays);

  final tag = TextEditingController();
  final accountNo = TextEditingController();
  final sortCode = TextEditingController();
  final swiftCode = TextEditingController();
  final receiverName = TextEditingController();
  ValueNotifier<bool> isSearching = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return BaseView<SendFundsViewModel>(
      onModelReady: (m) => m.getBeneficiaries(),
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.bgColor,
        appBar: (widget.showAppbar ?? false)
            ? customAppBar("", bgColor: AppColors.bgColor, actions: [
                ValueListenableBuilder(
                    valueListenable: isSearching,
                    builder: (context, searching, _) => searching
                        ? Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 50, right: 20, top: 20),
                              child: Input(
                                autofocus: true,
                                prefixWidget: SizedBox(
                                  height: 8.h,
                                  width: 8.w,
                                  child: SvgPicture.asset('search-icon'.svg,
                                      height: 8.h,
                                      width: 8.w,
                                      fit: BoxFit.scaleDown),
                                ),
                                hintText: "Find a Contact",
                                onChanged: (v) => model.searchBeneficiary(v),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () => isSearching.value = true,
                            behavior: HitTestBehavior.opaque,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: SvgPicture.asset('search-icon'.svg),
                            ),
                          ))
              ])
            : null,
        body: Container(
          height: height(context),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GestureDetector(
            onTap: () => isSearching.value = false,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.showAppbar ?? false)
                  header('Beneficiaries', usePadding: false),
                32.sbH,
                Expanded(
                    child: ValueListenableBuilder(
                        valueListenable: model.withdrawalBeneficiaries,
                        builder: (context, value, child) => value.isNotEmpty
                            ? ListView.builder(
                                itemCount: value.length,
                                itemBuilder: (context, i) {
                                  WithdrawalBeneficiary item = value[i];
                                  return BeneficiaryTile(
                                    key: Key(i.toString()),
                                    item: item,
                                    c: () => model.deleteWithdrawalBeneficiary(
                                        id: item.id, pop: false),
                                    b: () {},
                                  );
                                })
                            : (model.isQueryingUser)
                                ? const SizedBox(
                                    width: double.infinity,
                                    child: SpinKitThreeBounce(
                                      color: AppColors.primaryColor,
                                    ))
                                : const EmptyState()))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BeneficiaryTile extends StatelessWidget {
  Function()? b;
  Function()? c;
  BeneficiaryTile({
    super.key,
    this.b,
    this.c,
    required this.item,
  });

  final WithdrawalBeneficiary item;
  final ValueNotifier<bool> expand = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.pop(context, item),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16.h),
        child: ValueListenableBuilder(
          valueListenable: expand,
          builder: (context, show, _) => Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  UserNameWidget(
                    textColor: AppColors.moderateBlue,
                    userFullName: "${item.name}",
                    radius: 24,
                  ),
                  16.sbW,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${item.bankName}",
                          style: GoogleFonts.plusJakartaSans(
                              color: AppColors.bgContrast,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp),
                        ),
                        4.sbH,
                        Text(
                          "${item.name} - ${item.accountNumber}",
                          style: GoogleFonts.plusJakartaSans(
                              color: AppColors.textLight,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp),
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                      onTap: () => expand.value = !expand.value,
                      child: SvgPicture.asset(
                          (!show ? 'chevron-right' : 'chevron-down').svg))
                ],
              ),
              if (show) 16.sbH,
              if (show)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TileAction(
                      action: () => Navigator.pushNamed(
                          context, Routes.editBeneficiaryRoute,
                          arguments: item),
                      title: "Edit",
                      icon: "t_edit",
                      bg: AppColors.moderateBlue,
                    ),
                    TileAction(
                        action: b!,
                        title: "Send Money",
                        icon: "t_send_money",
                        bg: AppColors.subtleAccent,
                        textColor: AppColors.moderateBlue),
                    TileAction(
                      action: () => dualActionSheets(context,
                          subTitle:
                              "You are about to delete this beneficiary? Are you sure?",
                          actionTitle: "Delete",
                          title: "Delete Beneficiary",
                          icon: "idelete".svg,
                          onTap: c!),
                      title: "Delete",
                      icon: "t_delete",
                      bg: AppColors.errorCode,
                    )
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}

class TileAction extends StatelessWidget {
  final String? title;
  final String? icon;
  final Color? bg;
  final Color? textColor;
  final Function() action;
  const TileAction(
      {super.key,
      this.title,
      this.icon,
      required this.action,
      this.bg,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 16),
        decoration: BoxDecoration(
          color: bg ?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Text(
              title ?? "",
              style: AppTextStyle.labelSmBold
                  .copyWith(color: textColor ?? AppColors.white),
            ),
            8.sbW,
            SvgPicture.asset((icon ?? "edit").svg),
          ],
        ),
      ),
    );
  }
}
