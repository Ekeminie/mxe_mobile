import 'package:flutter/cupertino.dart';
import 'package:mxe_mobile/base.vm.dart';
import 'package:mxe_mobile/core/model/res_model.dart';
import 'package:mxe_mobile/core/services/web-services/user-api-service.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/widgets/toast.dart';

class NotificationViewModel extends BaseViewModel {
  ValueNotifier<bool> pushNotification = ValueNotifier(false);
  ValueNotifier<bool> sms = ValueNotifier(false);
  ValueNotifier<bool> email = ValueNotifier(false);

  final userApi = getIt<UserApiService>();

  init() {
    pushNotification.value =
        userService.userCredentials.value.allowPushNotifications ?? false;
    sms.value =
        userService.userCredentials.value.allowSmsNotifications ?? false;
    email.value =
        userService.userCredentials.value.allowEmailNotifications ?? false;
    notifyListeners();
  }

  updateUser() async {
    dropKeyboard();
    startLoader();

    try {
      ResModel res = await userApi.updateUser(user: {
        "allowPushNotifications": pushNotification.value,
        "allowSmsNotifications": sms.value,
        "allowEmailNotifications": email.value,
      });
      if (res.success ?? false) {
        await userApi.getUser();
        init();
        stopLoader();
        showCustomToast("Updated", success: true);
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
