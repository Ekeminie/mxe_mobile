enum BankList {
  access(title: "Access Bank"),
  barclays(title: "Barclays Bank"),
  citiBank(title: "Citi Bank"),
  standardChatteredBank(title: "Standard Charttered Bank"),
  bankOfAmerica(title: "Bank of America"),
  wallStreetBanks(title: "Wall Street Bank");

  final String? title;
  const BankList({
    this.title,
  });
}
