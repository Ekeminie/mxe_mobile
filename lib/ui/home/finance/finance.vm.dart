import 'package:flutter/foundation.dart';
import 'package:mxe_mobile/base.vm.dart';
import 'package:mxe_mobile/core/model/res_model.dart';
import 'package:mxe_mobile/core/services/web-services/user-api-service.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/widgets/toast.dart';

class FinanceViewModel extends BaseViewModel {
  ValueNotifier<bool> show = ValueNotifier(true);
  final userApi = getIt<UserApiService>();
  init() {
    show.value =
        userService.userCredentials.value.displayWalletBalance ?? false;
    notifyListeners();
  }

  updateUser() async {
    dropKeyboard();
    startLoader();

    try {
      ResModel res = await userApi.updateUser(user: {
        "displayWalletBalance": show.value,
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
