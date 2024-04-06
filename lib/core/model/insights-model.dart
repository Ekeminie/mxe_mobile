class InsightAndStatsModel {
  int? income;
  int? billPayments;
  int? withdrawals;

  InsightAndStatsModel({this.income, this.billPayments, this.withdrawals});

  InsightAndStatsModel.fromJson(Map<String, dynamic> json) {
    income = json['income'];
    billPayments = json['bill_payments'];
    withdrawals = json['Withdrawals'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['income'] = income;
    data['bill_payments'] = billPayments;
    data['Withdrawals'] = withdrawals;
    return data;
  }
}
