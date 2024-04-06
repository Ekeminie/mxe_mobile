import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/home/request/request.vm.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';
import 'package:mxe_mobile/widgets/initials-widget.dart';
import 'package:mxe_mobile/widgets/input.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({Key? key}) : super(key: key);

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BaseView<RequestViewModel>(
      onModelReady: (m) => m.get1(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: customAppBar("", bgColor: AppColors.bgColor),
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header("Request From"),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  38.sbH,
                  Input(
                    autofocus: false,
                    prefixText: "@  ",
                    hintText: "Mxe Tag",
                    onChanged: (v) => model.search(v),
                    controller: controller,
                  ),
                  16.sbH,
                  if (model.isLoading)
                    const SpinKitCircle(color: AppColors.primaryColor),
                  16.sbH,
                  if (model.selectedBeneficiary != null)
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => {
                        model.save1(),
                        Navigator.pushNamed(
                            context, Routes.requestFundsDetailsPageRoute)
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 16.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            UserNameWidget(
                              textColor: AppColors.moderateBlue,
                              userFullName:
                                  "${model.selectedBeneficiary?.fName} ${model.selectedBeneficiary?.lName}",
                              radius: 22,
                            ),
                            12.sbW,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${model.selectedBeneficiary?.fName} ${model.selectedBeneficiary?.lName}",
                                    style: GoogleFonts.plusJakartaSans(
                                        color: AppColors.bgContrast,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.sp),
                                  ),
                                  2.sbH,
                                  Text(
                                    "${model.selectedBeneficiary?.userName}",
                                    style: GoogleFonts.plusJakartaSans(
                                        color: AppColors.textLight,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.sp),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ValueListenableBuilder(
                      valueListenable: model.queryResult,
                      builder: (context, list, _) => Column(
                            children: list
                                .map(
                                  (e) => GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () => {
                                      model.saveUser(e),
                                      Navigator.pushNamed(context,
                                          Routes.requestFundsDetailsPageRoute)
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 16.h),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          UserNameWidget(
                                            textColor: AppColors.moderateBlue,
                                            userFullName: e,
                                            radius: 22,
                                          ),
                                          12.sbW,
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  e,
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                          color: AppColors
                                                              .bgContrast,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16.sp),
                                                ),
                                                2.sbH,
                                                Text(
                                                  e,
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                          color: AppColors
                                                              .textLight,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16.sp),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          )),
                  32.sbH,
                  24.sbH,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
