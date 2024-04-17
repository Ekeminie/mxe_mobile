import 'package:mxe_mobile/base.vm.dart';

class BackUpCryptoViewModel extends BaseViewModel {
  List<bool?> answers = [null, null, null];

  setAnswers(bool v, int index) {
    answers[index] = v;
    notifyListeners();
  }
}
