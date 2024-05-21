class NotificationModel {
  int? id;
  String title;
  String description;
  String image;
  String dateTime;
  bool isRead;

  NotificationModel({
    this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.dateTime,
    this.isRead = false,
  });

  NotificationModel copyWith({
    int? id,
    String? title,
    String? description,
    String? image,
    String? dateTime,
    bool? isRead,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      isRead: isRead ?? this.isRead,
    );
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json["_id"] as int? ?? 0,
      title: json["title"] as String? ?? "",
      image: json["image"] as String? ?? "",
      description: json["description"] as String? ?? "",
      dateTime: json["dateTime"] as String? ?? "",
      isRead: (json["isRead"] as int? ?? 1) == 1,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "image": image,
      "description": description,
      "dateTime": dateTime,
      "isRead": isRead,
    };
  }
}
