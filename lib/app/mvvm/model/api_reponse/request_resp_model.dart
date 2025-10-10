class RequestRespModel {
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
  int? currentAmount;
  int? remainingAmount;
  int? progressPercentage;
  int? donationCount;

  RequestRespModel({
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
    this.currentAmount,
    this.remainingAmount,
    this.progressPercentage,
    this.donationCount,
  });

  RequestRespModel.fromJson(Map<String, dynamic> json) {
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
    currentAmount = json['currentAmount'];
    remainingAmount = json['remainingAmount'];
    progressPercentage = json['progressPercentage'];
    donationCount = json['donationCount'];
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
    data['currentAmount'] = this.currentAmount;
    data['remainingAmount'] = this.remainingAmount;
    data['progressPercentage'] = this.progressPercentage;
    data['donationCount'] = this.donationCount;
    return data;
  }
}
