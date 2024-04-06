class CardModel {
  String? sId;
  String? userId;
  String? nameOncard;
  String? cardColor;
  String? design;
  bool? freezeStatus;
  String? dateCreated;
  int? iV;

  CardModel(
      {this.sId,
      this.userId,
      this.nameOncard,
      this.cardColor,
      this.design,
      this.freezeStatus,
      this.dateCreated,
      this.iV});

  CardModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    nameOncard = json['NameOncard'];
    cardColor = json['CardColor'];
    design = json['Design'];
    freezeStatus = json['FreezeStatus'];
    dateCreated = json['DateCreated'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['NameOncard'] = nameOncard;
    data['CardColor'] = cardColor;
    data['Design'] = design;
    data['FreezeStatus'] = freezeStatus;
    data['DateCreated'] = dateCreated;
    data['__v'] = iV;
    return data;
  }
}
