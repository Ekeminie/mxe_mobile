import 'package:mxe_mobile/base.vm.dart';
import 'package:mxe_mobile/routes/routes.dart';
import 'package:mxe_mobile/utils/string-extensions.dart';

class SavedCardViewModel extends BaseViewModel {
  bool get hasName => cardName.isNotNullNorEmpty && cardName!.trim().length > 3;
  bool get hasNo => cardNo.isNotNullNorEmpty && cardNo!.trim().length > 9;
  bool get hasCvv => cvv.isNotNullNorEmpty && cvv!.trim().length == 3;
  bool get hasExpiry => expiry.isNotNullNorEmpty && expiry!.trim().length > 3;
  bool get hasValidInputs => hasName && hasNo && hasExpiry && hasCvv;
  bool get hasReference =>
      reference.isNotNullNorEmpty && reference!.length >= 2;

  String? cardName;
  String? cardNo;
  String? expiry;
  String? cvv;
  String? reference;
  String? deleteText;

  setDeleteText(String v) {
    error = null;
    deleteText = v;
    notifyListeners();
  }

  bool get isDeleteText =>
      deleteText.isNotNullNorEmpty && deleteText == "DELETE";

  String? error;
  checkDeletionText() {
    if (isDeleteText) {
      navigationService.navigateToReplace(Routes.closeAccountSuccessPageRoute);
    } else {
      error = " ";
      notifyListeners();
    }
  }

  setName(String v) {
    cardName = v;
    notifyListeners();
  }

  setReference(String v) {
    reference = v;
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
