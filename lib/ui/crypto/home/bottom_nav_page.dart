import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mxe_mobile/base.ui.dart';
import 'package:mxe_mobile/core/styles/color-styles.dart';
import 'package:mxe_mobile/ui/cards/card.ui.dart';
import 'package:mxe_mobile/ui/crypto/home/home-tab.ui.dart';
import 'package:mxe_mobile/ui/crypto/home/home.vm.dart';
import 'package:mxe_mobile/ui/crypto/home/nav_model.dart';
import 'package:mxe_mobile/ui/profile/profile.ui.dart';
import 'package:mxe_mobile/utils/widget_extensions.dart';
import 'package:visibility_detector/visibility_detector.dart';

class CryptoBottomNavPage extends StatefulWidget {
  final bool? initializeData;
  const CryptoBottomNavPage({Key? key, this.initializeData = true})
      : super(key: key);

  @override
  _CryptoBottomNavPageState createState() => _CryptoBottomNavPageState();
}

class _CryptoBottomNavPageState extends State<CryptoBottomNavPage> {
  DateTime preBackPress = DateTime.now();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<CryptoHomeViewModel>(
      onModelReady: (m) async => {
        widget.initializeData! ? () {} : null,
      },
      builder: (context, model, child) => PopScope(
        canPop: !Loader.isShown,
        child: VisibilityDetector(
          key: const Key('main'),
          onVisibilityChanged: (visibilityInfo) {
            if (visibilityInfo.visibleFraction == 1) {
              // model.refresh();
            }
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: AppColors.bgColor,
            bottomNavigationBar: BottomAppBar(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: cryptoNavigationModel
                        .map(
                          (e) => InkWell(
                            highlightColor: Colors.transparent,
                            splashFactory: NoSplash.splashFactory,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  e.index == model.selectedIndex
                                      ? e.activeIcon
                                      : e.icon,
                                ),
                                4.0.sbH,
                                Text(
                                  e.title,
                                  style: TextStyle(
                                      color: e.index == model.selectedIndex
                                          ? AppColors.moderateBlue
                                          : AppColors.textLight,
                                      fontSize: 12,
                                      fontWeight: e.index == model.selectedIndex
                                          ? FontWeight.bold
                                          : FontWeight.w500),
                                )
                              ],
                            ),
                            onTap: () => model.onItemTapped(
                              e.index,
                            ),
                          ),
                        )
                        .toList()),
              ),
            ),
            body: Container(
              child: <Widget>[
                const CryptoHomePage(),
                const CardPage(),
                const ProfilePage(),
              ].elementAt(model.selectedIndex),
            ),
          ),
        ),
      ),
    );
  }
}
