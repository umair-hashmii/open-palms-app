import 'dart:io';

class SignUpBodyModel {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  File? profilePicture;
  List<File>? identityImages;
  String? role;
  String? deviceToken;
  String? identityType;

  SignUpBodyModel({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.profilePicture,
    this.identityImages,
    this.role,
    this.deviceToken,
    this.identityType,
  });

  /// Convert model to JSON (for API request)
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (firstName != null) data['firstName'] = firstName;
    if (lastName != null) data['lastName'] = lastName;
    if (email != null) data['email'] = email;
    if (password != null) data['password'] = password;
    if (role != null) data['role'] = role;
    if (deviceToken != null) data['device_token'] = deviceToken;
    if (identityType != null) data['identityType'] = identityType;
    if (profilePicture != null) data['profilePicture'] = profilePicture!.path;
    if (identityImages != null && identityImages!.isNotEmpty) {
      data['identityImages'] = identityImages!.map((file) => file.path).toList();
    }

    return data;
  }

  /// Create model from JSON (for parsing API response)
  factory SignUpBodyModel.fromJson(Map<String, dynamic> json) {
    return SignUpBodyModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
      deviceToken: json['device_token'],
      identityType: json['identityType'],
      profilePicture: json['profilePicture'] != null ? File(json['profilePicture']) : null,
      identityImages: json['identityImages'] != null ? List<File>.from((json['identityImages'] as List).map((path) => File(path))) : null,
    );
  }
}
