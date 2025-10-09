class LoginResponseModel {
  AppUser? user;
  String? token;

  LoginResponseModel({this.user, this.token});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new AppUser.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class AppUser {
  String? id;
  bool? emailVerified;
  bool? identityVerified;
  bool? stripeOnboardingComplete;
  String? firstName;
  String? lastName;
  String? email;
  String? role;
  String? profilePicture;
  String? emailVerificationExpires;
  String? updatedAt;
  String? createdAt;
  Null? identityType;
  Null? identityPicture;
  Null? passwordResetToken;
  Null? passwordResetExpires;
  Null? fcmToken;
  Null? stripeCustomerId;
  Null? stripeAccountId;

  AppUser({
    this.id,
    this.emailVerified,
    this.identityVerified,
    this.stripeOnboardingComplete,
    this.firstName,
    this.lastName,
    this.email,
    this.role,
    this.profilePicture,
    this.emailVerificationExpires,
    this.updatedAt,
    this.createdAt,
    this.identityType,
    this.identityPicture,
    this.passwordResetToken,
    this.passwordResetExpires,
    this.fcmToken,
    this.stripeCustomerId,
    this.stripeAccountId,
  });

  AppUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    emailVerified = json['emailVerified'];
    identityVerified = json['identityVerified'];
    stripeOnboardingComplete = json['stripeOnboardingComplete'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    role = json['role'];
    profilePicture = json['profilePicture'];
    emailVerificationExpires = json['emailVerificationExpires'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    identityType = json['identityType'];
    identityPicture = json['identityPicture'];
    passwordResetToken = json['passwordResetToken'];
    passwordResetExpires = json['passwordResetExpires'];
    fcmToken = json['fcmToken'];
    stripeCustomerId = json['stripeCustomerId'];
    stripeAccountId = json['stripeAccountId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['emailVerified'] = this.emailVerified;
    data['identityVerified'] = this.identityVerified;
    data['stripeOnboardingComplete'] = this.stripeOnboardingComplete;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['role'] = this.role;
    data['profilePicture'] = this.profilePicture;
    data['emailVerificationExpires'] = this.emailVerificationExpires;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    data['identityType'] = this.identityType;
    data['identityPicture'] = this.identityPicture;
    data['passwordResetToken'] = this.passwordResetToken;
    data['passwordResetExpires'] = this.passwordResetExpires;
    data['fcmToken'] = this.fcmToken;
    data['stripeCustomerId'] = this.stripeCustomerId;
    data['stripeAccountId'] = this.stripeAccountId;
    return data;
  }
}
