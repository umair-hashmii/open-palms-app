class ExpressAccountResp {
  String? onboardingUrl;

  ExpressAccountResp({this.onboardingUrl});

  ExpressAccountResp.fromJson(Map<String, dynamic> json) {
    onboardingUrl = json['onboardingUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['onboardingUrl'] = this.onboardingUrl;
    return data;
  }
}
