import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/constant/palette.dart';
import 'package:mxe_mobile/core/enum/fundtype-enum.dart';
import 'package:mxe_mobile/core/enum/status-enum.dart';
import 'package:mxe_mobile/core/model/airtime-and-data-beneficiary-response.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/beneficiary/transfer-beneficiary.dart';
import 'package:mxe_mobile/ui/bills/bills-beneficiaries/bills-beneficiaries.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/dual-action-sheet.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';
import 'package:mxe_mobile/widgets/initials-widget.dart';
import 'package:mxe_mobile/widgets/input.dart';

class BillsBeneficiaries extends StatefulWidget {
  final bool? showAppbar;
  const BillsBeneficiaries({Key? key, this.showAppbar = true})
      : super(key: key);

  @override
  State<BillsBeneficiaries> createState() => _BillsBeneficiariesState();
}

class _BillsBeneficiariesState extends State<BillsBeneficiaries> {
  ValueNotifier<InsightsTimeLineEnum> timeline =
      ValueNotifier(InsightsTimeLineEnum.sevenDays);

  ValueNotifier<bool> isSearching = ValueNotifier(false);
  ValueNotifier<FundType> fundType = ValueNotifier(FundType.cardPayment);

  bool newUser = true;
  bool verified = true;

  @override
  Widget build(BuildContext context) {
    return BaseView<BillsBeneficiariesViewModel>(
      onModelReady: (m) => m.getAirtimeAndDataBeneficiary(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: (widget.showAppbar ?? false)
            ? customAppBar("", bgColor: AppColors.bgColor, actions: [
                ValueListenableBuilder(
                    valueListenable: isSearching,
                    builder: (context, searching, _) => searching
                        ? Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 50, right: 20),
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
        body: GestureDetector(
          onTap: () => isSearching.value = false,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.showAppbar!)
                  header('Beneficiaries', usePadding: false),
                32.sbH,
                Expanded(
                    child: ValueListenableBuilder(
                  valueListenable: model.appCache.airtimeDataBeneficiary,
                  builder: (context, value, child) => value.isNotEmpty
                      ? ListView.builder(
                          itemCount: value.length,
                          itemBuilder: (context, i) {
                            AirtimeDataBeneficiaryResponse item = value[i];
                            return BeneficiaryTile(
                              item: item,
                              b: () {},
                              c: () => model.deleteAirtimeAndDataBeneficiary(
                                  id: item.sId, pop: false),
                            );
                            //   GestureDetector(
                            //   behavior: HitTestBehavior.opaque,
                            //   onTap: () => Navigator.pop(context, item),
                            //   child: Container(
                            //     margin: EdgeInsets.symmetric(vertical: 16.h),
                            //     child: Row(
                            //       crossAxisAlignment: CrossAxisAlignment.center,
                            //       children: [
                            //         UserNameWidget(
                            //           textColor: AppColors.moderateBlue,
                            //           userFullName: "${item.name} ",
                            //           radius: 24,
                            //         ),
                            //         16.sbW,
                            //         Expanded(
                            //           child: Column(
                            //             crossAxisAlignment:
                            //                 CrossAxisAlignment.start,
                            //             children: [
                            //               Text(
                            //                 "${item.name} ",
                            //                 style: GoogleFonts.plusJakartaSans(
                            //                     color: AppColors.bgContrast,
                            //                     fontWeight: FontWeight.w400,
                            //                     fontSize: 16.sp),
                            //               ),
                            //               10.sbH,
                            //               Text(
                            //                 "${item.phoneNumber} - ${item.provider?.toUpperCase()}",
                            //                 style: GoogleFonts.plusJakartaSans(
                            //                     color: AppColors.textLight,
                            //                     fontWeight: FontWeight.w400,
                            //                     fontSize: 16.sp),
                            //                 textAlign: TextAlign.left,
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // );
                          })
                      : (model.isQueryingUser)
                          ? SizedBox(
                              width: double.infinity,
                              child: SpinKitThreeBounce(
                                color: primaryColor,
                              ))
                          : const Column(
                              children: [
                                Spacer(),
                                Text("Empty State"),
                                Spacer(
                                  flex: 2,
                                )
                              ],
                            ),
                ))
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

  final AirtimeDataBeneficiaryResponse item;
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
                    userFullName: "${item.name} ",
                    radius: 24,
                  ),
                  16.sbW,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${item.name} ",
                          style: GoogleFonts.plusJakartaSans(
                              color: AppColors.bgContrast,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp),
                        ),
                        10.sbH,
                        Text(
                          "${item.phoneNumber} - ${item.provider?.toUpperCase()}",
                          style: GoogleFonts.plusJakartaSans(
                              color: AppColors.textLight,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp),
                          textAlign: TextAlign.left,
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TileAction(
                      action: () => Navigator.pushNamed(
                          context, Routes.editBillsBeneficiaryRoute,
                          arguments: item),
                      title: "Edit",
                      icon: "t_edit",
                      bg: AppColors.moderateBlue,
                    ),
                    TileAction(
                        action: b!,
                        title: "Top Up",
                        icon: "t_topup",
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

class SingleBeneficiary {
  String? fName;
  String? lName;
  String? phone;
  String? provider;
  String? userName;

  SingleBeneficiary(
      {this.fName, this.lName, this.phone, this.provider, this.userName});
}
