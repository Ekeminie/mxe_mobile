class RequestFunds {
  String? senderId;
  String? receiverMxeTag;
  num? amount;

//<editor-fold desc="Data Methods">
  RequestFunds({
    this.senderId,
    this.receiverMxeTag,
    this.amount,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RequestFunds &&
          runtimeType == other.runtimeType &&
          senderId == other.senderId &&
          receiverMxeTag == other.receiverMxeTag &&
          amount == other.amount);

  @override
  int get hashCode =>
      senderId.hashCode ^ receiverMxeTag.hashCode ^ amount.hashCode;

  @override
  String toString() {
    return 'RequestFunds{ senderId: $senderId, receiverMxeTag: $receiverMxeTag, amount: $amount,}';
  }

  RequestFunds copyWith({
    String? senderId,
    String? receiverMxeTag,
    num? amount,
  }) {
    return RequestFunds(
      senderId: senderId ?? this.senderId,
      receiverMxeTag: receiverMxeTag ?? this.receiverMxeTag,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverMxeTag': receiverMxeTag,
      'amount': amount,
    };
  }

  factory RequestFunds.fromMap(Map<String, dynamic> map) {
    return RequestFunds(
      senderId: map['senderId'] as String,
      receiverMxeTag: map['receiverMxeTag'] as String,
      amount: map['amount'] as num,
    );
  }

//</editor-fold>
}
