import 'dart:convert';

DropDownOptions dropdownOptionsFromJson(String str) =>
    DropDownOptions.fromJson(json.decode(str));
String dropdownOptionsToJson(DropDownOptions data) =>
    json.encode(data.toJson());

class DropDownOptions {
  Titles? titles;
  Relationship? relationship;
  IdentityOption? identity;
  bool? success;
  String? message;

  DropDownOptions(
      {this.titles,
      this.relationship,
      this.identity,
      this.success = false,
      this.message});

  DropDownOptions.fromJson(Map<String, dynamic> json) {
    titles =
        json['titles'] != null ? new Titles.fromJson(json['titles']) : null;
    relationship = json['relationship'] != null
        ? new Relationship.fromJson(json['relationship'])
        : null;
    identity = json['identity'] != null
        ? new IdentityOption.fromJson(json['identity'])
        : null;
    success = titles != null && identity != null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.titles != null) {
      data['titles'] = this.titles!.toJson();
    }
    if (this.relationship != null) {
      data['relationship'] = this.relationship!.toJson();
    }
    if (this.identity != null) {
      data['identity'] = this.identity!.toJson();
    }
    return data;
  }
}

class Titles {
  List<Title>? title;

  Titles({this.title});

  Titles.fromJson(Map<String, dynamic> json) {
    if (json['title'] != null) {
      title = <Title>[];
      json['title'].forEach((v) {
        title!.add(new Title.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.title != null) {
      data['title'] = this.title!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Title {
  String? tITLECD;
  String? tITLEDSC;

  Title({this.tITLECD, this.tITLEDSC});

  Title.fromJson(Map<String, dynamic> json) {
    tITLECD = json['TITLE_CD'];
    tITLEDSC = json['TITLE_DSC'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TITLE_CD'] = this.tITLECD;
    data['TITLE_DSC'] = this.tITLEDSC;
    return data;
  }
}

class Relationship {
  List<Relation>? relation;

  Relationship({this.relation});

  Relationship.fromJson(Map<String, dynamic> json) {
    if (json['relation'] != null) {
      relation = <Relation>[];
      json['relation'].forEach((v) {
        relation!.add(new Relation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.relation != null) {
      data['relation'] = this.relation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Relation {
  String? rELATIONSHIPCD;
  String? rELATIONSHIPDSC;

  Relation({this.rELATIONSHIPCD, this.rELATIONSHIPDSC});

  Relation.fromJson(Map<String, dynamic> json) {
    rELATIONSHIPCD = json['RELATIONSHIP_CD'];
    rELATIONSHIPDSC = json['RELATIONSHIP_DSC'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RELATIONSHIP_CD'] = this.rELATIONSHIPCD;
    data['RELATIONSHIP_DSC'] = this.rELATIONSHIPDSC;
    return data;
  }
}

class IdentityOption {
  List<Identity>? identityOption;

  IdentityOption({this.identityOption});

  IdentityOption.fromJson(Map<String, dynamic> json) {
    if (json['identity'] != null) {
      identityOption = <Identity>[];
      json['identity'].forEach((v) {
        identityOption!.add(new Identity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.identityOption != null) {
      data['identity'] = this.identityOption!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Identity {
  String? iDENTIFICATIONCD;
  String? iDENTIFICATIONDSC;

  Identity({this.iDENTIFICATIONCD, this.iDENTIFICATIONDSC});

  Identity.fromJson(Map<String, dynamic> json) {
    iDENTIFICATIONCD = json['IDENTIFICATION_CD'];
    iDENTIFICATIONDSC = json['IDENTIFICATION_DSC'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IDENTIFICATION_CD'] = this.iDENTIFICATIONCD;
    data['IDENTIFICATION_DSC'] = this.iDENTIFICATIONDSC;
    return data;
  }
}
