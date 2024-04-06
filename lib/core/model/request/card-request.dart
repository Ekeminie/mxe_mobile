class CreateCardReq {
  String? userId;
  String? nameOnCard;
  String? cardColor;
  String? design;

  CreateCardReq({
    this.userId,
    this.nameOnCard,
    this.cardColor,
    this.design,
  });

  factory CreateCardReq.fromJson(Map<String, dynamic> json) {
    return CreateCardReq(
      userId: json['userId'],
      nameOnCard: json['NameOnCard'],
      cardColor: json['CardColor'],
      design: json['Design'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'NameOncard': nameOnCard,
      'CardColor': cardColor,
      'Design': design,
    };
  }

  CreateCardReq copyWith({
    String? userId,
    String? nameOnCard,
    String? cardColor,
    String? design,
  }) {
    return CreateCardReq(
      userId: userId ?? this.userId,
      nameOnCard: nameOnCard ?? this.nameOnCard,
      cardColor: cardColor ?? this.cardColor,
      design: design ?? this.design,
    );
  }

  @override
  String toString() {
    return 'CreditCard{userId: $userId, nameOnCard: $nameOnCard, cardColor: $cardColor, design: $design}';
  }
}
