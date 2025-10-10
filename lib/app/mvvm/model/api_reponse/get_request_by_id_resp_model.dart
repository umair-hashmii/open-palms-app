class GetRequestByIdRespModel {
  RequestIdResp? request;
  List<dynamic>? donations;

  GetRequestByIdRespModel({this.request, this.donations});

  GetRequestByIdRespModel.fromJson(Map<String, dynamic> json) {
    request = json['request'] != null ? new RequestIdResp.fromJson(json['request']) : null;
    if (json['donations'] != null) {
      donations = <Null>[];
      // json['donations'].forEach((v) {
      //   donations!.add(new Null.fromJson(v));
      // });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.request != null) {
      data['request'] = this.request!.toJson();
    }
    if (this.donations != null) {
      data['donations'] = this.donations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RequestIdResp {
  String? id;
  String? title;
  String? description;
  String? targetAmount;
  String? status;
  String? category;
  String? priority;
  int? duration;
  List<String>? images;
  String? recipientId;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? updatedAt;
  Recipient? recipient;
  int? currentAmount;
  int? remainingAmount;
  int? progressPercentage;

  RequestIdResp({
    this.id,
    this.title,
    this.description,
    this.targetAmount,
    this.status,
    this.category,
    this.priority,
    this.duration,
    this.images,
    this.recipientId,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.updatedAt,
    this.recipient,
    this.currentAmount,
    this.remainingAmount,
    this.progressPercentage,
  });

  RequestIdResp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    targetAmount = json['targetAmount'];
    status = json['status'];
    category = json['category'];
    priority = json['priority'];
    duration = json['duration'];
    images = json['images'].cast<String>();
    recipientId = json['recipientId'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    recipient = json['recipient'] != null ? new Recipient.fromJson(json['recipient']) : null;
    currentAmount = json['currentAmount'];
    remainingAmount = json['remainingAmount'];
    progressPercentage = json['progressPercentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['targetAmount'] = this.targetAmount;
    data['status'] = this.status;
    data['category'] = this.category;
    data['priority'] = this.priority;
    data['duration'] = this.duration;
    data['images'] = this.images;
    data['recipientId'] = this.recipientId;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.recipient != null) {
      data['recipient'] = this.recipient!.toJson();
    }
    data['currentAmount'] = this.currentAmount;
    data['remainingAmount'] = this.remainingAmount;
    data['progressPercentage'] = this.progressPercentage;
    return data;
  }
}

class Recipient {
  String? id;
  String? firstName;
  String? lastName;
  String? profilePicture;

  Recipient({this.id, this.firstName, this.lastName, this.profilePicture});

  Recipient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    profilePicture = json['profilePicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['profilePicture'] = this.profilePicture;
    return data;
  }
}
