import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/model/withdrawal-beneficiary-response.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/textstyles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/profile/beneficiaries/beneficiaries.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/custom_btn.dart';
import 'package:mxe_mobile/widgets/dual-action-sheet.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';
import 'package:mxe_mobile/widgets/initials-widget.dart';
import 'package:mxe_mobile/widgets/input.dart';

class EditTBeneficiaryPage extends StatefulWidget {
  final WithdrawalBeneficiary item;
  const EditTBeneficiaryPage({Key? key, required this.item}) : super(key: key);

  @override
  State<EditTBeneficiaryPage> createState() => _EditTBeneficiaryPageState();
}

class _EditTBeneficiaryPageState extends State<EditTBeneficiaryPage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<BeneficiariesViewModel>(
      onModelReady: (m) => m.init(widget.item),
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.bgColor,
        appBar: customAppBar("", bgColor: AppColors.bgColor, actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: GestureDetector(
              onTap: () => dualActionSheets(context,
                  title: "Delete Beneficiary",
                  subTitle:
                      "You are about to delete this beneficiary? Are you sure?",
                  actionTitle: "Delete",
                  icon: "idelete".svg,
                  onTap: () => model.deleteAirtimeAndDataBeneficiary(
                        id: widget.item.id,
                      )),
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    color: AppColors.errorCode,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    AutoSizeText(
                      "Delete",
                      style: AppTextStyle.labelMdBold
                          .copyWith(color: AppColors.white),
                    ),
                    8.sbW,
                    SvgPicture.asset('t_delete'.svg)
                  ],
                ),
              ),
            ),
          ),
          16.sbW,
        ]),
        body: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header("Edit Beneficiary"),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Column(
                  children: [
                    38.sbH,
                    UserNameWidget(
                      userFullName: widget.item.name ?? "",
                      radius: 38,
                      textStyle: AppTextStyle.headingHeading2
                          .copyWith(color: AppColors.moderateBlue),
                    ),
                    12.sbH,
                    AutoSizeText(
                      widget.item.name ?? "",
                      style: AppTextStyle.labelMdRegular
                          .copyWith(color: AppColors.bgContrast),
                    ),
                    32.sbH,
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: AppColors.disabledBg,
                                borderRadius: BorderRadius.circular(12)),
                            child: Input(
                              readOnly: true,
                              enabled: false,
                              autofocus: false,
                              hintText: widget.item.bankName,
                              onChanged: (v) => {},
                            ),
                          ),
                          16.sbH,
                          // Input(
                          //   hintText: "Phone Number",
                          //   prefixWidget: Row(
                          //     mainAxisSize: MainAxisSize.min,
                          //     children: [
                          //       16.sbW,
                          //       SvgPicture.asset('ngn-flag'.svg),
                          //       5.sbW,
                          //       const Text("+234"),
                          //       5.sbW,
                          //       const Icon(Icons.keyboard_arrow_down_rounded)
                          //     ],
                          //   ),
                          //   readOnly: false,
                          //   onChanged: (v) => {},
                          // ),
                          Input(
                            hintText: "Account number/IBAN",
                            readOnly: false,
                            onChanged: (v) => {},
                            controller: model.accountNumberController,
                          ),
                          16.sbH,
                          Input(
                            hintText: "Routing number/Sort code",
                            readOnly: false,
                            onChanged: (v) => {},
                          ),
                          16.sbH,
                          Input(
                            hintText: "Swift code",
                            readOnly: false,
                            onChanged: (v) => {},
                          ),
                          16.sbH,
                          Input(
                            hintText: "Receiver name",
                            readOnly: true,
                            onChanged: (v) => {},
                            controller: model.accountNameController,
                          ),
                        ],
                      ),
                    ),
                    16.sbH,
                    32.sbH,
                    24.sbH,
                    UiButton(
                      text: "Continue",
                      onPressed: () => Navigator.pushReplacementNamed(
                          context, Routes.homeRoute),
                    )
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
