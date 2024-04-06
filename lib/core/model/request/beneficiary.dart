class WithdrawalBeneficiaryReq {
  String? userId;
  String? name;
  String? bankName;
  String? bankCode;
  String? accountNumber;

  WithdrawalBeneficiaryReq({
    this.userId,
    this.name,
    this.bankName,
    this.bankCode,
    this.accountNumber,
  });

  WithdrawalBeneficiaryReq.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        name = json['Name'],
        bankName = json['BankName'],
        bankCode = json['BankCode'],
        accountNumber = json['AccountNumber'];

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'Name': name,
        'BankName': bankName,
        'BankCode': bankCode,
        'AccountNumber': numAccount,
      };

  num get numAccount => num.tryParse(accountNumber ?? "") ?? 0;

  WithdrawalBeneficiaryReq copyWith({
    String? userId,
    String? name,
    String? bankName,
    String? bankCode,
    String? accountNumber,
  }) {
    return WithdrawalBeneficiaryReq(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      bankName: bankName ?? this.bankName,
      bankCode: bankCode ?? this.bankCode,
      accountNumber: accountNumber ?? this.accountNumber,
    );
  }

  @override
  String toString() {
    return 'WithdrawalBeneficiary{userId: $userId, name: $name, bankName: $bankName, bankCode: $bankCode, accountNumber: $accountNumber}';
  }
}
