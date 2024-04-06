import 'dart:convert';

NotificationResponse notificationModelFromJson(String str) =>
    NotificationResponse.fromJson(json.decode(str));
String notificationModelToJson(NotificationResponse data) =>
    json.encode(data.toJson());

String notificationModelDataToString(dynamic data) => json.encode(data);
dynamic notificationModelDataToJson(String data) => json.decode(data);

class NotificationResponse {
  bool? success;
  String? message;
  int? code;
  List<NotificationModel>? data;

  NotificationResponse({this.success, this.message, this.code, this.data});

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    code = json['code'];
    if (json['data'] != null) {
      data = <NotificationModel>[];
      json['data'].forEach((v) {
        data!.add(NotificationModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationModel {
  String? sId;
  String? userId;
  String? subject;
  String? message;
  String? status;
  int? amount;
  String? transactionType;
  bool? isRead;
  String? creationDate;
  int? iV;

  NotificationModel(
      {this.sId,
      this.userId,
      this.subject,
      this.message,
      this.status,
      this.amount,
      this.transactionType,
      this.isRead,
      this.creationDate,
      this.iV});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    subject = json['subject'];
    message = json['message'];
    status = json['status'];
    amount = json['Amount'];
    transactionType = json['TransactionType'];
    isRead = json['isRead'];
    creationDate = json['CreationDate'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['subject'] = subject;
    data['message'] = message;
    data['status'] = status;
    data['Amount'] = amount;
    data['TransactionType'] = transactionType;
    data['isRead'] = isRead;
    data['CreationDate'] = creationDate;
    data['__v'] = iV;
    return data;
  }
}
