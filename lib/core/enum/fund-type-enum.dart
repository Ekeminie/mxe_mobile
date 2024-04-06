enum FundTypeEnum {
  none(title: ""),
  wallet(title: "WALLET", value: 0),
  paymentgateway(title: "PAYMENTGATEWAY", value: 1);

  final String? title;
  final num? value;
  const FundTypeEnum({this.title, this.value});
}

enum PaymentTypeEnum {
  recurringPayment(title: "Recurring Payment", value: 0),
  oneTimePayment(title: "One Time Payment", value: 1);

  final String? title;
  final num? value;
  const PaymentTypeEnum({this.title, this.value});
}
