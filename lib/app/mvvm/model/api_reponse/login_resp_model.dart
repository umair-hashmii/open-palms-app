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
  String? firstName;
  String? lastName;
  String? email;
  String? identityType;
  List<String>? identityPicture;
  String? profilePicture;
  bool? emailVerified;
  String? emailVerificationToken;
  String? emailVerificationExpires;
  String? passwordResetToken;
  String? passwordResetExpires;
  bool? identityVerified;
  String? identityVerificationStatus;
  String? identityRejectionReason;
  String? fcmToken;
  String? role;
  String? stripeCustomerId;
  String? stripeAccountId;
  bool? stripeOnboardingComplete;
  bool? isBlocked;
  bool? isDeactivated;
  String? reactivationToken;
  String? reactivationTokenExpires;
  String? createdAt;
  String? updatedAt;
  UserStatistics? statistics;
  StripeStatus? stripeStatus;

  AppUser({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.identityType,
    this.identityPicture,
    this.profilePicture,
    this.emailVerified,
    this.emailVerificationToken,
    this.emailVerificationExpires,
    this.passwordResetToken,
    this.passwordResetExpires,
    this.identityVerified,
    this.identityVerificationStatus,
    this.identityRejectionReason,
    this.fcmToken,
    this.role,
    this.stripeCustomerId,
    this.stripeAccountId,
    this.stripeOnboardingComplete,
    this.isBlocked,
    this.isDeactivated,
    this.reactivationToken,
    this.reactivationTokenExpires,
    this.createdAt,
    this.updatedAt,
    this.statistics,
    this.stripeStatus,
  });

  AppUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    identityType = json['identityType'];
    identityPicture = json['identityPicture'] != null ? List<String>.from(json['identityPicture']) : [];
    profilePicture = json['profilePicture'];
    emailVerified = json['emailVerified'];
    emailVerificationToken = json['emailVerificationToken'];
    emailVerificationExpires = json['emailVerificationExpires'];
    passwordResetToken = json['passwordResetToken'];
    passwordResetExpires = json['passwordResetExpires'];
    identityVerified = json['identityVerified'];
    identityVerificationStatus = json['identityVerificationStatus'];
    identityRejectionReason = json['identityRejectionReason'];
    fcmToken = json['fcmToken'];
    role = json['role'];
    stripeCustomerId = json['stripeCustomerId'];
    stripeAccountId = json['stripeAccountId'];
    stripeOnboardingComplete = json['stripeOnboardingComplete'];
    isBlocked = json['isBlocked'];
    isDeactivated = json['isDeactivated'];
    reactivationToken = json['reactivationToken'];
    reactivationTokenExpires = json['reactivationTokenExpires'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    statistics = json['statistics'] != null ? UserStatistics.fromJson(json['statistics']) : null;
    stripeStatus = json['stripeStatus'] != null ? StripeStatus.fromJson(json['stripeStatus']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['identityType'] = identityType;
    data['identityPicture'] = identityPicture;
    data['profilePicture'] = profilePicture;
    data['emailVerified'] = emailVerified;
    data['emailVerificationToken'] = emailVerificationToken;
    data['emailVerificationExpires'] = emailVerificationExpires;
    data['passwordResetToken'] = passwordResetToken;
    data['passwordResetExpires'] = passwordResetExpires;
    data['identityVerified'] = identityVerified;
    data['identityVerificationStatus'] = identityVerificationStatus;
    data['identityRejectionReason'] = identityRejectionReason;
    data['fcmToken'] = fcmToken;
    data['role'] = role;
    data['stripeCustomerId'] = stripeCustomerId;
    data['stripeAccountId'] = stripeAccountId;
    data['stripeOnboardingComplete'] = stripeOnboardingComplete;
    data['isBlocked'] = isBlocked;
    data['isDeactivated'] = isDeactivated;
    data['reactivationToken'] = reactivationToken;
    data['reactivationTokenExpires'] = reactivationTokenExpires;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (statistics != null) {
      data['statistics'] = statistics!.toJson();
    }
    if (stripeStatus != null) {
      data['stripeStatus'] = stripeStatus!.toJson();
    }
    return data;
  }
}

class UserStatistics {
  int? totalReceived;
  int? totalWithdrawn;
  int? availableBalance;
  int? requestCount;
  int? completedRequests;

  UserStatistics({this.totalReceived, this.totalWithdrawn, this.availableBalance, this.requestCount, this.completedRequests});

  UserStatistics.fromJson(Map<String, dynamic> json) {
    totalReceived = json['totalReceived'];
    totalWithdrawn = json['totalWithdrawn'];
    availableBalance = json['availableBalance'];
    requestCount = json['requestCount'];
    completedRequests = json['completedRequests'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['totalReceived'] = totalReceived;
    data['totalWithdrawn'] = totalWithdrawn;
    data['availableBalance'] = availableBalance;
    data['requestCount'] = requestCount;
    data['completedRequests'] = completedRequests;
    return data;
  }
}

class StripeStatus {
  bool? hasAccount;
  bool? onboardingComplete;
  String? accountId;

  StripeStatus({this.hasAccount, this.onboardingComplete, this.accountId});

  StripeStatus.fromJson(Map<String, dynamic> json) {
    hasAccount = json['hasAccount'];
    onboardingComplete = json['onboardingComplete'];
    accountId = json['accountId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['hasAccount'] = hasAccount;
    data['onboardingComplete'] = onboardingComplete;
    data['accountId'] = accountId;
    return data;
  }
}
