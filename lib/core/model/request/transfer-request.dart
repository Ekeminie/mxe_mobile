class SendMoneyRequest {
  String? bankName;
  String? userId;
  String? bankCode;
  String? accountNumber;
  String? transactionPin;
  num? amount;

  SendMoneyRequest({
    this.bankName,
    this.userId,
    this.bankCode,
    this.accountNumber,
    this.transactionPin,
    this.amount,
  });

  factory SendMoneyRequest.fromJson(Map<String, dynamic> json) {
    return SendMoneyRequest(
      bankName: json['bankName'],
      userId: json['userId'],
      bankCode: json['bankCode'],
      accountNumber: json['accountNumber'],
      transactionPin: json['transactionPin'],
      amount: json['amount'],
    );
  }

  SendMoneyRequest copyWith({
    String? bankName,
    String? userId,
    String? bankCode,
    String? accountNumber,
    String? transactionPin,
    int? amount,
  }) {
    return SendMoneyRequest(
      bankName: bankName ?? this.bankName,
      userId: userId ?? this.userId,
      bankCode: bankCode ?? this.bankCode,
      accountNumber: accountNumber ?? this.accountNumber,
      transactionPin: transactionPin ?? this.transactionPin,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bankName': bankName,
      'userId': userId,
      'bankCode': bankCode,
      'accountNumber': accountNumber,
      'transactionPin': transactionPin,
      'amount': amount,
    };
  }

  @override
  String toString() {
    return 'BankTransactionInfo{bankName: $bankName, userId: $userId, bankCode: $bankCode, accountNumber: $accountNumber, transactionPin: $transactionPin, amount: $amount}';
  }
}
