import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart' hide Badge;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/ui/crypto/home/home-tab.vm.dart';
import 'package:mxe_mobile/ui/crypto/home/wallet/wallet.ui.dart';
import 'package:mxe_mobile/ui/home/finance/finance.ui.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:mxe_mobile/widgets/statefull-wrapper.dart';
import 'package:visibility_detector/visibility_detector.dart';

class CryptoHomePage extends StatefulWidget {
  final Function()? function;
  const CryptoHomePage({Key? key, this.function}) : super(key: key);

  @override
  _CryptoHomePageState createState() => _CryptoHomePageState();
}

class _CryptoHomePageState extends State<CryptoHomePage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<CryptoHomeTabViewModel>(
      // useTouchListener: false,
      onModelReady: (m) => {_tabController.animateTo(m.selectedIndex)},
      builder: (context, model, child) => StatefulWrapper(
        onInit: () {
          _tabController.addListener(() {
            _smoothScrollToTop();
            model.onItemTapped(_tabController.index);
          });

          // _tabController.
        },
        child: VisibilityDetector(
          key: const Key('home-ui'),
          onVisibilityChanged: (visibilityInfo) {
            if (visibilityInfo.visibleFraction == 1) {
              model.checkIndexCache();
              _tabController.animateTo(model.selectedIndex);
            }
          },
          child: DefaultTabController(
              length: 2,
              child: Scaffold(
                  backgroundColor: AppColors.bgColor,
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    elevation: 0,
                    backgroundColor: AppColors.bgColor,
                    leading: Row(
                      children: [
                        14.sbW,
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.cryptoNavDrawerRoute);
                          },
                          child: SvgPicture.asset('menu-icon'.svg),
                        ),
                      ],
                    ),
                    title: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: SizedBox(
                        height: 35,
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color(0xffF5F5F7),
                              border:
                                  Border.all(color: const Color(0xffD9D9D8)),
                              borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 0),
                          child: TabBar(
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
                            controller: _tabController,
                            indicatorWeight: 0,
                            indicatorSize: TabBarIndicatorSize.tab,
                            padding: const EdgeInsets.symmetric(
                                vertical: 1, horizontal: 4),
                            indicatorPadding: EdgeInsets.zero,
                            labelPadding: EdgeInsets.zero,
                            onTap: (index) => model.onItemTapped(index),
                            indicator: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(8.0)),
                            labelColor: AppColors.bgContrast,
                            unselectedLabelColor: AppColors.textLight,
                            tabs: [
                              Tab(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 4.h),
                                  child: AutoSizeText(
                                    'Finance',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                              Tab(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6.w, vertical: 2.h),
                                  child: AutoSizeText(
                                    'Wallet',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    actions: [
                      InkWell(
                        onTap: () => Navigator.pushNamed(
                            context, Routes.cryptoNotificationsPageRoute),
                        child: SvgPicture.asset('notification-icon'.svg),
                      ),
                      14.sbW
                    ],
                  ),
                  body: NestedScrollView(
                    controller: _scrollController,
                    body: TabBarView(
                      controller: _tabController,
                      children: const [FinancePage(), CryptoWalletPage()],
                    ),
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return [
                        const SliverToBoxAdapter(
                          child: Text(""),
                        )
                      ];
                    },
                  ))),
        ),
      ),
    );
  }

  late TabController _tabController;
  late ScrollController _scrollController;
  bool fixedScroll = false;

  _scrollListener() {
    if (fixedScroll) {
      _scrollController.jumpTo(0);
    }
  }

  _smoothScrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(microseconds: 300),
      curve: Curves.ease,
    );

    setState(() {
      fixedScroll = _tabController.index == 2;
    });
  }
}
