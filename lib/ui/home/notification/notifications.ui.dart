import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/ui/home/notification/notification.vm.dart';
import 'package:mxe_mobile/ui/home/notification/notificationListItem.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/appbar.dart';

class NotificationsTabPage extends StatefulWidget {
  const NotificationsTabPage({Key? key}) : super(key: key);

  @override
  State<NotificationsTabPage> createState() => _NotificationsTabPageState();
}

class _NotificationsTabPageState extends State<NotificationsTabPage> {
  bool empty = false;
  @override
  Widget build(BuildContext context) {
    return BaseView<NotificationsViewModel>(
      onModelReady: (m) => m.getNotifications(),
      builder: (context, model, child) => DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: customAppBar(
              "",
            ),
            body: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: AutoSizeText(
                      "Notifications",
                      style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 24.sp,
                          color: AppColors.bgContrast),
                    ),
                  ),
                ),
                28.sbH,
                TabBar(
                  enableFeedback: false,
                  automaticIndicatorColorAdjustment: false,
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: MaterialStateProperty.resolveWith(
                    (Set states) {
                      return states.contains(MaterialState.focused)
                          ? null
                          : Colors.transparent;
                    },
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  indicatorPadding: const EdgeInsets.all(2),
                  labelPadding: EdgeInsets.zero,
                  labelColor: AppColors.moderateBlue,
                  unselectedLabelColor: AppColors.textLight,
                  tabs: [
                    Tab(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        child: const SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'All',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        child: const SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              'Requests',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      ValueListenableBuilder(
                        valueListenable: model.notifications,
                        builder: (context, notification, _) =>
                            NotificationsListPage(
                          key: const Key('all'),
                          list: notification,
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: model.notifications,
                        builder: (context, notification, _) =>
                            NotificationsListPage(
                                key: const Key('requests'),
                                title: 'requests',
                                list: notification
                                    .where(
                                        (e) => e.transactionType == 'request')
                                    .toList()
                                // const [
                                //         NotificationsType.fundRequest,
                                //         NotificationsType.declineRequest,
                                //         NotificationsType.acceptRequest,
                                //       ],
                                ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
