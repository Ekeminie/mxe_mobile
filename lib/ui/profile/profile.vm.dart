import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:mxe_mobile/base.vm.dart';
import 'package:mxe_mobile/core/model/res_model.dart';
import 'package:mxe_mobile/core/services/web-services/upload-api.dart';
import 'package:mxe_mobile/core/services/web-services/user-api-service.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/utils/string%20utils.dart';
import 'package:mxe_mobile/widgets/toast.dart';

class ProfileViewModel extends BaseViewModel {
  ValueNotifier<bool> showBalance = ValueNotifier(false);

  final userApi = getIt<UserApiService>();
  final uploadApi = getIt<UploadApiService>();

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  ValueNotifier<File> imageFile = ValueNotifier(File(""));

  editProfileInitialization() {
    emailController.text = userService.userCredentials.value.email ?? "";
    phoneNumberController.text =
        userService.userCredentials.value.phoneNumber ?? "";
  }

  init() {
    showBalance.value =
        userService.userCredentials.value.displayWalletBalance ?? false;
    notifyListeners();
  }

  updateUser() async {
    dropKeyboard();
    startLoader();

    try {
      ResModel res = await userApi.updateUser(user: {
        "displayWalletBalance": showBalance.value,
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

  uploadPhoto({File? file}) async {
    dropKeyboard();
    startLoader();
    print(file?.path);
    try {
      ResModel res = await uploadApi.uploadFile(
          data: await getFormData(name: "file", data: file?.path));
      if (res.success ?? false) {
        await updatePhoto(url: res.data[0]);
        stopLoader();
        return;
      } else {
        //update viewState
        stopLoader();
        //show error message if any
        showCustomToast(res.message!);
      }
    } catch (e) {
      printWrapped(e.toString());
      stopLoader();
      //show error message if any
      showCustomToast(genericErrorMessage);
    }
  }

  updatePhoto({String? url}) async {
    dropKeyboard();
    startLoader();

    try {
      ResModel res = await userApi.updateUser(user: {
        "profileImageUrl": url,
      });
      if (res.success ?? false) {
        await userApi.getUser();
        init();
        stopLoader();
        showCustomToast("Updated Profile Image", success: true);
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
