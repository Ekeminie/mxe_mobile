class MxeTagWithdrawalRequest {
  String? mxetag;
  String? userId;
  String? transactionPin;
  num? amount;

  MxeTagWithdrawalRequest({
    this.mxetag,
    this.userId,
    this.transactionPin,
    this.amount,
  });

  factory MxeTagWithdrawalRequest.fromJson(Map<String, dynamic> json) {
    return MxeTagWithdrawalRequest(
      mxetag: json['Mxetag'],
      userId: json['userId'],
      transactionPin: json['transactionPin'],
      amount: json['amount'],
    );
  }

  MxeTagWithdrawalRequest copyWith({
    String? mxetag,
    String? userId,
    String? transactionPin,
    int? amount,
  }) {
    return MxeTagWithdrawalRequest(
      mxetag: mxetag ?? this.mxetag,
      userId: userId ?? this.userId,
      transactionPin: transactionPin ?? this.transactionPin,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Mxetag': mxetag,
      'userId': userId,
      'transactionPin': transactionPin,
      'amount': amount,
    };
  }

  @override
  String toString() {
    return 'MxetagTransactionInfo{Mxetag: $mxetag, userId: $userId, transactionPin: $transactionPin, amount: $amount}';
  }
}
