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
  String? identityType;
  String? identityPicture;
  String? passwordResetToken;
  String? passwordResetExpires;
  String? fcmToken;
  String? stripeCustomerId;
  String? stripeAccountId;
  String? emailVerificationToken;
  UserStatistics? statistics;

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
    this.emailVerificationToken,
    this.statistics,
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
    emailVerificationToken = json['emailVerificationToken'];
    statistics = json['statistics'] != null ? UserStatistics.fromJson(json['statistics']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['emailVerified'] = emailVerified;
    data['identityVerified'] = identityVerified;
    data['stripeOnboardingComplete'] = stripeOnboardingComplete;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['role'] = role;
    data['profilePicture'] = profilePicture;
    data['emailVerificationExpires'] = emailVerificationExpires;
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    data['identityType'] = identityType;
    data['identityPicture'] = identityPicture;
    data['passwordResetToken'] = passwordResetToken;
    data['passwordResetExpires'] = passwordResetExpires;
    data['fcmToken'] = fcmToken;
    data['stripeCustomerId'] = stripeCustomerId;
    data['stripeAccountId'] = stripeAccountId;
    data['emailVerificationToken'] = emailVerificationToken;
    if (statistics != null) {
      data['statistics'] = statistics!.toJson();
    }
    return data;
  }
}

class UserStatistics {
  int? totalDonated;
  int? donationCount;
  dynamic currentSubscription;

  UserStatistics({this.totalDonated, this.donationCount, this.currentSubscription});

  UserStatistics.fromJson(Map<String, dynamic> json) {
    totalDonated = json['totalDonated'];
    donationCount = json['donationCount'];
    currentSubscription = json['currentSubscription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['totalDonated'] = totalDonated;
    data['donationCount'] = donationCount;
    data['currentSubscription'] = currentSubscription;
    return data;
  }
}
