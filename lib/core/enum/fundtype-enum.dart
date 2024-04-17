import 'package:mxe_mobile/constant/constants.dart';

enum FundType {
  cardPayment(
      title: "Pay with your card",
      desc: "You can fund your account with your debit card.",
      icon: 'card-payment',
      supportIcon: 'card-support',
      code: "Card"),
  bankTransfer(
      title: "Bank Transfer",
      desc:
          "Fund your account by making a local bank transfer to a dedicated account number",
      icon: 'transfer-payment',
      code: "Bank",
      hasSupport: false),
  deFi(
      title: "DeFi",
      desc: "Fund your account with our secure decentralized finance option.",
      icon: 'defi-payment',
      supportIcon: 'defi-support',
      code: "DeFi");

  final String? title;
  final String? desc;
  final String? icon;
  final bool? hasSupport;
  final String? supportIcon;
  final String? code;
  const FundType(
      {this.title,
      this.desc,
      this.icon,
      this.hasSupport = true,
      this.supportIcon,
      this.code});
}

enum VCFundSource {
  cardPayment(
      title: "Pay with your card",
      desc: "You can fund your account with your debit card.",
      icon: 'card-payment',
      supportIcon: 'card-support',
      code: "Card"),
  bankTransfer(
      title: "Bank Transfer",
      desc:
          "Fund your account by making a local bank transfer to a dedicated account number",
      icon: 'transfer-payment',
      code: "Bank",
      hasSupport: false),
  deFi(
      title: "DeFi",
      desc: "Fund your account with our secure decentralized finance option.",
      icon: 'defi-payment',
      supportIcon: 'defi-support',
      code: "DeFi");

  final String? title;
  final String? desc;
  final String? icon;
  final bool? hasSupport;
  final String? supportIcon;
  final String? code;
  const VCFundSource(
      {this.title,
      this.desc,
      this.icon,
      this.hasSupport = true,
      this.supportIcon,
      this.code});
}

enum SendFundType {
  mxeTag(
      title: "Send using MXE Tag",
      desc: "Send money using the MXE unique identifier tag",
      icon: 'send-mxe',
      code: "Mxe Tag"),
  bankTransfer(
      title: "Bank Transfer",
      desc:
          "FFund your account by making a local bank transfer to a dedicated account number.",
      icon: 'send-bank-tf',
      code: "Bank Transfer");

  final String? title;
  final String? desc;
  final String? icon;
  final bool? hasSupport;
  final String? supportIcon;
  final String? code;
  const SendFundType(
      {this.title,
      this.desc,
      this.icon,
      this.hasSupport = false,
      this.supportIcon,
      this.code});
}

//enum TransferCurrency
enum TransferCurrency {
  ngn(title: "Nigerian Naira", icon: 'send-ngn', code: "NGN"),
  usd(title: "United States Dollars", icon: 'send-usd', code: "USD"),
  gbp(title: "Nigerian Naira", icon: 'send-gbp', code: "GBP"),
  cad(title: "Canadian Dollar", icon: 'send-cad', code: "CAD"),
  zar(title: "South African Rand", icon: 'send-zar', code: "ZAR");

  final String? title;
  final String? icon;
  final String? code;
  const TransferCurrency({this.title, this.icon, this.code});
}

enum GiftCardCurrencyEnum {
  ngn(title: "United Kingdom", icon: 'uk', code: "GBP", symbol: "£"),
  usd(title: "United States", icon: 'us', code: "USD", symbol: "\$"),
  gbp(title: "Nigerian Naira", icon: 'ngn', code: "NGN", symbol: nairaSign);

  final String? title;
  final String? icon;
  final String? code;
  final String? symbol;
  const GiftCardCurrencyEnum({this.title, this.icon, this.code, this.symbol});
}
