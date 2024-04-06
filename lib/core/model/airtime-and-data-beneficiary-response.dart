class AirtimeDataBeneficiaryResponse {
  String? sId;
  String? userId;
  String? name;
  String? provider;
  int? phoneNumber;
  int? iV;

  AirtimeDataBeneficiaryResponse(
      {this.sId,
      this.userId,
      this.name,
      this.provider,
      this.phoneNumber,
      this.iV});

  AirtimeDataBeneficiaryResponse.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    name = json['Name'];
    provider = json['Provider'];
    phoneNumber = json['PhoneNumber'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['Name'] = name;
    data['Provider'] = provider;
    data['PhoneNumber'] = phoneNumber;
    data['__v'] = iV;
    return data;
  }
}
