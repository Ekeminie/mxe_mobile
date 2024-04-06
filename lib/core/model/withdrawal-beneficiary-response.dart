class WithdrawalBeneficiary {
  String? id;
  String? userId;
  String? name;
  String? bankName;
  String? bankCode;
  int? accountNumber;
  int? v;

  WithdrawalBeneficiary({
    this.id,
    this.userId,
    this.name,
    this.bankName,
    this.bankCode,
    this.accountNumber,
    this.v,
  });

  WithdrawalBeneficiary.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        userId = json['userId'],
        name = json['Name'],
        bankName = json['BankName'],
        bankCode = json['BankCode'],
        accountNumber = json['AccountNumber'],
        v = json['__v'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'userId': userId,
        'Name': name,
        'BankName': bankName,
        'BankCode': bankCode,
        'AccountNumber': accountNumber,
        '__v': v,
      };

  WithdrawalBeneficiary copyWith({
    String? id,
    String? userId,
    String? name,
    String? bankName,
    String? bankCode,
    int? accountNumber,
    int? v,
  }) {
    return WithdrawalBeneficiary(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      bankName: bankName ?? this.bankName,
      bankCode: bankCode ?? this.bankCode,
      accountNumber: accountNumber ?? this.accountNumber,
      v: v ?? this.v,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WithdrawalBeneficiary &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userId == other.userId &&
          name == other.name &&
          bankName == other.bankName &&
          bankCode == other.bankCode &&
          accountNumber == other.accountNumber &&
          v == other.v;

  @override
  int get hashCode =>
      id.hashCode ^
      userId.hashCode ^
      name.hashCode ^
      bankName.hashCode ^
      bankCode.hashCode ^
      accountNumber.hashCode ^
      v.hashCode;

  @override
  String toString() {
    return 'BankDetails{id: $id, userId: $userId, name: $name, bankName: $bankName, bankCode: $bankCode, accountNumber: $accountNumber, __v: $v}';
  }
}
