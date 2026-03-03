class NotificationModel {
  final String id;
  final String user;
  final String title;
  final String message;
  final bool isRead;
  final DateTime date;

  NotificationModel({
    required this.id,
    required this.user,
    required this.title,
    required this.message,
    required this.isRead,
    required this.date,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['_id'] ?? "",
      user: json['user'] ?? "",
      title: json['title'] ?? "",
      message: json['message'] ?? "",
      isRead: json['isRead'] ?? false,
      date: json['createdAt'] != null
          ? DateTime.parse(json['createdAt']).toLocal()
          : DateTime.now(),
    );
  }
}
