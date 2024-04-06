class AirtimeAndDataBeneficiary {
  String? userId;
  String? name;
  String? provider;
  String? phoneNumber;

  AirtimeAndDataBeneficiary({
    this.userId,
    this.name,
    this.provider,
    this.phoneNumber,
  });

  factory AirtimeAndDataBeneficiary.fromJson(Map<String, dynamic> json) {
    return AirtimeAndDataBeneficiary(
      userId: json['userId'],
      name: json['Name'],
      provider: json['Provider'],
      phoneNumber: json['PhoneNumber'],
    );
  }

  AirtimeAndDataBeneficiary copyWith({
    String? userId,
    String? name,
    String? provider,
    String? phoneNumber,
  }) {
    return AirtimeAndDataBeneficiary(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      provider: provider ?? this.provider,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'Name': name,
      'Provider': provider,
      'PhoneNumber': phoneNumber,
    };
  }

  @override
  String toString() {
    return 'AirtimeAndDataBeneficiary{userId: $userId, Name: $name, Provider: $provider, PhoneNumber: $phoneNumber}';
  }
}

class AirtimeRequest {
  String? provider;
  num? amount;
  String? phoneNumber;
  String? transactionPin;
  String? userId;

  AirtimeRequest({
    this.provider,
    this.amount,
    this.phoneNumber,
    this.transactionPin,
    this.userId,
  });

  factory AirtimeRequest.fromJson(Map<String, dynamic> json) {
    return AirtimeRequest(
      provider: json['provider'],
      amount: json['amount'],
      phoneNumber: json['phoneNumber'],
      transactionPin: json['transactionPin'],
      userId: json['userid'],
    );
  }

  AirtimeRequest copyWith({
    String? provider,
    int? amount,
    String? phoneNumber,
    String? transactionPin,
    String? userId,
  }) {
    return AirtimeRequest(
      provider: provider ?? this.provider,
      amount: amount ?? this.amount,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      transactionPin: transactionPin ?? this.transactionPin,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'provider': provider,
      'amount': amount,
      'phoneNumber': phoneNumber,
      'transactionPin': transactionPin,
      'userid': userId,
    };
  }

  @override
  String toString() {
    return 'AirtimeRequest{provider: $provider, amount: $amount, phoneNumber: $phoneNumber, transactionPin: $transactionPin, userId: $userId}';
  }
}
