class BankModel {
  String? bankName;
  String? shortCode;
  String? bankCode;

  BankModel({this.bankName, this.shortCode, this.bankCode});

  BankModel.fromJson(Map<String, dynamic> json) {
    bankName = json['bank_name'];
    shortCode = json['short_code'];
    bankCode = json['bank_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bank_name'] = bankName;
    data['short_code'] = shortCode;
    data['bank_code'] = bankCode;
    return data;
  }

  @override
  String toString() {
    return 'BankModel{bankName: $bankName, shortCode: $shortCode, bankCode: $bankCode}';
  }
}
