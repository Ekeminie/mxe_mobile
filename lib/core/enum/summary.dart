enum SummaryType {
  deposit(title: "DEPOSIT"),
  withdraw(title: "WITHDRAW");

  final String? title;
  const SummaryType({this.title});
}

enum SummaryTime {
  year(title: "Year"),
  month(title: "Month");

  final String? title;
  const SummaryTime({this.title});
}
