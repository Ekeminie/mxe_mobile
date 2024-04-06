import 'package:flutter/foundation.dart';
import 'package:mxe_mobile/base.vm.dart';
import 'package:mxe_mobile/core/enum/status-enum.dart';
import 'package:mxe_mobile/core/model/notification-reponse.dart';
import 'package:mxe_mobile/core/services/web-services/user-api-service.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/widgets/toast.dart';

class NotificationsViewModel extends BaseViewModel {
  ValueNotifier<List<NotificationModel>> notifications = ValueNotifier([]);
  final userApi = getIt<UserApiService>();
  ValueNotifier<InsightsTimeLineEnum> timeline =
      ValueNotifier(InsightsTimeLineEnum.sevenDays);

  getNotifications() async {
    dropKeyboard();
    startLoader();

    try {
      NotificationResponse res = await userApi.getNotifications();
      if (res.success ?? false) {
        stopLoader();
        notifications.value = res.data ?? [];
        return;
      } else {
        //update viewState
        stopLoader();
        //show error message if any
        showCustomToast(res.message!);
      }
    } catch (e) {
      debugPrint(e.toString());
      stopLoader();
      //show error message if any
      showCustomToast(genericErrorMessage);
    }
  }
}
