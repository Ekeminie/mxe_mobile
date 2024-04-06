import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/core/styles/textstyles.dart';
import 'package:mxe_mobile/ui/profile/notification/notification-vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';
import 'package:mxe_mobile/widgets/header-widget.dart';

class NotificationPreferencePage1 extends StatefulWidget {
  const NotificationPreferencePage1({Key? key}) : super(key: key);

  @override
  State<NotificationPreferencePage1> createState() =>
      _NotificationPreferencePageState();
}

class _NotificationPreferencePageState
    extends State<NotificationPreferencePage1> {
  @override
  Widget build(BuildContext context) {
    return BaseView<NotificationViewModel>(
      onModelReady: (m) => m.init(),
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.bgColor,
        appBar: customAppBar("", bgColor: AppColors.bgColor),
        body: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header("Notification Preferences"),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    38.sbH,
                    32.sbH,
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Row(
                                children: [
                                  SvgPicture.asset('notification_email'.svg),
                                  16.sbW,
                                  Text(
                                    "Email Notification",
                                    style: AppTextStyle.labelMdRegular
                                        .copyWith(color: AppColors.bgContrast),
                                  ),
                                  const Spacer(),
                                  ValueListenableBuilder(
                                    valueListenable: model.email,
                                    builder: (context, show, _) =>
                                        CupertinoSwitch(
                                            value: show,
                                            onChanged: (v) => {
                                                  model.email.value = v,
                                                  model.updateUser()
                                                }),
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Row(
                                children: [
                                  SvgPicture.asset('notification_sms'.svg),
                                  16.sbW,
                                  Text(
                                    "SMS Notification",
                                    style: AppTextStyle.labelMdRegular
                                        .copyWith(color: AppColors.bgContrast),
                                  ),
                                  const Spacer(),
                                  ValueListenableBuilder(
                                    valueListenable: model.sms,
                                    builder: (context, show, _) =>
                                        CupertinoSwitch(
                                            value: show,
                                            onChanged: (v) => {
                                                  model.sms.value = v,
                                                  model.updateUser()
                                                }),
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                      'notification_push_notification'.svg),
                                  16.sbW,
                                  Text(
                                    "Push Notification",
                                    style: AppTextStyle.labelMdRegular
                                        .copyWith(color: AppColors.bgContrast),
                                  ),
                                  const Spacer(),
                                  ValueListenableBuilder(
                                    valueListenable: model.pushNotification,
                                    builder: (context, show, _) =>
                                        CupertinoSwitch(
                                            value: show,
                                            onChanged: (v) => {
                                                  model.pushNotification.value =
                                                      v,
                                                  model.updateUser()
                                                }),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    16.sbH,
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
