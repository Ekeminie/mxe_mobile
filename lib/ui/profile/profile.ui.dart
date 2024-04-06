import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/textstyles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/profile/profile.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/dual-action-sheet.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ValueNotifier<bool> faceId = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
      onModelReady: (m) => m.init(),
      builder: (context, model, child) => SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(color: AppColors.bgColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FrameWidget(
                child: Container(
                  height: 85.h,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Row(
                    children: [
                      Badge(
                          padding: EdgeInsets.zero,
                          alignment: Alignment.topRight,
                          offset: const Offset(0, 0),
                          largeSize: 20,
                          isLabelVisible: true,
                          backgroundColor: Colors.transparent,
                          label: SvgPicture.asset('avatar-badge'.svg),
                          child: SvgPicture.asset('avatar-large'.svg)),
                      8.sbW,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${model.userService.userCredentials.value.fullName}",
                            style: AppTextStyle.headingHeading2
                                .copyWith(color: AppColors.white),
                          ),
                          Text(
                            "${model.userService.userCredentials.value.MXETag}",
                            style: AppTextStyle.labelMdRegular
                                .copyWith(color: AppColors.white),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              12.sbH,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Account",
                  style: AppTextStyle.headingHeading3
                      .copyWith(color: AppColors.bgContrast),
                ),
              ),
              8.sbH,
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    ProfileListItem(
                        title: "Edit Profile",
                        icon: "p_edit_profile",
                        onTap: () => Navigator.pushNamed(
                            context, Routes.editProfilePageRoute)),
                    ProfileListItem(
                        title: "Notification Preferences",
                        icon: "p_notifications",
                        onTap: () => Navigator.pushNamed(
                            context, Routes.notificationPagePreferencesRoute)),
                  ],
                ),
              ),
              24.sbH,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Finance",
                  style: AppTextStyle.headingHeading3
                      .copyWith(color: AppColors.bgContrast),
                ),
              ),
              8.sbH,
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    ProfileListItem(
                        title: "Beneficiaries",
                        icon: "p_beneficiaries",
                        onTap: () => Navigator.pushNamed(
                            context, Routes.beneficiariesPageRoute)),
                    ProfileListItem(
                        title: "Saved Cards",
                        icon: "p_saved_cards",
                        onTap: () => Navigator.pushNamed(
                            context, Routes.savedCardPageRoute)),
                    ProfileListItem(
                        title: "Scheduled Payments",
                        icon: "p_scheduled_payments",
                        onTap: () => Navigator.pushNamed(
                            context, Routes.schedulePaymentListPageRoute)),
                    ProfileListItem(
                        title: "Generate Statement",
                        icon: "p_generate_statement",
                        onTap: () => Navigator.pushNamed(
                            context, Routes.accountStatementPageRoute)),
                  ],
                ),
              ),
              24.sbH,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Security",
                  style: AppTextStyle.headingHeading3
                      .copyWith(color: AppColors.bgContrast),
                ),
              ),
              8.sbH,
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    ProfileListItem(
                        title: "Hide Balance",
                        icon: "p_hide_balance",
                        onTap: () {},
                        trailing: ValueListenableBuilder(
                          valueListenable: model.showBalance,
                          builder: (context, show, _) => CupertinoSwitch(
                              value: show,
                              onChanged: (v) => {
                                    model.showBalance.value = v,
                                    model.updateUser()
                                  }),
                        )),
                    ProfileListItem(
                        title: "Change Pin",
                        icon: "p_change_pin",
                        onTap: () => Navigator.pushNamed(
                            context, Routes.changePinRoute)),
                    ProfileListItem(
                        title: "Enable Face ID",
                        icon: "p_face_id",
                        onTap: () {},
                        trailing: ValueListenableBuilder(
                          valueListenable: faceId,
                          builder: (context, show, _) => CupertinoSwitch(
                              value: show, onChanged: (v) => faceId.value = v),
                        )),
                  ],
                ),
              ),
              24.sbH,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Others",
                  style: AppTextStyle.headingHeading3
                      .copyWith(color: AppColors.bgContrast),
                ),
              ),
              8.sbH,
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    ProfileListItem(
                        title: "Help & Support",
                        icon: "p_support",
                        onTap: () => Navigator.pushNamed(
                            context, Routes.helpAndSupportPageRoute)),
                    ProfileListItem(
                        title: "About Mxe", icon: "p_about", onTap: () {}),
                    ProfileListItem(
                        title: "Close Account",
                        icon: "p_close_account",
                        onTap: () => Navigator.pushNamed(
                            context, Routes.closeAccountPageRoute)),
                  ],
                ),
              ),
              24.sbH,
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textLight,
                    ),
                    children: [
                      TextSpan(
                        text: "Read our ",
                        style: GoogleFonts.plusJakartaSans(),
                      ),
                      TextSpan(
                        text: 'Terms of Service',
                        style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w400,
                            color: AppColors.moderateBlue),
                      ),
                      TextSpan(
                        text: ' and ',
                        style: GoogleFonts.plusJakartaSans(),
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w400,
                            color: AppColors.moderateBlue),
                      ),
                    ],
                  ),
                ),
              ),
              24.sbH,
              InkWell(
                onTap: () => dualActionSheets(context,
                    title: "Logout",
                    subTitle:
                        "You are about to logout your account. Are you sure you want to logout?",
                    actionTitle: "Logout",
                    icon: "logout-white".svg,
                    onTap: () => Navigator.pop(context)),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.border, width: 2)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Logout",
                        style: AppTextStyle.labelMdBold
                            .copyWith(color: AppColors.errorCode),
                      ),
                      2.sbW,
                      SvgPicture.asset('logout'.svg),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileListItem extends StatelessWidget {
  final String title;
  final String icon;
  final Function()? onTap;
  final Widget? trailing;
  const ProfileListItem(
      {super.key,
      required this.title,
      required this.icon,
      this.onTap,
      this.trailing});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            SvgPicture.asset(icon.svg),
            16.sbW,
            Text(
              title,
              style: AppTextStyle.labelMdRegular
                  .copyWith(color: AppColors.bgContrast),
            ),
            Spacer(),
            trailing ?? SvgPicture.asset("chevron-right".svg),
          ],
        ),
      ),
    );
  }
}

class FrameWidget extends StatelessWidget {
  final Widget? child;
  const FrameWidget({super.key, this.child});
  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator FrameWidget - FRAME
    return Container(
        width: double.infinity,
        height: 250,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment(-0.5182339549064636, -0.19736452400684357),
              end: Alignment(0.19736452400684357, -0.19326947629451752),
              colors: [
                Color.fromRGBO(14, 35, 101, 1),
                Color.fromRGBO(68, 165, 253, 1)
              ]),
        ),
        child: Stack(children: <Widget>[
          Positioned(
              top: 30,
              left: -5,
              child: SvgPicture.asset(
                'assets/images/vv.svg',
                semanticsLabel: 'vector',
                fit: BoxFit.fill,
              )),
          Align(alignment: Alignment.bottomLeft, child: child),
        ]));
  }
}
