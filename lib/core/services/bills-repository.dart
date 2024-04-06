import 'package:mxe_mobile/core/enum/bills-enum.dart';

class BillsRepository {
  String? phone;
  num amount = 0;
  String? beneficiaryName;
  bool? saveBeneficiary;
  bool? schedulePayment;
  NetworkProviderEnum? networkProvider;
  ElectricityProviderEnum? electricityProviderEnum;
  BettingProviderEnum? bettingProvider;
  CableProviderEnum? cableProvider;
  String? meterNo;
  String? betUserID;
  String? smartCardNo;
}
