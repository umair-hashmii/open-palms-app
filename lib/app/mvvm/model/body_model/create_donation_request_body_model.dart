import 'dart:io';

class CreateDonationRequestBodyModel {
  String? title;
  String? description;
  String? targetAmount;
  String? category;
  String? priority;
  String? duration;
  List<File>? images;

  CreateDonationRequestBodyModel({this.title, this.description, this.targetAmount, this.category, this.priority, this.duration, this.images});

  /// Convert model to JSON (for API request)
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (title != null) data['title'] = title;
    if (description != null) data['description'] = description;
    if (targetAmount != null) data['targetAmount'] = targetAmount;
    if (category != null) data['category'] = category;
    if (priority != null) data['priority'] = priority;
    if (duration != null) data['duration'] = duration;
    if (images != null && images!.isNotEmpty) {
      data['images'] = images!.map((file) => file.path).toList();
    }

    return data;
  }

  /// Create model from JSON (for parsing API response)
  factory CreateDonationRequestBodyModel.fromJson(Map<String, dynamic> json) {
    return CreateDonationRequestBodyModel(
      title: json['title'],
      description: json['description'],
      targetAmount: json['targetAmount'],
      category: json['category'],
      priority: json['priority'],
      duration: json['duration'],
      images: json['images'] != null ? List<File>.from((json['images'] as List).map((path) => File(path))) : null,
    );
  }
}
