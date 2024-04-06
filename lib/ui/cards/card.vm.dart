import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mxe_mobile/base.vm.dart';
import 'package:mxe_mobile/core/model/request/card-request.dart';
import 'package:mxe_mobile/core/model/res_model.dart';
import 'package:mxe_mobile/core/services/auth-repository.dart';
import 'package:mxe_mobile/core/services/web-services/transactions-api-service.dart';
import 'package:mxe_mobile/locator.dart';
import 'package:mxe_mobile/widgets/select-currency-bottomsheet.dart';
import 'package:mxe_mobile/widgets/toast.dart';

class CardViewModel extends BaseViewModel {
  final transactionsApi = getIt<TransactionsApiService>();
  CreateCardReq? request;
  ValueNotifier<Color> color = ValueNotifier(const Color(0xff0D0D0D));

  ///create card values
  String? cardName;
  Color? selectedColor;

  TextEditingController amountController = TextEditingController();

  setCardName(String v) {
    cardName = v;
    notifyListeners();
  }

  ///for funding virtual card
  num amount = 0;
  Currency? fundingSource;

  setAmount(String v) {
    amount = num.tryParse(v) ?? 0;
    notifyListeners();
  }

  setSource(Currency v) {
    fundingSource = v;
    notifyListeners();
  }

  bool get isValidInputs => amount != 0 && fundingSource != null;

  ///
  ///
  getCards() async {
    //kill the  keyboard
    dropKeyboard();
    //change  viewState to show  loading indicator
    startLoader();
    //initialize an object to pass sign up data
    //create the  api req for login

    try {
      ResModel res = await transactionsApi.getCards();

      if (res.isSuccess) {
        stopLoader();
        notifyListeners();
        return;
      } else {
        //update viewState
        stopLoader();
        //show error message if any
        showCustomToast(res.message!);
      }
    } catch (e) {
      print(e.toString());
      stopLoader();
      //show error message if any
      showCustomToast(genericErrorMessage);
    }
  }

  freezeCard({bool pop = true}) async {
    //kill the  keyboard
    dropKeyboard();
    //change  viewState to show  loading indicator
    startLoader();
    //initialize an object to pass sign up data
    //create the  api req for login

    try {
      ResModel res = await transactionsApi.freezeCard();

      if (res.isSuccess) {
        await getCards();
        stopLoader();
        if (pop) {
          navigationService.goBack();
        }
        notifyListeners();
        return;
      } else {
        //update viewState
        stopLoader();
        //show error message if any
        showCustomToast(res.message!);
      }
    } catch (e) {
      print(e.toString());
      stopLoader();
      //show error message if any
      showCustomToast(genericErrorMessage);
    }
  }

  createCard() async {
    //kill the  keyboard
    dropKeyboard();
    //change  viewState to show  loading indicator
    startLoader();
    //initialize an object to pass sign up data
    //create the  api req for login

    try {
      ResModel res = await transactionsApi.createCard(
        request: CreateCardReq(
            nameOnCard: cardName,
            cardColor: color.value.value.toString(),
            design: colors.indexOf(color.value).toString(),
            userId: await getIt<AuthenticationRepository>().getUserId()),
      );

      if (res.isSuccess) {
        stopLoader();

        return;
      } else {
        //update viewState
        stopLoader();
        //show error message if any
        showCustomToast(res.message!);
      }
    } catch (e) {
      print(e.toString());
      stopLoader();
      //show error message if any
      showCustomToast(genericErrorMessage);
    }
  }

  List<Color> colors = [
    const Color(0xff0D0D0D),
    const Color(0xff7257FF),
    const Color(0xffF82B60),
    const Color(0xffFF08C2),
    const Color(0xff7752C4),
    const Color(0xff0680EE),
    const Color(0xffE6BF00),
    const Color(0xff2C4866),
    const Color(0xff30B651)
  ];
}
