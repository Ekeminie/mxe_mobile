import 'package:mxe_mobile/core/enum/fundtype-enum.dart';
import 'package:mxe_mobile/ui/bills/bills-beneficiaries/bills-beneficiaries.ui.dart';

class TransferRepository {
  TransferCurrency? sendCurrency;
  num amount = 0;
  bool get isLocalTransfer => sendCurrency == TransferCurrency.ngn;

  ///Conversion Variables
  TransferCurrency? toCurrency;
  TransferCurrency? fromCurrency;
  String? convertedAmount;

  ///request values
  SingleBeneficiary? requestBeneficiary;
  String? requestBeneficiaryUserName;
}
