import 'package:mxe_mobile/core/services/navigation_service.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/routes/routes.dart';

softLogout() {
  getIt<NavigationService>().navigateToAndRemoveUntil(Routes.loginRoute);
  return;
}
