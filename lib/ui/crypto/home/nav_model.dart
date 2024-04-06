import 'package:mxe_mobile/utils/string-extensions.dart';

class NavigationModel {
  const NavigationModel(this.index, this.title, this.icon, this.activeIcon);
  final int index;
  final String title;
  final String icon;
  final String activeIcon;
}

List<NavigationModel> cryptoNavigationModel = <NavigationModel>[
  NavigationModel(0, 'Home', "home".svg, "home-a".svg),
  NavigationModel(1, 'Trade', "trade".svg, "trade-a".svg),
  NavigationModel(2, 'Portfolio', "portfolio".svg, "portfolio-a".svg),
];
