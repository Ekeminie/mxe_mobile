import 'dart:convert';

GetUserResponse userResModelFromJson(String str) =>
    GetUserResponse.fromJson(json.decode(str));
String userModelToJson(GetUserResponse data) => json.encode(data.toJson());

String userModelDataToString(dynamic data) => json.encode(data);
dynamic userModelDataToJson(String data) => json.decode(data);

class GetUserResponse {
  User? data;
  int? statusCode;
  String? status;
  String? message;
  bool? success;
  GetUserResponse(
      {this.data,
      this.statusCode,
      this.status,
      this.message,
      this.success = false});

  GetUserResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? User.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
    status = json['status'];
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['user'] = this.data!.toJson();
    }
    data['statusCode'] = statusCode;
    data['status'] = status;
    data['message'] = message;
    data['success'] = success;
    return data;
  }
}

UserRes userFromJson(String str) => UserRes.fromJson(json.decode(str));
String userToJson(UserRes data) => json.encode(data.toJson());

String userDataToString(dynamic data) => json.encode(data);
dynamic userDataToJson(String data) => json.decode(data);

class UserRes {
  User? user;

  UserRes({this.user});

  UserRes.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

User userOnlyModelFromJson(String str) => User.fromJson(json.decode(str));
String userOnlyModelToJson(User data) => json.encode(data.toJson());

String userOnlyModelDataToString(dynamic data) => json.encode(data);
dynamic userOnlyModelDataToJson(String data) => json.decode(data);

// Main class for the user data
class User {
  // Properties based on the JSON structure
  final String? id;
  final String? phoneNumber;
  final String? role;
  final String? uniqueVerificationCode;
  final bool? blocked;
  final int? passwordRetries;
  final String? verificationCodeExpiration;
  final int? walletBalance;
  final String? profileImageUrl;
  final bool? allowPushNotifications;
  final bool? allowSmsNotifications;
  final bool? allowEmailNotifications;
  final bool? displayWalletBalance;
  final int? v; // Assuming __v is an internal version field
  final bool? status;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? password;
  final String? MXETag;

  // Constructor matching the JSON structure
  User({
    this.id,
    this.phoneNumber,
    this.role,
    this.uniqueVerificationCode,
    this.blocked,
    this.passwordRetries,
    this.verificationCodeExpiration,
    this.walletBalance,
    this.profileImageUrl,
    this.allowPushNotifications,
    this.allowSmsNotifications,
    this.allowEmailNotifications,
    this.displayWalletBalance,
    this.v,
    this.status,
    this.email,
    this.firstName,
    this.lastName,
    this.password,
    this.MXETag,
  });

  // Factory constructor to create UserData from a JSON map
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      phoneNumber: json['phoneNumber'],
      role: json['role'],
      uniqueVerificationCode: json['uniqueVerificationCode'],
      blocked: json['blocked'],
      passwordRetries: json['passwordRetries'],
      verificationCodeExpiration: json['verificationCodeExpiration'],
      walletBalance: json['walletBalance'],
      profileImageUrl: json['profileImageUrl'],
      allowPushNotifications: json['allowPushNotifications'],
      allowSmsNotifications: json['allowSmsNotifications'],
      allowEmailNotifications: json['allowEmailNotifications'],
      displayWalletBalance: json['displayWalletBalance'],
      v: json['__v'],
      status: json['status'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      password: json['password'],
      MXETag: json['MXETag'],
    );
  }

  String? get fullName => "$firstName $lastName";
  // Method to create a copy of UserData with updated properties
  User copyWith({
    String? id,
    String? phoneNumber,
    String? role,
    String? uniqueVerificationCode,
    bool? blocked,
    int? passwordRetries,
    String? verificationCodeExpiration,
    int? walletBalance,
    String? profileImageUrl,
    bool? allowPushNotifications,
    bool? allowSmsNotifications,
    bool? allowEmailNotifications,
    bool? displayWalletBalance,
    int? v,
    bool? status,
    String? email,
    String? firstName,
    String? lastName,
    String? password,
    String? MXETag,
  }) {
    return User(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      uniqueVerificationCode:
          uniqueVerificationCode ?? this.uniqueVerificationCode,
      blocked: blocked ?? this.blocked,
      passwordRetries: passwordRetries ?? this.passwordRetries,
      verificationCodeExpiration:
          verificationCodeExpiration ?? this.verificationCodeExpiration,
      walletBalance: walletBalance ?? this.walletBalance,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      allowPushNotifications:
          allowPushNotifications ?? this.allowPushNotifications,
      allowSmsNotifications:
          allowSmsNotifications ?? this.allowSmsNotifications,
      allowEmailNotifications:
          allowEmailNotifications ?? this.allowEmailNotifications,
      displayWalletBalance: displayWalletBalance ?? this.displayWalletBalance,
      v: v ?? this.v,
      status: status ?? this.status,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      password: password ?? this.password,
      MXETag: MXETag ?? this.MXETag,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phoneNumber': phoneNumber,
      'role': role,
      'uniqueVerificationCode': uniqueVerificationCode,
      'blocked': blocked,
      'passwordRetries': passwordRetries,
      'verificationCodeExpiration': verificationCodeExpiration,
      'walletBalance': walletBalance,
      'profileImageUrl': profileImageUrl,
      'allowPushNotifications': allowPushNotifications,
      'allowSmsNotifications': allowSmsNotifications,
      'allowEmailNotifications': allowEmailNotifications,
      'displayWalletBalance': displayWalletBalance,
      'v': v,
      'status': status,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
      'MXETag': MXETag,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, phoneNumber: $phoneNumber, role: $role, uniqueVerificationCode: $uniqueVerificationCode, blocked: $blocked, passwordRetries: $passwordRetries, verificationCodeExpiration: $verificationCodeExpiration, walletBalance: $walletBalance, profileImageUrl: $profileImageUrl, allowPushNotifications: $allowPushNotifications, allowSmsNotifications: $allowSmsNotifications, allowEmailNotifications: $allowEmailNotifications, displayWalletBalance: $displayWalletBalance, v: $v, status: $status, email: $email, firstName: $firstName, lastName: $lastName, password: $password, MXETag: $MXETag}';
  }
}
