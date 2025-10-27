class GetSettingsResp {
  String? key;
  String? content;
  String? updatedAt;
  String? createdAt;

  GetSettingsResp({this.key, this.content, this.updatedAt, this.createdAt});

  GetSettingsResp.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    content = json['content'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['content'] = this.content;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
