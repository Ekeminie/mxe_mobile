class LoginRequest {
  final String? email;
  final String? password;
  LoginRequest({this.email, this.password});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'LoginRequest{email: $email, password: $password}';
  }
}

class SignUpRequest {
  final String? email;
  final String? password;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? refCode;
  SignUpRequest(
      {this.email,
      this.password,
      this.phone,
      this.lastName,
      this.firstName,
      this.refCode});

  Map<String, dynamic> toMap() {
    return {
      'username': "${firstName?.toLowerCase()}-${lastName?.toLowerCase()}",
      'firstname': firstName,
      'lastname': lastName,
      'othername': "",
      'email': email,
      'phonenumber': phone,
      'password': password,
      'verifypassword': password,
    };
  }

  @override
  String toString() {
    return 'SignUpRequest{email: $email, password: $password, firstName: $firstName, lastName: $lastName, phone: $phone, refCode:$refCode}';
  }
}

class UpdatePasswordRequest {
  final String? email;
  final String? password;
  final String? confirmPassword;
  UpdatePasswordRequest({this.email, this.password, this.confirmPassword});

  Map<String, dynamic> toMap() {
    return {
      'email': email?.trim(),
      'password': password?.trim(),
      'confirmPassword': confirmPassword?.trim()
    };
  }

  factory UpdatePasswordRequest.fromMap(Map<String, dynamic> map) {
    return UpdatePasswordRequest(
        email: map['email'] as String,
        password: map['password'] as String,
        confirmPassword: map['confirmPassword'] as String);
  }

  @override
  String toString() {
    return 'UpdatePasswordRequest{email: $email, password: $password, confirmPassword: $confirmPassword}';
  }
}
