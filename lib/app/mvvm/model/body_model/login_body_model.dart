class LoginBodyModel {
  final String? email;
  final String? password;
  final String? role;
  final String? deviceToken;

  LoginBodyModel({this.role, this.password, this.deviceToken, this.email});

  Map<String, dynamic> toJson() {
    return {'email': email, 'role': role, 'password': password, 'device_token': deviceToken};
  }
}
