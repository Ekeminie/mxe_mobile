import 'package:flutter/cupertino.dart';

class UserData {
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? email;
  final String? deviceId;
  final String? profileImageUrl;
  final bool? status;
  final bool? allowPushNotifications;
  final bool? allowSmsNotifications;
  final bool? allowEmailNotifications;
  final bool? displayWalletBalance;
  final String? password;

  UserData({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.deviceId,
    this.profileImageUrl,
    this.status,
    this.allowPushNotifications,
    this.allowSmsNotifications,
    this.allowEmailNotifications,
    this.displayWalletBalance,
    this.password,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      deviceId: json['deviceId'],
      profileImageUrl: json['profileImageUrl'],
      status: json['status'],
      allowPushNotifications: json['allowPushNotifications'],
      allowSmsNotifications: json['allowSmsNotifications'],
      allowEmailNotifications: json['allowEmailNotifications'],
      displayWalletBalance: json['displayWalletBalance'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'email': email,
      'deviceId': deviceId,
      'profileImageUrl': profileImageUrl,
      'status': status,
      'allowPushNotifications': allowPushNotifications,
      'allowSmsNotifications': allowSmsNotifications,
      'allowEmailNotifications': allowEmailNotifications,
      'displayWalletBalance': displayWalletBalance,
      'password': password,
    };

    // Remove properties with null values
    json.removeWhere((key, value) => value == null);
    debugPrint(json.toString());
    return json;
  }

  UserData copyWith({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? email,
    String? deviceId,
    String? profileImageUrl,
    bool? status,
    bool? allowPushNotifications,
    bool? allowSmsNotifications,
    bool? allowEmailNotifications,
    bool? displayWalletBalance,
    String? password,
  }) {
    return UserData(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      deviceId: deviceId ?? this.deviceId,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      status: status ?? this.status,
      allowPushNotifications:
          allowPushNotifications ?? this.allowPushNotifications,
      allowSmsNotifications:
          allowSmsNotifications ?? this.allowSmsNotifications,
      allowEmailNotifications:
          allowEmailNotifications ?? this.allowEmailNotifications,
      displayWalletBalance: displayWalletBalance ?? this.displayWalletBalance,
      password: password ?? this.password,
    );
  }
}
