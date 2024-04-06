import 'package:mxe_mobile/base.vm.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';

class AddCardViewModel extends BaseViewModel {
  bool get hasName => cardName.isNotNullNorEmpty && cardName!.trim().length > 3;
  bool get hasNo => cardNo.isNotNullNorEmpty && cardNo!.trim().length > 9;
  bool get hasCvv => cvv.isNotNullNorEmpty && cvv!.trim().length == 3;
  bool get hasExpiry => expiry.isNotNullNorEmpty && expiry!.trim().length > 3;
  bool get hasValidInputs => hasName && hasNo && hasExpiry && hasCvv;

  String? cardName;
  String? cardNo;
  String? expiry;
  String? cvv;

  setName(String v) {
    cardName = v;
    notifyListeners();
  }

  setNo(String v) {
    cardNo = v;
    notifyListeners();
  }

  setCVV(String v) {
    cvv = v;
    notifyListeners();
  }

  setExpiry(String v) {
    expiry = v;
    notifyListeners();
  }
}
