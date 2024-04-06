enum AccountType {
  regular(
    title: "Regular",
  ),
  halal(title: "Halal");

  final String? title;
  const AccountType({this.title});
}

enum PaymentType {
  singlePayment(
    name: "One Time Payment",
  ),
  recurring(name: "Recurring Payment"),
  none();

  final String? name;
  const PaymentType({this.name});
}

enum PaymentSource {
  cashAccount(
    name: "Cash Account",
  ),
  paymentGateway(name: "Payment Gateway"),
  none();

  final String? name;
  const PaymentSource({this.name});
}

enum PaymentDestination {
  cashAccount(
    name: "Cash Account",
  ),
  paymentGateway(name: "Primary Account"),
  none();

  final String? name;
  const PaymentDestination({this.name});
}

enum InvestmentAccountType {
  cashAccount(
    title: "Cash Account",
  ),
  investmentAccount(title: "Invest Account");

  final String? title;
  const InvestmentAccountType({this.title});
}
